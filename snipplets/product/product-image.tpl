{% if home_main_product %}
	{% set has_multiple_slides = product.media_count > 1 %}
{% else %}
	{% set has_multiple_slides = product.media_count > 1 or product.video_url %}
{% endif %}

{% set compact_product_thumbs = template == 'product' and not home_main_product %}
{% if compact_product_thumbs %}
    {% set product_image_count = 0 %}
    {% set product_video_count = product.video_url ? 1 : 0 %}
    {% set first_remaining_image_index = null %}
    {% set first_product_video_index = null %}
    {% for media in product.media %}
        {% if media.isImage %}
            {% if product_image_count == 5 %}{% set first_remaining_image_index = loop.index0 %}{% endif %}
            {% set product_image_count = product_image_count + 1 %}
        {% elseif media.isVideo %}
            {% if first_product_video_index is null %}{% set first_product_video_index = loop.index0 %}{% endif %}
            {% set product_video_count = product_video_count + 1 %}
        {% endif %}
    {% endfor %}
    {% if first_product_video_index is null and product.video_url %}
        {% set first_product_video_index = product.media_count %}
    {% endif %}
{% endif %}

<div class="row" data-store="product-image-{{ product.id }}"> 
	{% if has_multiple_slides %}
		<div class="col-md-auto d-none d-md-block pr-0">
			<div class="product-thumbs-container position-relative{% if compact_product_thumbs %} product-thumbs--compact{% endif %}">
				<div class="text-center d-none d-md-block">
					<div class="js-swiper-product-thumbs-prev swiper-button-prev swiper-product-thumb-control  svg-icon-text">{% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline icon-lg"} %}</div>
				</div>
				<div class="js-swiper-product-thumbs swiper-product-thumb"> 
					<div class="swiper-wrapper">
						{% set visible_product_images = 0 %}
						{% for media in product.media %}
							{% if not compact_product_thumbs or (media.isImage and visible_product_images < 5) %}
							<div class="swiper-slide h-auto w-auto">
								{% include 'snipplets/product/product-image-thumbs.tpl' %}
							</div>
							{% if media.isImage %}{% set visible_product_images = visible_product_images + 1 %}{% endif %}
							{% endif %}
						{% endfor %}
						{% if compact_product_thumbs %}
                            {% if product_image_count > 5 %}
                                <div class="swiper-slide h-auto w-auto">
                                    <a href="#" class="js-product-thumb js-product-thumb-modal product-thumb product-thumb--summary" data-thumb-loop="{{ first_remaining_image_index }}" data-thumb-kind="remaining-images" aria-label="{{ 'Ver más imágenes' | translate }}">
                                        {{ product_image_count - 5 }} {{ 'más' | translate }}
                                    </a>
                                </div>
                            {% endif %}
                            {% if product_video_count > 0 %}
                                <div class="swiper-slide h-auto w-auto">
                                    <a href="#" class="js-product-thumb js-video-thumb product-thumb product-thumb--summary" data-thumb-loop="{{ first_product_video_index }}" data-thumb-kind="videos" aria-label="{{ 'Ver videos del producto' | translate }}">
                                        {{ product_video_count }} {{ (product_video_count == 1 ? 'video' : 'videos') | translate }}
                                    </a>
                                </div>
                            {% endif %}
						{% elseif not home_main_product %}
							{# Video thumb #}
							<div class="swiper-slide h-auto w-auto">
								{% include 'snipplets/product/product-video.tpl' with {thumb: true} %}
							</div>
						{% endif %}
					</div>
				</div>
				<div class="text-center d-none d-md-block">
					<div class="js-swiper-product-thumbs-next swiper-button-next swiper-product-thumb-control  svg-icon-text">{% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline icon-lg"} %}</div>
				</div>
			</div>
		</div>
	{% endif %}
	{% if product.media_count > 0 %}
		<div class="col p-0 px-md-3">
			<div class="js-swiper-product swiper-container product-detail-slider" data-product-images-amount="{{ product.media_count }}">
                {% include 'snipplets/labels.tpl' with {product_detail: true, labels_floating: true} %}
                {% include 'snipplets/promo-3d-printer-badge.tpl' with {product_detail: true} %}
				<div class="swiper-wrapper">
					{% for media in product.media %}
						{% if media.isImage %}
							<div class="js-product-slide w-100 swiper-slide product-slide{% if home_main_product %}-small{% endif %} slider-slide" data-image="{{media.id}}" data-image-position="{{loop.index0}}">
								{% if home_main_product %}
									<div class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ media.dimensions['height'] / media.dimensions['width'] * 100}}%;">
								{% else %}
									<a href="{{ media | product_image_url('original') }}" data-fancybox="product-gallery" class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ media.dimensions['height'] / media.dimensions['width'] * 100}}%;">
								{% endif %}

									{% set apply_lazy_load = home_main_product or not loop.first %}

									{% if apply_lazy_load %}
										{% set product_image_src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' %}
									{% else %}
										{% set product_image_src = media | product_image_url('large') %}
									{% endif %}

									<img 
										{% if not apply_lazy_load %}fetchpriority="high"{% endif %}
										{% if apply_lazy_load %}data-{% endif %}src="{{ product_image_src }}"
										{% if apply_lazy_load %}data-{% endif %}srcset='{{  media | product_image_url('large') }} 480w, {{  media | product_image_url('huge') }} 640w, {{  media | product_image_url('original') }} 1024w' 
										class="js-product-slide-img product-slider-image img-absolute img-absolute-centered {% if apply_lazy_load %}lazyautosizes lazyload{% endif %}" 
										{% if apply_lazy_load %}data-sizes="auto"{% endif %}
										{% if media.dimensions.width and media.dimensions.height %}width="{{ media.dimensions.width }}" height="{{ media.dimensions.height }}"{% endif %}
										{% if media.alt %}alt="{{media.alt}}"{% endif %} />
								{% if home_main_product %}
									</div>
								{% else %}
									</a>
								{% endif %}
							</div>
						{% else %}
							{% include 'snipplets/product/product-video.tpl' with {video_id: media.next_video, product_native_video: true, home_main_product: home_main_product} %}
						{% endif %}
					{% endfor %}
					{% if not home_main_product %}
						{% include 'snipplets/product/product-video.tpl' with {video_id: 'yt'} %}
					{% endif %}
				</div>
				{% if has_multiple_slides %}
					<button type="button" class="js-swiper-product-prev product-gallery-control product-gallery-prev" aria-label="{{ 'Ver imagen anterior' | translate }}" hidden>
						{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline"} %}
					</button>
					<button type="button" class="js-swiper-product-next product-gallery-control product-gallery-next" aria-label="{{ 'Ver siguiente imagen' | translate }}">
						{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline"} %}
					</button>
				{% endif %}
			</div>
			{% if has_multiple_slides %}
				<div class="js-swiper-product-pagination swiper-pagination position-relative py-3 d-md-none"></div>
			{% endif %}
		</div>
	{% endif %}
</div>
