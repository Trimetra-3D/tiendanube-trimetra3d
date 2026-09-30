{# Promo eligibility: Bambu Lab and Snapmaker printers only. Prefer the structured brand and use names only when brand is missing. #}
{%- set payment_promo_product_brand = product.brand | default('') | trim | lower -%}
{%- set payment_promo_product_text = (product.name ~ ' ' ~ product.url) | lower -%}
{%- set payment_promo_product_has_brand = payment_promo_product_brand | length > 0 -%}
{%- set payment_promo_product_brand_is_eligible =
  'bambu lab' in payment_promo_product_brand
  or 'bambu-lab' in payment_promo_product_brand
  or 'snapmaker' in payment_promo_product_brand
-%}
{%- set payment_promo_product_name_is_eligible =
  'bambu lab' in payment_promo_product_text
  or 'bambu-lab' in payment_promo_product_text
  or 'snapmaker' in payment_promo_product_text
  or 'a1' in payment_promo_product_text
  or 'p1s' in payment_promo_product_text
  or 'p1p' in payment_promo_product_text
  or 'bambu lab x1' in payment_promo_product_text
  or 'x1 carbon' in payment_promo_product_text
  or 'h2s' in payment_promo_product_text
  or 'h2d' in payment_promo_product_text
  or 'p2s' in payment_promo_product_text
  or 'a2l' in payment_promo_product_text
  or 'h2c' in payment_promo_product_text
  or 'x2d' in payment_promo_product_text
-%}
{# A printer kit can include filament. Use its catalog category, not a model mentioned by a supply/accessory. #}
{%- set payment_promo_product_is_bambu_printer =
  ('bambu lab' in payment_promo_product_brand or 'bambu-lab' in payment_promo_product_brand
    or (not payment_promo_product_has_brand and ('bambu lab' in payment_promo_product_text or 'bambu-lab' in payment_promo_product_text)))
  and product.category.top.handle | default('') == 'impresoras-fdm'
-%}
{%- set payment_promo_product_is_accessory =
  ('filamento' in payment_promo_product_text and not payment_promo_product_is_bambu_printer)
  or 'accesorio' in payment_promo_product_text
  or 'resina' in payment_promo_product_text
  or 'repuesto' in payment_promo_product_text
  or 'boquilla' in payment_promo_product_text
  or 'nozzle' in payment_promo_product_text
  or 'hotend' in payment_promo_product_text
  or 'extrusor' in payment_promo_product_text
  or 'extruder' in payment_promo_product_text
  or 'placa' in payment_promo_product_text
  or 'cama' in payment_promo_product_text
  or 'ptfe' in payment_promo_product_text
-%}
{%- set payment_promo_product_is_eligible =
  payment_promo_product_brand_is_eligible
  or (not payment_promo_product_has_brand and payment_promo_product_name_is_eligible)
-%}
{{- payment_promo_product_is_eligible and not payment_promo_product_is_accessory ? 'true' : 'false' -}}
