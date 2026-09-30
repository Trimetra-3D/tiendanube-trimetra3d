{# Structured brand wins. Name fallback only for products without a brand. #}
{%- set brand = product.brand | default('') | lower | replace(' ', '') | replace('-', '') -%}
{%- set name = product.name | lower | replace(' ', '') | replace('-', '') -%}
{%- if brand == 'snapmaker' or (not brand and 'snapmaker' in name) -%}snapmaker
{%- elseif brand == 'bambulab' or (not brand and 'bambulab' in name) -%}bambu
{%- endif -%}
