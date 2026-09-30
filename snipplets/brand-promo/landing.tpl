{% set promo_state = include('snipplets/brand-promo/context.tpl') | trim %}
{% set promo_installments = include('snipplets/payment-installments-config.tpl', { mode: 'promo_installments' }) | trim %}
{% set promo_best_sellers = [] %}
{% set promo_preorders = [] %}
{% set hero_bambu = false %}
{% set hero_snapmaker = false %}
{% for product in sections.best_seller.products | default([]) %}
    {% set brand = include('snipplets/brand-promo/brand.tpl', { product: product }) | trim %}
    {% if brand and 'preventa' not in product.name | lower and promo_best_sellers | length < 5 %}
        {% set promo_best_sellers = promo_best_sellers | merge([product]) %}
    {% endif %}
    {% if brand == 'bambu' and not hero_bambu and product.featured_image %}{% set hero_bambu = product %}{% endif %}
    {% if brand == 'snapmaker' and not hero_snapmaker and product.featured_image %}{% set hero_snapmaker = product %}{% endif %}
{% endfor %}
{% for product in sections.preventas.products | default([]) %}
    {% set brand = include('snipplets/brand-promo/brand.tpl', { product: product }) | trim %}
    {% set name = product.name | lower %}
    {% set has_month = 'enero' in name or 'febrero' in name or 'marzo' in name or 'abril' in name or 'mayo' in name or 'junio' in name or 'julio' in name or 'agosto' in name or 'septiembre' in name or 'setiembre' in name or 'octubre' in name or 'noviembre' in name or 'diciembre' in name %}
    {% if brand and 'preventa' in name and has_month %}{% set promo_preorders = promo_preorders | merge([product]) %}{% endif %}
{% endfor %}

<main class="brand-promo" data-brand-promo data-campaign-state="{{ promo_state }}">
    <section class="brand-promo__hero" aria-labelledby="brand-promo-title">
        <div class="brand-promo__wrap brand-promo__hero-layout">
            <div class="brand-promo__hero-copy">
                <p class="brand-promo__eyebrow">SNAPMAKER <span aria-hidden="true">/</span> BAMBU LAB</p>
                {% if promo_state == 'ended' %}
                    <h1 id="brand-promo-title">Tu pr&oacute;xima<br>gran idea.</h1>
                    <p>La promoci&oacute;n finaliz&oacute;. Encontr&aacute; tu pr&oacute;xima impresora ac&aacute;.</p>
                {% else %}
                    <p class="brand-promo__overline">{{ promo_state == 'scheduled' ? 'Próximamente' : 'Es el momento de crear' }}</p>
                    <h1 id="brand-promo-title"><span class="brand-promo__nine">{{ promo_installments }}</span><span>cuotas<br>sin inter&eacute;s.</span></h1>
                    <p>Dos marcas. Infinitas ideas por imprimir.</p>
                {% endif %}
                <a class="brand-promo__button" href="#promo-catalog">Explor&aacute; los productos <span aria-hidden="true">&darr;</span></a>
                {% if promo_state == 'active' %}
                    <small>Hasta el {{ include('snipplets/payment-installments-config.tpl', { mode: 'promo_end_display' }) | trim }} a las {{ include('snipplets/payment-installments-config.tpl', { mode: 'promo_end_time_display' }) | trim }} h. En productos elegibles; condiciones en checkout.</small>
                {% elseif promo_state == 'scheduled' %}
                    <small>Del {{ include('snipplets/payment-installments-config.tpl', { mode: 'promo_start_display' }) | trim }} al {{ include('snipplets/payment-installments-config.tpl', { mode: 'promo_end_display' }) | trim }}. En productos elegibles.</small>
                {% endif %}
            </div>
            <div class="brand-promo__hero-art" aria-hidden="true">
                {% if hero_bambu or hero_snapmaker %}
                    {% if hero_bambu %}<img class="brand-promo__hero-machine brand-promo__hero-machine--bambu" src="{{ hero_bambu.featured_image | product_image_url('huge') }}" alt="" width="640" height="640" fetchpriority="high">{% endif %}
                    {% if hero_snapmaker %}<img class="brand-promo__hero-machine brand-promo__hero-machine--snapmaker" src="{{ hero_snapmaker.featured_image | product_image_url('large') }}" alt="" width="480" height="480">{% endif %}
                {% else %}
                    <img class="brand-promo__hero-machine" src="{{ 'images/sorteo/impresora-3d-bambu-lab-a1-combo.png' | static_url }}" alt="" width="640" height="640" fetchpriority="high">
                {% endif %}
                <span class="brand-promo__art-caption">TECNOLOG&Iacute;A PARA TUS IDEAS.</span>
            </div>
        </div>
    </section>

    <div class="brand-promo__wrap">
        <ul class="brand-promo__benefits" aria-label="Comprar en Trimetra 3D">
            <li><span aria-hidden="true">{% include 'snipplets/svg/truck.tpl' with {svg_custom_class: 'brand-promo__icon'} %}</span><div><strong>Env&iacute;o gratis a todo el pa&iacute;s</strong></div></li>
            <li><span aria-hidden="true">{% include 'snipplets/svg/security.tpl' with {svg_custom_class: 'brand-promo__icon'} %}</span><div><strong>Hasta 12 meses de garant&iacute;a</strong></div></li>
            <li><span aria-hidden="true">{% include 'snipplets/svg/chat.tpl' with {svg_custom_class: 'brand-promo__icon'} %}</span><div><strong>Asesoramiento especializado</strong></div></li>
        </ul>

        <section class="brand-promo__section" aria-labelledby="promo-bestsellers-title">
            <div class="brand-promo__section-head"><div><p class="brand-promo__eyebrow">LOS ELEGIDOS</p><h2 id="promo-bestsellers-title">M&aacute;s vendidos</h2></div>
                <div class="brand-promo__arrows" data-carousel-controls hidden><button type="button" data-carousel-prev aria-label="Productos anteriores" aria-controls="promo-bestsellers">&larr;</button><button type="button" data-carousel-next aria-label="Productos siguientes" aria-controls="promo-bestsellers">&rarr;</button></div>
            </div>
            {% if promo_best_sellers %}
                <div class="brand-promo__rail" id="promo-bestsellers" tabindex="0" role="region" aria-label="Carrusel de productos más vendidos">{% for product in promo_best_sellers %}{% include 'snipplets/brand-promo/card.tpl' %}{% endfor %}</div>
            {% else %}<p class="brand-promo__empty">Estamos preparando la selecci&oacute;n. <a href="#promo-catalog">Explor&aacute; todos los productos.</a></p>{% endif %}
        </section>

        <section class="brand-promo__section brand-promo__preorders" aria-labelledby="promo-preorders-title">
            <div class="brand-promo__section-head"><div><p class="brand-promo__eyebrow">LO QUE VIENE</p><h2 id="promo-preorders-title">Reserv&aacute; tu pr&oacute;xima impresora</h2><p>Preventas con mes estimado de llegada en cada producto.</p></div><a class="brand-promo__text-link" href="/preventas/">C&oacute;mo reservar <span aria-hidden="true">&nearr;</span></a></div>
            {% if promo_preorders %}<div class="brand-promo__rail brand-promo__rail--preorders" tabindex="0" role="region" aria-label="Productos en preventa">{% for product in promo_preorders %}{% include 'snipplets/brand-promo/card.tpl' %}{% endfor %}</div>
            {% else %}<p class="brand-promo__empty">Hoy no hay preventas publicadas de estas marcas. Mir&aacute; los productos disponibles abajo.</p>{% endif %}
        </section>

        <section class="brand-promo__section brand-promo__catalog" id="promo-catalog" aria-labelledby="promo-catalog-title">
            <div class="brand-promo__section-head"><div><p class="brand-promo__eyebrow">ENCONTR&Aacute; EL TUYO</p><h2 id="promo-catalog-title">Todos los productos</h2></div><p>{{ products_count }} productos</p></div>
            <form class="brand-promo__filters" method="get" action="{{ category.url }}#promo-catalog">
                {% for product_filter in product_filters %}
                    {% if product_filter.type != 'price' and product_filter.has_products %}
                        <label>{{ product_filter.name }}<select name="{{ product_filter.key }}"><option value="">Todos</option>{% for value in product_filter.values %}{% if value.product_count > 0 or value.selected %}<option value="{{ value.name }}" {% if value.selected %}selected{% endif %}>{{ value.name }} ({{ value.product_count }})</option>{% endif %}{% endfor %}</select></label>
                    {% endif %}
                {% endfor %}
                <label>Ordenar por<select name="sort_by"><option value="user" {% if sort_by == 'user' %}selected{% endif %}>Destacados</option><option value="price-ascending" {% if sort_by == 'price-ascending' %}selected{% endif %}>Menor precio</option><option value="price-descending" {% if sort_by == 'price-descending' %}selected{% endif %}>Mayor precio</option><option value="created-descending" {% if sort_by == 'created-descending' %}selected{% endif %}>M&aacute;s nuevos</option><option value="best-selling" {% if sort_by == 'best-selling' %}selected{% endif %}>M&aacute;s vendidos</option></select></label>
                <button class="brand-promo__button" type="submit">Aplicar filtros</button>
                {% if has_applied_filters %}<a class="brand-promo__text-link" href="{{ category.url }}#promo-catalog">Limpiar filtros</a>{% endif %}
            </form>
            {% if products %}
                <div class="brand-promo__grid" data-store="category-grid-{{ category.id }}">{% for product in products %}{% include 'snipplets/brand-promo/card.tpl' %}{% endfor %}</div>
                {% if pages.amount > 1 %}
                    <nav class="brand-promo__pagination" aria-label="Páginas de productos">
                        {% if pages.previous %}<a href="{{ pages.previous }}#promo-catalog" aria-label="Página anterior">&larr;</a>{% endif %}
                        <span aria-current="page">{{ pages.current }} / {{ pages.amount }}</span>
                        {% if pages.next %}<a href="{{ pages.next }}#promo-catalog" aria-label="Página siguiente">&rarr;</a>{% endif %}
                    </nav>
                {% endif %}
            {% else %}<div class="brand-promo__empty"><h3>No encontramos productos</h3><p>Prob&aacute; con otros filtros.</p><a href="{{ category.url }}#promo-catalog">Ver todos los productos</a></div>{% endif %}
        </section>
    </div>
</main>
