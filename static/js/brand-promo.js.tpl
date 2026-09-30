(function () {
    var root = document.querySelector('[data-brand-promo]');
    if (!root) return;
    var rail = root.querySelector('#promo-bestsellers');
    var controls = root.querySelector('[data-carousel-controls]');
    if (!rail || !controls) return;
    var previous = controls.querySelector('[data-carousel-prev]');
    var next = controls.querySelector('[data-carousel-next]');
    var reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
    function update() {
        var end = rail.scrollWidth - rail.clientWidth;
        controls.hidden = end < 2;
        previous.disabled = rail.scrollLeft < 2;
        next.disabled = rail.scrollLeft >= end - 2;
    }
    function move(direction) {
        var card = rail.firstElementChild;
        var step = card.getBoundingClientRect().width + parseFloat(getComputedStyle(rail).columnGap || 0);
        rail.scrollBy({ left: direction * step, behavior: reducedMotion.matches ? 'auto' : 'smooth' });
    }
    previous.addEventListener('click', function () { move(-1); });
    next.addEventListener('click', function () { move(1); });
    rail.addEventListener('scroll', update, { passive: true });
    rail.addEventListener('keydown', function (event) {
        if (event.target !== rail) return;
        if (event.key === 'ArrowRight' || event.key === 'ArrowLeft') {
            event.preventDefault();
            move(event.key === 'ArrowRight' ? 1 : -1);
        }
    });
    if ('ResizeObserver' in window) new ResizeObserver(update).observe(rail);
    else window.addEventListener('resize', update);
    update();
}());
