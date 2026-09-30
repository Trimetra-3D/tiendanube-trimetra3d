{%- set payment_base_installments = '3' -%}
{# Promo 9 cuotas Bambu Lab y Snapmaker. Horarios expresados en Argentina (UTC-03:00). #}
{%- set payment_promo_start_date = '2026-09-25' -%}
{%- set payment_promo_end_date = '2026-10-05' -%}
{%- set payment_promo_start = payment_promo_start_date ~ 'T09:57:00-03:00' -%}
{%- set payment_promo_end = payment_promo_end_date ~ 'T10:00:00-03:00' -%}
{%- set payment_promo_start_time_display = '09:57' -%}
{%- set payment_promo_end_time_display = '10:00' -%}
{%- set payment_promo_countdown = 'true' -%}
{%- set payment_promo_installments = '9' -%}
{%- set payment_promo_label = 'Bambu Lab y Snapmaker' -%}
{%- set payment_promo_scope = 'impresoras Bambu Lab y Snapmaker' -%}
{%- set payment_current_timestamp = "now" | date("U") -%}
{%- set payment_promo_start_timestamp = payment_promo_start | date("U") -%}
{%- set payment_promo_end_timestamp = payment_promo_end | date("U") -%}
{%- set payment_has_active_promo = payment_promo_start and payment_promo_end and payment_promo_installments and payment_current_timestamp >= payment_promo_start_timestamp and payment_current_timestamp <= payment_promo_end_timestamp -%}
{%- set payment_promo_has_not_ended = payment_promo_end and payment_current_timestamp <= payment_promo_end_timestamp -%}
{%- set payment_installments_mode = mode | default('current_installments') -%}

{%- if payment_installments_mode == 'base_installments' -%}
{{ payment_base_installments }}
{%- elseif payment_installments_mode == 'promo_start' -%}
{{ payment_promo_start }}
{%- elseif payment_installments_mode == 'promo_end' -%}
{{ payment_promo_end }}
{%- elseif payment_installments_mode == 'promo_start_display' -%}
{{ payment_promo_start_date | date("d/m") }}
{%- elseif payment_installments_mode == 'promo_end_display' -%}
{{ payment_promo_end_date | date("d/m") }}
{%- elseif payment_installments_mode == 'promo_start_time_display' -%}
{{ payment_promo_start_time_display }}
{%- elseif payment_installments_mode == 'promo_end_time_display' -%}
{{ payment_promo_end_time_display }}
{%- elseif payment_installments_mode == 'promo_countdown' -%}
{{ payment_promo_countdown }}
{%- elseif payment_installments_mode == 'promo_installments' -%}
{{ payment_promo_installments }}
{%- elseif payment_installments_mode == 'promo_label' -%}
{{ payment_promo_label }}
{%- elseif payment_installments_mode == 'promo_scope' -%}
{{ payment_promo_scope }}
{%- elseif payment_installments_mode == 'has_active_promo' -%}
{{ payment_has_active_promo ? 'true' : 'false' }}
{%- elseif payment_installments_mode == 'promo_has_not_ended' -%}
{{ payment_promo_has_not_ended ? 'true' : 'false' }}
{%- else -%}
{{ payment_has_active_promo ? payment_promo_installments : payment_base_installments }}
{%- endif -%}
