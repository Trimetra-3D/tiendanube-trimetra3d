{# Product installments summary capped to the active plan only for eligible promo products. #}

{%- set product_base_installments = include("snipplets/payment-installments-config.tpl", { mode: "base_installments" }) | trim -%}
{%- set product_installments_has_active_promo = include("snipplets/payment-installments-config.tpl", { mode: "has_active_promo" }) | trim -%}
{%- set product_promo_installments = include("snipplets/payment-installments-config.tpl", { mode: "promo_installments" }) | trim -%}
{%- set product_promo_is_eligible = include("snipplets/payment-promo-product-eligibility.tpl") | trim -%}
{%- set product_promo_applies = product_installments_has_active_promo == 'true' and product_promo_is_eligible == 'true' -%}
{%- set product_default_installments_limit = product_promo_applies ? product_promo_installments : product_base_installments -%}
{%- set product_installments_limit = installments_limit | default(product_default_installments_limit) -%}
{%- set max_installments_without_interests = product.get_max_installments(false) -%}
{%- set available_installments = max_installments_without_interests ? max_installments_without_interests.installment : 0 -%}
{%- set installments_to_show = product_promo_applies ? product_promo_installments : (available_installments > product_installments_limit ? product_installments_limit : available_installments) -%}
{%- set product_installments_is_promo = product_promo_applies and installments_to_show == product_promo_installments -%}

{%- if installments_to_show > 1 -%}
    {%- set installment_price = product.price / installments_to_show -%}
    <div
        class="{% if product_detail_installments_summary %}js-product-detail-installments-summary{% else %}js-max-installments-container{% endif %} {{ installments_container_class | default('') }}{% if product_installments_is_promo %} item-installments--promo{% endif %}"
        data-max-installments="{{ product_installments_limit }}"
        data-promo-eligible="{{ product_promo_applies ? 'true' : 'false' }}"
        data-promo-installments="{{ product_promo_installments }}">
        <span class="js-max-installments">
            <span class="product-installments-heading">
                <strong class="js-installment-amount">{{ installments_to_show }}</strong>
                {% if product_detail_installments_summary %}
                    <span>{{ 'cuotas' | translate }}</span><span class="product-installments-interest">{{ 'sin interés' | translate }}</span>
                {% else %}
                    <span>{{ 'cuotas sin interés' | translate }}</span>
                {% endif %}
            </span>
            <span class="product-installments-value">
                <span>{{ 'de' | translate }}</span>
                <strong class="js-installment-price product-installments-price" data-value="{{ installment_price }}">{{ (installment_price) | money }}</strong>
            </span>
        </span>
    </div>
{%- endif -%}
