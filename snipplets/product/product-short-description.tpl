{% set product_short_description = product.metafields.trimetra.short_description | default('') | trim %}

{% if product_short_description %}
    <section class="product-short-description" data-store="product-short-description-{{ product.id }}">
        <h2 class="product-short-description__title">{{ 'Sobre este producto' | translate }}</h2>
        <div class="product-short-description__content">{{ product_short_description }}</div>
    </section>
{% endif %}
