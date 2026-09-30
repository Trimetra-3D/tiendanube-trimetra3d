{% set is_brand_promo = category.handle == 'snapmaker-bambulab' %}
{% if is_brand_promo %}
    {% paginate by 12 %}
    {% include 'snipplets/brand-promo/landing.tpl' %}
{% else %}
{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{% if settings.pagination == 'infinite' %}
	{% paginate by 12 %}
{% else %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 50 %}
	{% else %}
		{% paginate by 48 %}
	{% endif %}
{% endif %}

{% if not show_help %}

{% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
{% set has_category_description_without_banner = not category_banner and category.description %}
{% set page_header_classes = has_category_description_without_banner ? 'pt-3 pt-md-4' : '' %}
{% set page_header_padding = has_category_description_without_banner ? false : true %}

{% if category_banner %}
    {% include 'snipplets/category-banner.tpl' %}
{% endif %}

<div class="background-secondary mb-md-3">
	<div class="container">
		<div class="row align-items{% if category_banner %}-center{% else %}-end{% endif %}">
			<div class="col">
				{% if category_banner %}
					{% include 'snipplets/breadcrumbs.tpl' with {breadcrumbs_custom_class: 'mb-0' } %}
				{% else %}
					{% embed "snipplets/page-header.tpl" with {container: false, padding: page_header_padding, page_header_class: page_header_classes} %}
					    {% block page_header_text %}{{ category.name }}{% endblock page_header_text %}
					{% endembed %}
					{% if category.description %}
						<p class="mt-2 mb-md-4 mb-3">{{ category.description }}</p>
					{% endif %}
				{% endif %}
			</div>
			{% if products %}
				<div class="col-auto py-3 py-md-4">
					<a href="#" class="js-modal-open btn-link d-none d-md-block" data-toggle="#sort-by">
						<div class="d-flex justify-content-center align-items-center">
							{% include "snipplets/svg/sort.tpl" with { svg_custom_class: "icon-inline mr-2"} %}
							{{ 'Ordenar' | t }}
						</div>
					</a>
					{% if products | length > 1 %}
						<div class="d-md-none text-right font-small mb-1">
							{{ products_count }} {{ 'productos' | translate }}
						</div>
					{% endif %}
				</div>
			{% endif %}
		</div>
	</div>
</div>

{% include 'snipplets/grid/filters-modals.tpl' %}
<section class="js-category-controls-prev category-controls-sticky-detector"></section>

<section class="category-body" data-store="category-grid-{{ category.id }}">
	<div class="container {% if has_applied_filters %}mt-md-0{% endif %} mt-3 mb-5">
		<div class="row">
			{% if has_applied_filters %}
				<div class="col-12 mb-3 mb-md-4 d-flex justify-content-md-end align-items-center visible-when-content-ready">
					{% include "snipplets/grid/filters.tpl" with {applied_filters: true} %}
				</div>
			{% endif %}
			{% if has_filters_available %} 
				{% include 'snipplets/grid/filters-sidebar.tpl' %}
			{% endif %}
			{% include 'snipplets/grid/products-list.tpl' %}
		</div>
	</div>
</section>
{% elseif show_help %}
	{# Category Placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}
{% endif %}
