{# Informational representation only. Native payment-discount price remains the source. #}
<span class="product-currency-usd" data-product-currency-usd hidden aria-live="polite"></span>
<span class="product-currency-toggle" data-product-currency-toggle hidden role="group" aria-label="{{ 'Moneda informativa' | translate }}">
    <button type="button" data-product-currency="ARS" aria-pressed="true">ARS</button>
    <button type="button" data-product-currency="USD" aria-pressed="false">USD</button>
</span>
<div hidden data-product-currency-feed data-product-id="{{ product.id }}" data-store-currency="{{ store.currency }}">
    {{ component('nubesdk-slot', { type: "custom_product_currency_quote" }) }}
</div>
