/* Toluca adapter: Mova's aggregate config supplies FX through a dedicated hidden SDK slot.
 * Native effective ARS is never rewritten; no discounts, LS currency or cart prices are changed. */
(function () {
    function initializeProductCurrency(root) {
        if (root.__productCurrencyDispose) root.__productCurrencyDispose();
        var feed = root.querySelector('[data-product-currency-feed]');
        var toggle = root.querySelector('[data-product-currency-toggle]');
        var usd = root.querySelector('[data-product-currency-usd]');
        var card = root.querySelector('.product-cash-discount');
        if (!feed || !toggle || !usd || !card) return;
        var quote = null, deadline = 0, timer, currency = 'ARS', lastFeed = '';
        var formatter = new Intl.NumberFormat('es-AR', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        function source() {
            if (feed.dataset.storeCurrency !== 'ARS' || getComputedStyle(card).display === 'none') return null;
            var native = card.querySelector('.js-payment-discount-price-product');
            if (!native) return null;
            var raw = native.getAttribute('data-priceraw-without-shipping');
            if (!/^\d+$/.test(raw || '')) return null;
            var cents = Number(raw);
            // Fail closed during asynchronous native updates: attribute and visible ARS must agree.
            var visible = native.textContent.replace(/\s|\$/g, '');
            if (!/^(?:\d+|\d{1,3}(?:\.\d{3})+),\d{2}$/.test(visible)) return null;
            var shown = Number(visible.replace(/\./g, '').replace(',', '.'));
            return Number.isSafeInteger(cents) && cents > 0 && Math.round(shown * 100) === cents ? cents : null;
        }
        function render() {
            var cents = source();
            var ready = quote && performance.now() < deadline && cents !== null;
            if (!ready) currency = 'ARS';
            toggle.hidden = !ready;
            usd.hidden = !ready || currency !== 'USD';
            card.classList.toggle('product-currency-is-usd', !!ready && currency === 'USD');
            toggle.querySelectorAll('button').forEach(function (button) {button.setAttribute('aria-pressed', String(button.dataset.productCurrency === currency));});
            if (ready) {
                var amount = 'US$ ' + formatter.format(cents / 100 / quote.arsPerUsd);
                if (usd.textContent !== amount) usd.textContent = amount;
                toggle.title = 'Equivalente informativo · BNA Billetes · Dólar U.S.A. Compra · ' +
                    new Intl.DateTimeFormat('es-AR',{timeZone:'America/Argentina/Buenos_Aires',dateStyle:'short',timeStyle:'short'}).format(new Date(quote.quotedAt)) +
                    '. Carrito y checkout permanecen en ARS.';
            }
        }
        function readFeed() {
            var text = feed.textContent.trim();
            if (text === lastFeed) return;
            lastFeed = text; quote = null; clearTimeout(timer);
            try {
                var payload = JSON.parse(text), q = payload.quote;
                var remaining = payload.remainingMs;
                var quoted = Date.parse(q.quotedAt), fetched = Date.parse(q.fetchedAt), until = Date.parse(q.validUntil);
                if (payload.version !== 1 || String(payload.productId) !== feed.dataset.productId ||
                    q.source !== 'BNA' || q.market !== 'billetes' || q.currency !== 'USD' || q.side !== 'compra' ||
                    !Number.isFinite(q.arsPerUsd) || q.arsPerUsd <= 0 ||
                    !Number.isFinite(quoted) || !Number.isFinite(fetched) || !Number.isFinite(until) ||
                    quoted > fetched + 300000 || until <= fetched || until - fetched > 300000 || until - quoted > 96 * 3600000 ||
                    !Number.isFinite(remaining) || remaining <= 0 || remaining > 65000) throw new Error('Invalid quote');
                // Reinitialization must not grant an old DOM payload a new freshness lease.
                var receipt = feed.__movaCurrencyReceipt;
                if (!receipt || receipt.text !== text) {
                    receipt = {text: text, deadline: performance.now() + remaining};
                    feed.__movaCurrencyReceipt = receipt;
                }
                quote = q; deadline = receipt.deadline;
                timer = setTimeout(function () {quote = null;render();}, Math.max(0, Math.ceil(deadline - performance.now())));
            } catch (error) { /* Fail closed; native ARS stays usable. */ }
            render();
        }
        function select(event) {
            var button = event.target.closest('[data-product-currency]');
            if (!button || !toggle.contains(button)) return;
            currency = button.dataset.productCurrency === 'USD' ? 'USD' : 'ARS';render();
        }
        var quoteObserver = new MutationObserver(readFeed);
        quoteObserver.observe(feed,{childList:true,subtree:true,characterData:true});
        var priceObserver = new MutationObserver(render);
        priceObserver.observe(card,{subtree:true,childList:true,characterData:true,attributes:true,attributeFilter:['data-priceraw-without-shipping','style']});
        toggle.addEventListener('click',select);
        root.__productCurrencyDispose = function () {quoteObserver.disconnect();priceObserver.disconnect();clearTimeout(timer);toggle.removeEventListener('click',select);quote=null;render();};
        readFeed();render();
    }
    window.initializeProductCurrency = initializeProductCurrency;
    document.querySelectorAll('.single-product-page').forEach(initializeProductCurrency);
})();
