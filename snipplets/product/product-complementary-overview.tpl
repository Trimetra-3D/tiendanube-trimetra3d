{% set complementary_products_to_show = complementary_product_list | take(3) %}

<section class="product-complementary" data-component="complementary-products" aria-labelledby="product-complementary-title">
    <header class="product-complementary__header">
        <span class="product-complementary__eyebrow">{{ 'Productos complementarios' | translate }}</span>
        <h2 id="product-complementary-title" class="product-complementary__title">{{ settings.products_complementary_title }}</h2>
    </header>
    <div class="product-complementary__grid">
        {% for complementary_product in complementary_products_to_show %}
            <article class="product-complementary-card">
                <a class="product-complementary-card__link" href="{{ complementary_product.url }}" aria-label="{{ complementary_product.name }}">
                    <span class="product-complementary-card__image-wrap">
                        {% if complementary_product.featured_image %}
                            <img class="product-complementary-card__image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ complementary_product.featured_image | product_image_url('medium') }}" alt="{{ complementary_product.name }}" />
                        {% endif %}
                    </span>
                    <span class="product-complementary-card__name">{{ complementary_product.name }}</span>
                    {% if complementary_product.display_price %}
                        <strong class="product-complementary-card__price">{{ complementary_product.price | money }}</strong>
                    {% endif %}
                </a>
            </article>
        {% endfor %}
    </div>
</section>
