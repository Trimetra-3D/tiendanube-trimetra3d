<div id="single-product" class="single-product-page js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container background-secondary pb-4" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="single-product-shell">
        <div class="single-product-breadcrumbs">
            {% include 'snipplets/breadcrumbs.tpl' %}
        </div>

        <div class="single-product-layout">
            <div class="single-product-gallery pb-3">
                {% include 'snipplets/product/product-image.tpl' %}
            </div>
            <div class="single-product-info" data-store="product-info-{{ product.id }}">
                {% include 'snipplets/product/product-form.tpl' %}
                {% include 'snipplets/product/product-short-description.tpl' %}
                {% include 'snipplets/product/product-benefits.tpl' %}
            </div>
        </div>

        {% if complementary_product_list | length > 0 %}
            {% include 'snipplets/product/product-complementary-overview.tpl' %}
        {% endif %}

        {% include 'snipplets/product/product-videos.tpl' %}

        {% if product.description is not empty or settings.show_product_fb_comment_box %}
            <div class="single-product-long-description">
                {% include 'snipplets/product/product-description.tpl' %}
            </div>
        {% endif %}
    </div>
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' with {complementary_overview_rendered: true} %}
