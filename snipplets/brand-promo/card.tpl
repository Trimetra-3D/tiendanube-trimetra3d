<article class="brand-promo__card">
    <a href="{{ product.url }}" class="brand-promo__product-link">
        <div class="brand-promo__product-image">
            {% if product.featured_image %}
                <img src="{{ product.featured_image | product_image_url('large') }}" alt="{{ product.name }}" width="480" height="480" loading="lazy">
            {% endif %}
            {% if not product.available %}<span class="brand-promo__tag">Sin stock</span>{% elseif product.free_shipping %}<span class="brand-promo__tag">Env&iacute;o gratis</span>{% endif %}
        </div>
        <h3>{{ product.name }}</h3>
        {% if product.display_price %}
            <p class="brand-promo__price">{{ product.price | money }}</p>
            {{ component('payment-discount-price', {
                visibility_condition: settings.payment_discount_price,
                location: 'product',
                container_classes: 'js-item-cash-price item-cash-price brand-promo__cash-price'
            }) }}
            {% set card_installments = product.get_max_installments(false) %}
            {% if card_installments and card_installments.installment > 1 %}
                {% include 'snipplets/product/product-installments-summary.tpl' with {
                    installments_container_class: 'item-installments brand-promo__installments'
                } %}
            {% else %}
                {# Native payment data may be absent. Only quote the confirmed campaign,
                   with an explicit upcoming label before its configured start. #}
                {% set card_promo_eligible = include('snipplets/payment-promo-product-eligibility.tpl') | trim == 'true' %}
                {% set card_promo_pending = include('snipplets/payment-installments-config.tpl', { mode: 'promo_has_not_ended' }) | trim == 'true' %}
                {% if card_promo_eligible and card_promo_pending %}
                    {% set card_promo_active = include('snipplets/payment-installments-config.tpl', { mode: 'has_active_promo' }) | trim == 'true' %}
                    {% set card_promo_count = include('snipplets/payment-installments-config.tpl', { mode: 'promo_installments' }) | trim %}
                    {% if card_promo_count > 1 %}
                        <div class="brand-promo__installments item-installments--promo">
                            {% if not card_promo_active %}<span>Pr&oacute;ximamente:</span> {% endif %}
                            <span>{{ card_promo_count }} cuotas de {{ (product.price / card_promo_count) | money }} sin inter&eacute;s</span>
                        </div>
                    {% endif %}
                {% endif %}
            {% endif %}
        {% else %}<p>Consultar precio</p>{% endif %}
        <span class="brand-promo__product-cta">Ver producto <span aria-hidden="true">&rarr;</span></span>
    </a>
</article>
