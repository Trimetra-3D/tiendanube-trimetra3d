{# This landing becomes active only when the shared campaign covers both brands.
   Until its dates/scope are configured, it announces the upcoming campaign. #}
{%- set scope = include('snipplets/payment-installments-config.tpl', { mode: 'promo_scope' }) | trim | lower -%}
{%- set active = include('snipplets/payment-installments-config.tpl', { mode: 'has_active_promo' }) | trim == 'true' -%}
{%- set pending = include('snipplets/payment-installments-config.tpl', { mode: 'promo_has_not_ended' }) | trim == 'true' -%}
{%- if 'snapmaker' not in scope or ('bambu' not in scope) -%}scheduled
{%- elseif active -%}active
{%- elseif pending -%}scheduled
{%- else -%}ended
{%- endif -%}
