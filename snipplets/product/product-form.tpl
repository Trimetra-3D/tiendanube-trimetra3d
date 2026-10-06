<div
    class="product-form-content pt-md-3 px-md-3 {% if home_main_product %}mt-2 mt-md-0 mb-md-3{% endif %}"
    data-shipping-calculator-enabled="{{ settings.shipping_calculator_product_page ? 'true' : 'false' }}"
    data-store-has-shipping="{{ store.has_shipping ? 'true' : 'false' }}"
    data-store-has-branches="{{ store.branches ? 'true' : 'false' }}"
    data-product-non-shippable="{{ product.is_non_shippable ? 'true' : 'false' }}">

    {# Product name and breadcrumbs for product page #}

    {% if home_main_product %}
        {# Product name #}
        <h2 class="h1-md mb-3">{{ product.name }}</h2>
    {% else %}
        <section class="product-heading" data-store="page-title">
            <h1 class="js-product-name product-heading-title" data-store="product-name-{{ product.id }}">{{ product.name }}</h1>
        </section>
    {% endif %}

    {# Product SKU #}

    {% if settings.product_sku and product.sku %}
        <div class="font-smallest opacity-60 mb-3">
            {{ "SKU" | translate }}: <span class="js-product-sku">{{ product.sku }}</span>
        </div>
    {% endif %}

    {# Subscription only detection #}
    {% set is_subscription_only_product = product.isSubscribable() and product.isSubscriptionOnly() %}

    {# Product price #}

    {% include 'snipplets/labels.tpl' with {product_detail: true} %}

    {% set show_product_quantity = product.available and product.display_price %}
    {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
    {% set has_product_free_shipping = product.free_shipping %}
    {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}

    <div class="price-container product-pricing" data-store="product-price-{{ product.id }}">
      <div class="product-price-card" data-has-payment-discount="{{ hasDiscount ? 'true' : 'false' }}">
        {% if not is_subscription_only_product %}
            {# Standard prices for normal products #}
            <div class="js-price-container mb-3">
                <div class="product-price-label">{{ 'Precio de lista' | translate }}</div>
                <span class="d-inline-block">
                    <div class="js-price-display h3 font-largest" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">{% if product.display_price %}{{ product.price | money }}{% endif %}</div>
                </span>
                <span class="d-inline-block h3 font-largest font-weight-normal">
                   <div id="compare_price_display" class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</div>
                </span>
                {{ component('price-discount-disclaimer', {
                    container_classes: 'font-small opacity-60 mt-1 mb-2',
                }) }}
                {{ component('price-without-taxes', {
                        container_classes: "mt-1 mb-2 font-small opacity-60",
                    })
                }}
                {% if template == 'product' %}
                    <div class="js-product-discount-container product-cash-discount" {% if not (hasDiscount and product.showMaxPaymentDiscount and product.display_price) %}style="display:none;"{% endif %}>
                        <span class="product-cash-discount-badge">{{ product.maxPaymentDiscount.value }}% <span>OFF</span></span>
                        <div class="product-cash-discount-details">
                            {{ component('payment-discount-price', {
                                visibility_condition: hasDiscount,
                                location: 'product',
                                container_classes: 'product-cash-discount-price',
                                text_classes: { price: 'product-cash-price' },
                            }) }}
                            {% include 'snipplets/product/product-currency.tpl' %}
                        </div>
                    </div>
                    <div class="js-product-discount-disclaimer font-small opacity-80 mt-1" {% if not product.showMaxPaymentDiscountNotCombinableDisclaimer %}style="display:none;"{% endif %}>
                        {{ (product.showMaxPaymentDiscountCombinesWithSomeDiscounts ? 'No acumulable con algunas promociones' : 'No acumulable con otras promociones') | translate }}
                    </div>
                {% else %}
                {{ component('payment-discount-price', {
                        visibility_condition: settings.payment_discount_price,
                        location: 'product',
                        container_classes: "h6 font-body text-accent mt-2",
                        text_classes: {
                            price: 'h5 font-big',
                        },
                    })
                }}
                {% endif %}
            </div>
        {% endif %}

        {{ component('subscriptions/subscription-price', {
            location: is_subscription_only_product ? 'product_detail',
            subscription_classes: {
                container: 'mb-3',
                prices_container: 'd-flex align-items-baseline mb-1',
                price_compare: 'h3 font-largest font-weight-normal price-compare ml-2',
                price_with_subscription: 'h3 font-largest order-first',
                discount_container: 'label label-inline label-big mb-2',
                price_without_taxes_container: 'font-small opacity-60',
            },
            subscription_discount_position: 'above',
        }) }}

        {% set installments_info = product.installments_info_from_any_variant %}
        {% set product_max_installments_without_interests = product.get_max_installments(false) %}
        {% set product_installments_has_active_promo = include('snipplets/payment-installments-config.tpl', { mode: 'has_active_promo' }) | trim %}
        {% set product_promo_is_eligible = include('snipplets/payment-promo-product-eligibility.tpl') | trim %}
        {% set product_promo_applies = product_installments_has_active_promo == 'true' and product_promo_is_eligible == 'true' %}
        {% set has_native_installments = installments_info and product_max_installments_without_interests and product_max_installments_without_interests.installment > 1 %}
        {% set show_payments_info = product.display_price and (product_promo_applies or (settings.product_detail_installments and product.show_installments and has_native_installments)) %}

        {% if not home_main_product and (show_payments_info or hasDiscount) %}
            <div {% if installments_info %}data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments"{% endif %} class="{% if installments_info %}js-modal-open js-fullscreen-modal-open{% endif %} js-product-payments-container mb-3" data-promo-applies="{{ product_promo_applies ? 'true' : 'false' }}" {% if not product.display_price %}style="display: none;"{% endif %}>
        {% endif %}
            {% if show_payments_info %}
                {% include 'snipplets/product/product-installments-summary.tpl' with {
                    installments_container_class: '',
                    product_detail_installments_summary: true
                } %}
                <div class="product-payment-logos">
                    {{ component('payment-shipping-logos', {'type': 'payments'}) }}
                </div>
            {% endif %}

            {% set hideDiscountContainer = not (hasDiscount and product.showMaxPaymentDiscount) %}
            {% set hideDiscountDisclaimer = not product.showMaxPaymentDiscountNotCombinableDisclaimer %}

            {% if template != 'product' %}
            <div class="js-product-discount-container mb-2" {% if hideDiscountContainer %}style="display: none;"{% endif %}>
                <span class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</span> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}
                <div class="js-product-discount-disclaimer font-small opacity-80 mt-1" {% if hideDiscountDisclaimer %}style="display: none;"{% endif %}>
                    {{ (product.showMaxPaymentDiscountCombinesWithSomeDiscounts
                        ? "No acumulable con algunas promociones"
                        : "No acumulable con otras promociones")
                    | translate }}
                </div>
            </div>
            {% endif %}
        {% if not home_main_product and (show_payments_info or hasDiscount) %}
                <a id="btn-installments" class="btn-link font-small" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                    {{ "Ver todos los medios de pago" | translate }}
                </a>
            </div>
        {% endif %}
      </div>

      <div class="product-availability" aria-live="polite">
          <span class="js-product-availability-available product-availability-status product-availability-status--available" {% if not product.available %}style="display:none;"{% endif %}>
              <span class="product-availability-dot" aria-hidden="true"></span>
              <strong>{{ 'En stock' | translate }}</strong>
              {% if settings.product_stock and product.selected_or_first_available_variant.stock is not null %}
                  <span class="product-availability-stock">· {{ 'Quedan' | translate }} <span class="js-product-stock">{{ product.selected_or_first_available_variant.stock }}</span> {{ 'unidades' | translate }}</span>
              {% endif %}
          </span>
          <span class="js-product-availability-unavailable product-availability-status product-availability-status--unavailable" {% if product.available %}style="display:none;"{% endif %}>
              <span class="product-availability-dot" aria-hidden="true"></span>
              <strong>{{ 'Sin stock' | translate }}</strong>
          </span>
      </div>

    </div>

    {% set custom_label = product.getPromotionCustomLabel %}
    {% set has_custom_promotion_label = custom_label and custom_label | trim %}

    {% set promotion_title_classes = has_custom_promotion_label ? 'font-medium text-accent mt-3 mb-2' : 'h4 text-uppercase font-small mb-1 mt-4 text-accent' %}

    {{ component('promotions-details', {
        promotions_details_classes: {
            container: 'js-product-promo-container mb-2',
            promotion_title: promotion_title_classes,
            valid_scopes: 'font-small mb-0',
            categories_combinable: 'font-small mb-0',
            not_combinable: 'font-small opacity-80 mb-0',
            progressive_discounts_table: 'table mb-2 mt-3',
            progressive_discounts_hidden_table: 'table-body-inverted',
            progressive_discounts_show_more_link: 'btn-link btn-link-primary mb-4',
            progressive_discounts_promotion_quantity: 'font-weight-light text-lowercase'
        },
        svg_sprites: false,
        custom_control_show: include("snipplets/svg/chevron-down.tpl", { svg_custom_class: "icon-inline icon-w-14 icon-md ml-2" }),
        custom_control_hide: include("snipplets/svg/chevron-up.tpl", { svg_custom_class: "icon-inline icon-w-14 icon-md ml-2" }),
    }) }}

    {# Product form, includes: Variants, CTA and Shipping calculator #}

     <form id="product_form" class="js-product-form product-purchase-form mt-4" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
        {% if template == "product" %}
            {% set show_size_guide = true %}
        {% endif %}
        {% if product.variations %}
            {% include "snipplets/product/product-variants.tpl" with {show_size_guide: show_size_guide} %}
        {% endif %}

        {% if settings.last_product and show_product_quantity %}
            <div class="{% if product.variations %}js-last-product{% endif %} text-accent font-weight-bold mb-3"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
                {{ settings.last_product_text }}
            </div>
        {% endif %}

        {% set show_buy_now = template == 'product' and not home_main_product and settings.ajax_cart and not store.is_catalog and not product.isSubscribable() %}
        <div class="row product-purchase-actions{% if show_buy_now %} product-purchase-actions--buy-now{% endif %} mb-4 {% if settings.product_stock %}mb-md-3{% endif %}">
            {% if show_product_quantity %}
                {% set product_quantity_container_class = product.isSubscribable() ? 'col-5 col-md-4 mb-3' %}
                {% include "snipplets/product/product-quantity.tpl" with {product_quantity_container_class: product_quantity_container_class} %}
            {% endif %}

            {{ component('subscriptions/subscription-selector', {
                allow_subscription_only: is_subscription_only_product,
                subscription_only_container: 'p-3',
                subscription_classes: {
                    container: 'col-12 mb-1',

                    radio_button: 'card p-3 overflow-visible',
                    radio_button_text: 'row',
                    radio_button_label: 'ml-1',
                    purchase_option_info_container: 'col font-small',
                    purchase_option_price: 'col-auto text-right font-weight-bold',
                    purchase_option_single_frequency: 'mt-2 pt-1 font-small opacity-80',
                    purchase_option_discount: 'label label-accent ml-1',

                    dropdown_container: 'col-md-9 mt-3 p-0',
                    dropdown_button: 'form-select font-small p-2 position-relative',
                    dropdown_icon: 'form-select-icon',
                    dropdown_options: 'form-select-options',
                    dropdown_option: 'form-select-option row no-gutters',
                    dropdown_option_info: 'col pr-4',
                    dropdown_option_price: 'col-auto',
                    dropdown_option_discount: 'text-accent mt-1 font-weight-bold',

                    cart_alert: 'font-small text-center mt-2',
                    shipping_message: 'mb-3',
                    shipping_message_title_container: 'mb-2 pb-1',
                    shipping_message_title: 'font-small',
                    shipping_message_text: 'font-small card p-3',
                    
                    legal_message: 'font-smallest text-center mb-3 px-3',
                    legal_link: 'font-smallest d-inline-block btn-link btn-link-primary p-0',
                    legal_modal: 'bottom modal-centered-small modal-centered transition-soft',
                    legal_modal_title: 'col px-3',
                    legal_modal_header: 'modal-header row no-gutters align-items-center',
                    legal_modal_body: 'mb-4',
                    legal_modal_details_title: 'font-body mb-2',
                    legal_modal_close_button: 'col-2 modal-close text-right pr-3',
                    legal_modal_details_paragraph: 'font-small pb-4',
                    legal_modal_details_link: 'font-small d-inline-block btn-link btn-link-primary p-0',
                },
                svg_sprites: false,

                dropdown_icon: true,
                dropdown_custom_icon: include("snipplets/svg/chevron-down.tpl", { svg_custom_class: "icon-inline icon-w-14" }),

                cart_alert_icon: true,
                cart_alert_custom_icon: include("snipplets/svg/info-circle.tpl", { svg_custom_class: "icon-inline icon-w-14" }),

                shipping_message_icon: true,
                shipping_message_custom_icon: include("snipplets/svg/truck.tpl", { svg_custom_class: "icon-inline svg-icon-text mr-2" }),

                legal_modal_close_custom_icon: include("snipplets/svg/times.tpl", { svg_custom_class: "icon-inline svg-icon-text" }),
            }) }}
            
            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
            {% if show_buy_now %}
                <div class="product-buy-now-container">
                    <button type="button" class="js-product-buy-now product-buy-now btn btn-primary btn-big btn-block" data-buy-now-label="{{ 'Comprar ahora' | translate }}" aria-disabled="{{ state == 'cart' ? 'false' : 'true' }}" {% if state != 'cart' %}disabled{% endif %}>{{ 'Comprar ahora' | translate }}</button>
                </div>
            {% endif %}
            <div class="product-submit-container {% if show_product_quantity and not product.isSubscribable() %}col-8 col-md-9 pl-3{% else %}col-12{% endif %}">

                {# Add to cart CTA #}

                <input type="submit" class="js-addtocart js-prod-submit-form btn-add-to-cart btn btn-primary btn-big btn-block {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button" data-component="product.add-to-cart"/>

                {# Fake add to cart CTA visible during add to cart event #}

                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big"} %}

            </div>

            {% if settings.ajax_cart %}
                <div class="col-12">
                    <div class="js-added-to-cart-product-message font-small mt-2 mb-3" style="display: none;">
                        {% include "snipplets/svg/check.tpl" with {svg_custom_class: "icon-inline icon-lg svg-icon-text mr-2 d-table float-left"} %}
                        <span>
                            {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-open-cart js-fullscreen-modal-open btn-link float-right ml-1" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                        </span>
                    </div>
                </div>
            {% endif %}

            {# Free shipping visibility message #}

            {% set free_shipping_minimum_label_changes_visibility = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

            {% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

            {% if not product.is_non_shippable and show_product_quantity and has_free_shipping and not has_product_free_shipping %}
                <div class="px-3">

                    {# Free shipping add to cart message #}

                    {% if include_product_free_shipping_min_wording %}

                        {% include "snipplets/shipping/shipping-free-rest.tpl" with {'product_detail': true} %}

                    {% endif %}

                    {# Free shipping achieved message #}

                    <div class="js-product-form-free-shipping-message {% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} text-accent font-weight-normal my-2 pt-1" {% if not cart.free_shipping.cart_has_free_shipping %}style="display: none;"{% endif %}>
                        {{ "¡Genial! Tenés envío gratis" | translate }}
                    </div>
                </div>
            {% endif %}
        </div>

        {% if template == 'product' %}

            {% set show_product_fulfillment = (store.has_shipping or store.branches) and not product.is_non_shippable %}

            {% if show_product_fulfillment %}
                <div class="product-fulfillment mb-4 pb-2">
                    {# Shipping calculator and branch link #}

                    <div id="product-shipping-container" class="product-shipping-calculator list" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">
                        {% if store.has_shipping %}
                            {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
                        {% endif %}
                    </div>

                    {% if store.branches %}
                        {# Link for branches #}
                        {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
                    {% endif %}

                    {% if not product.is_non_shippable and show_product_quantity and (has_free_shipping or has_product_free_shipping) %}
                        <div class="js-free-shipping-minimum-message free-shipping-message product-free-shipping-message">
                            <span>{{ 'Envío' | translate }} <strong class="text-accent">{{ 'gratis' | translate }}</strong></span>
                            <span {% if has_product_free_shipping %}style="display: none;"{% else %}class="js-shipping-minimum-label"{% endif %}>
                                {{ 'superando los' | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
                            </span>
                        </div>
                    {% endif %}
                </div>

            {% endif %}
        {% endif %}
     </form>
</div>

{% if not home_main_product %}
   {# Product payments details #}
    {% include 'snipplets/product/product-payment-details.tpl' %}
{% endif %}
