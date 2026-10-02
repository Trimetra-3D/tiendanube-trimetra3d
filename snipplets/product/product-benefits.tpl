{% set warranty_12_months = include('snipplets/custom-pages/business-facts.tpl', { mode: 'warranty_12_months' }) | trim %}
{% set warranty_6_months = include('snipplets/custom-pages/business-facts.tpl', { mode: 'warranty_6_months' }) | trim %}
{% set warranty_3_months = include('snipplets/custom-pages/business-facts.tpl', { mode: 'warranty_3_months' }) | trim %}

<aside class="product-benefits" aria-label="{{ 'Garantía y devoluciones' | translate }}">
    <div class="product-benefit">
        <span class="product-benefit-icon" aria-hidden="true">
            {% include 'snipplets/svg/security.tpl' with {svg_custom_class: 'icon-inline'} %}
        </span>
        <span class="product-benefit-copy">
            <strong>{{ 'Garantía y soporte Trimetra' | translate }}</strong>
            <span> · {{ 'Cobertura de' | translate }} {{ warranty_12_months }}, {{ warranty_6_months }} {{ 'o' | translate }} {{ warranty_3_months }} {{ 'meses según componente.' | translate }}</span>
        </span>
    </div>
    <div class="product-benefit">
        <span class="product-benefit-icon" aria-hidden="true">
            {% include 'snipplets/svg/returns.tpl' with {svg_custom_class: 'icon-inline'} %}
        </span>
        <span class="product-benefit-copy">
            <strong>{{ 'Cambios y devoluciones' | translate }}</strong>
            <span> · {{ 'Consultá las condiciones y los plazos vigentes.' | translate }}</span>
        </span>
    </div>
</aside>
