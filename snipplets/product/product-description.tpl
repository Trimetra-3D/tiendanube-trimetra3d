{% set description_content = product.description is not empty or settings.show_product_fb_comment_box %}
<div class="product-description-section {% if not description_content %}mt-2 mt-md-0{% endif %} container pt-md-3 pb-md-4" data-store="product-description-{{ product.id }}">

    {% if settings.full_width_description %}
        <div class="row">
            {% if description_content %}
                <div class="col-md-12 pr-md-5">
            {% endif %}
    {% endif %}

                    {# Product description #}

                    {% if product.description is not empty %}
                        <h2 class="product-description-title font-big mb-2">{{ "Descripción" | translate }}</h2>
                        <div class="user-content font-small mb-4">
                            {{ product.description }}
                        </div>
                    {% endif %}

                    {% if settings.show_product_fb_comment_box %}
                        <div class="fb-comments section-fb-comments mb-3" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
                    {% endif %}
                    <div id="reviewsapp"></div>

                    {% if not settings.full_width_description %}
                        {% include 'snipplets/social/social-share.tpl' %}
                    {% endif %}

    {% if settings.full_width_description %}
            {% if description_content %}
                </div>
            {% endif %}
            {#
            <div class="col-md-2">
                {% include 'snipplets/social/social-share.tpl' %}
            </div>
            #}
        </div>
    {% endif %}
</div>
