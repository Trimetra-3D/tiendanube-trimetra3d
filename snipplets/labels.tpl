{% set label_accent_classes = 'label label-inline '  ~ (product_detail ? 'label-big') %}
{% set shipping_icon = include ('snipplets/svg/truck.tpl', {svg_custom_class: 'icon-inline icon-w-28'}) %}

{% set inline_product_detail_label = not labels_floating and product_detail %}

{# Prioritize custom promotion label when is not percentage off for product detail #}
{% set custom_label = product.getPromotionCustomLabel %}
{% set has_custom_promotion_label = custom_label and custom_label | trim %}

{{ component(
  'labels', {
    defer_stock_label_text: true,
    prioritize_promotion_over_offer: product_detail ? false : true,
    promotion_nxm_long_wording: false,
    promotion_quantity_long_wording: true,
    free_shipping_and_no_stock_only: labels_floating ? true : false,
    offer_only: inline_product_detail_label and not has_custom_promotion_label ? true : false,
    promotion_only: inline_product_detail_label and has_custom_promotion_label ? true : false,
    promotion_and_offer_only: not labels_floating and not product_detail ? true : false,
    offer_negative_discount_percentage: not labels_floating ? true : false,
    group_data_store: labels_floating ? false : true,
    svg_sprites: false,
    free_shipping_short_wording: not (labels_floating and product_detail),
    shipping_icon: true,
    shipping_custom_icon: shipping_icon,
    labels_classes: {
      group: (labels_floating ? 'js-labels-floating-group labels-absolute' : 'align-text-top mb-2'),
      promotion: label_accent_classes,
      offer: 'js-offer-label ' ~ label_accent_classes,
      shipping: 'label label-accent ' ~ (product_detail ? 'label-big'),
      no_stock: 'js-stock-label label label-default ' ~ (product_detail ? 'label-big'),
    },
  })
}}
