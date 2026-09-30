<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
    <head>
        {% set custom_page_handle = template == 'page' ? page.handle | default('') : '' %}
        {% set custom_page_is_custom = template == 'page' and include('snipplets/custom-pages/page-context.tpl', { mode: 'is_custom', custom_page_handle: custom_page_handle }) | trim == 'true' %}
        {% set custom_page_key = include('snipplets/custom-pages/page-context.tpl', { mode: 'page_key', custom_page_handle: custom_page_handle }) | trim %}
        {% set custom_page_stylesheet = include('snipplets/custom-pages/page-context.tpl', { mode: 'stylesheet', custom_page_handle: custom_page_handle }) | trim %}
        {% set custom_page_script = include('snipplets/custom-pages/page-context.tpl', { mode: 'script', custom_page_handle: custom_page_handle }) | trim %}
        {% set custom_page_meta_title = include('snipplets/custom-pages/page-context.tpl', { mode: 'meta_title', custom_page_handle: custom_page_handle }) | trim %}
        {% set custom_page_meta_description = include('snipplets/custom-pages/page-context.tpl', { mode: 'meta_description', custom_page_handle: custom_page_handle }) | trim %}
        {% set custom_page_robots = include('snipplets/custom-pages/page-context.tpl', { mode: 'robots', custom_page_handle: custom_page_handle }) | trim %}
        {% set custom_page_canonical_path = include('snipplets/custom-pages/page-context.tpl', { mode: 'canonical_path', custom_page_handle: custom_page_handle }) | trim %}
        {% set custom_page_redirect_path = include('snipplets/custom-pages/page-context.tpl', { mode: 'redirect_path', custom_page_handle: custom_page_handle }) | trim %}
        {% set is_single_product_page = template == 'product' %}
        {% set is_brand_promo = template == 'category' and category.handle == 'snapmaker-bambulab' %}

        {% if custom_page_is_custom and custom_page_meta_title %}
            {% set page_title = custom_page_meta_title %}
        {% endif %}
        {% if custom_page_is_custom and custom_page_meta_description %}
            {% set page_description = custom_page_meta_description %}
        {% endif %}

        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        {% if custom_page_robots %}
            <meta name="robots" content="{{ custom_page_robots }}" />
        {% endif %}
        {% if custom_page_canonical_path %}
            <link rel="canonical" href="{{ store.url | trim('/') }}{{ custom_page_canonical_path }}" />
        {% endif %}
        {% if custom_page_redirect_path %}
            <meta http-equiv="refresh" content="0; url={{ custom_page_redirect_path }}" />
        {% endif %}
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,700') }}" />
        <link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
        <link rel="preload" href="{{ 'css/style-colors.scss' | static_url }}" as="style" />

        {# Preload LCP home, category and product page elements #}

        {% snipplet 'preload-images.tpl' %}

        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        <style>
            {# Font families #}

            {{ component(
                'fonts',{
                    font_weights: '400,700',
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {# General CSS Tokens #}

            {% include "static/css/style-tokens.tpl" %}
        </style>

        {# Critical CSS #}

        {{ 'css/style-critical.scss' | static_url | static_inline }}

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">

        {% if is_brand_promo %}
            <link rel="stylesheet" href="{{ 'css/brand-promo.scss' | static_url }}" media="all">
        {% endif %}
        {% if custom_page_is_custom %}
            <link rel="stylesheet" href="{{ 'css/custom-pages-base.scss' | static_url }}" media="all">
            {% if custom_page_stylesheet %}
                <link rel="stylesheet" href="{{ custom_page_stylesheet | static_url }}" media="all">
            {% endif %}
        {% elseif is_single_product_page %}
            <link rel="stylesheet" href="{{ 'css/single-product.scss' | static_url }}" media="all">
        {% endif %}

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {% if load_jquery %}

            {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {% endif %}

        {# Loads private Tiendanube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data-organization') }}
        {{ component('structured-data') }}

    </head>
    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">
        {# Facebook comments on product page #}

        {% if template == 'product' %}

            {# Facebook comment box JS #}
            {% if settings.show_product_fb_comment_box %}
                {{ fb_js }}
            {% endif %}

            {# Pinterest share button JS #}
            {{ pin_js }}

        {% endif %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Header = Advertising + Nav + Logo + Search + Ajax Cart #}

        {% snipplet "header/header.tpl" %}

        {# Page content #}

        {% template_content %}

        {# Quickshop modal #}

        {% snipplet "grid/quick-shop.tpl" %}

        {# WhatsApp chat button #}

        {% if not settings.whatsapp_header_link %}
            {% snipplet "whatsapp-chat.tpl" %}
        {% endif %}

        {# Footer #}

        {% snipplet "footer/footer.tpl" %}

        {% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

            {# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}

            <span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
            <span class="js-free-shipping-config hidden" data-config="{{ cart.free_shipping.allFreeConfigurations }}"></span>
            <span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
            <span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
        {% endif %}

        {#/*============================================================================
            #Javascript: Needed after HTML loads
        ==============================================================================*/#}

        {# Javascript used in the store #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

            {# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}

            LS.ready.then(function(){

                {# Libraries that requires Jquery to work #}

                {% include "static/js/external.js.tpl" %}

                {# Specific store JS functions: product variants, cart, shipping, etc #}

                {% include "static/js/store.js.tpl" %}
            });
        </script>

        {% if custom_page_is_custom %}
            <script type="text/javascript">
                {% include "static/js/custom-pages.js.tpl" %}
            </script>
            {% if custom_page_script %}
                <script type="text/javascript">
                    {% include custom_page_script %}
                </script>
            {% endif %}
        {% endif %}

        {% if is_brand_promo %}
            <script>{% include 'static/js/brand-promo.js.tpl' %}</script>
        {% endif %}

        {# Google reCAPTCHA on register page #}
        {% if template == 'account.register' %}
            {% if not store.hasContactFormsRecaptcha() %}
                {{ '//www.google.com/recaptcha/api.js' | script_tag(true) }}
            {% endif %}
            <script type="text/javascript">
                var recaptchaCallback = function() {
                    jQueryNuvem('.js-recaptcha-button').prop('disabled', false);
                };
            </script>
        {% endif %}

        {# Google survey JS for Tiendanube Survey #}

        {{ component('google-survey') }}

        {# Store external codes added from admin #}

        {% if store.assorted_js %}
            <script>
                LS.ready.then(function() {
                    var trackingCode = jQueryNuvem.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
                    jQueryNuvem('body').append(trackingCode);
                });
            </script>
        {% endif %}
        <script>
            window.chatwootSettings = {"position":"right","type":"expanded_bubble","launcherTitle":"¿Necesitás ayuda?"};
            (function(d,t) {
                var BASE_URL="https://soporte.trimetra3d.com.ar";
                var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
                g.src=BASE_URL+"/packs/js/sdk.js";
                g.async = true;
                s.parentNode.insertBefore(g,s);
                g.onload=function(){
                window.chatwootSDK.run({
                    websiteToken: 'UJa17qWiHUeNMHJq5siUdop7',
                    baseUrl: BASE_URL
                })
                }
            })(document,"script");
        </script>

    </body>
</html>
