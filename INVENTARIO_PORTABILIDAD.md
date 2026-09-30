# Inventario de portabilidad

Snapshot: 28/09/2026; base `e2a31d9`, HEAD `174defa`, incluido working tree inicial. Documentos de este relevamiento excluidos del conteo. Véase el [plan](./PLAN_PORTABILIDAD.md).

## Resumen

- 118 archivos: 84 agregados versionados (`A`), 27 originales modificados (`M`), 7 nuevos sin seguimiento (`?`).
- 107 archivos del tema/recursos; 11 de mantenimiento. 7 archivos versionados tienen edición local adicional a HEAD.
- 317 archivos versionados + 7 sin seguimiento al inicio; 206 sin diferencia neta con la base.
- `A`/`M` compara base → working tree; «Local» compara HEAD → working tree. Un archivo agregado meses atrás puede tener además cambios locales hoy.
- Comparación histórica adicional: ningún archivo tocado después de la base volvió exactamente al contenido inicial. No se identificaron eliminaciones.
- Primera copia disponible ≠ versión oficial certificada del tema. La lista no prueba modificaciones anteriores al primer commit.

## Archivos, uno por uno

| Archivo | Base | Local | Grupo | Preparación propuesta |
|---|---|---|---|---|
| [.agents/skills/trimetra-promos/SKILL.md](<./.agents/skills/trimetra-promos/SKILL.md>) | A | — | Herramientas / instrucciones | Kit de mantenimiento; fuera de FTPS |
| [.agents/skills/trimetra-promos/agents/openai.yaml](<./.agents/skills/trimetra-promos/agents/openai.yaml>) | A | — | Herramientas / instrucciones | Kit de mantenimiento; fuera de FTPS |
| [.gitignore](<./.gitignore>) | M | — | Documentación / entorno | Kit de mantenimiento; fuera de FTPS |
| [PRODUCT.md](<./PRODUCT.md>) | A | — | Documentación / entorno | Kit de mantenimiento; fuera de FTPS |
| [README.md](<./README.md>) | M | — | Documentación / entorno | Kit de mantenimiento; fuera de FTPS |
| [config/defaults.txt](<./config/defaults.txt>) | M | — | Integración / editor | Parche/adaptador; no reemplazo ciego |
| [config/sections.txt](<./config/sections.txt>) | M | — | Integración / editor | Parche/adaptador; no reemplazo ciego |
| [config/settings.txt](<./config/settings.txt>) | M | — | Integración / editor | Parche/adaptador; no reemplazo ciego |
| [config/translations.txt](<./config/translations.txt>) | M | — | Integración / editor | Parche/adaptador; no reemplazo ciego |
| [config/variants.txt](<./config/variants.txt>) | M | — | Integración / editor | Parche/adaptador; no reemplazo ciego |
| [layouts/layout.tpl](<./layouts/layout.tpl>) | M | Sí | Núcleo compartido: varios módulos | Parche/adaptador; no reemplazo ciego |
| [package-lock.json](<./package-lock.json>) | A | — | Validación | Kit de mantenimiento; fuera de FTPS |
| [package.json](<./package.json>) | A | — | Validación | Kit de mantenimiento; fuera de FTPS |
| [playwright.config.mjs](<./playwright.config.mjs>) | A | — | Validación | Kit de mantenimiento; fuera de FTPS |
| [scripts/check-custom-pages.mjs](<./scripts/check-custom-pages.mjs>) | A | — | Validación | Kit de mantenimiento; fuera de FTPS |
| [snipplets/brand-promo/brand.tpl](<./snipplets/brand-promo/brand.tpl>) | ? | Nuevo | Landing marcas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/brand-promo/card.tpl](<./snipplets/brand-promo/card.tpl>) | ? | Nuevo | Landing marcas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/brand-promo/context.tpl](<./snipplets/brand-promo/context.tpl>) | ? | Nuevo | Landing marcas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/brand-promo/landing.tpl](<./snipplets/brand-promo/landing.tpl>) | ? | Nuevo | Landing marcas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-about-page.tpl](<./snipplets/custom-about-page.tpl>) | A | — | Página quiénes somos | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-contact-hours-page.tpl](<./snipplets/custom-contact-hours-page.tpl>) | A | — | Página contacto y horarios | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-giveaway-page.tpl](<./snipplets/custom-giveaway-page.tpl>) | A | — | Páginas de estado de campañas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-hot-days-page.tpl](<./snipplets/custom-hot-days-page.tpl>) | A | — | Páginas de estado de campañas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-pages/business-facts.tpl](<./snipplets/custom-pages/business-facts.tpl>) | A | — | Núcleo páginas / perfil | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-pages/page-context.tpl](<./snipplets/custom-pages/page-context.tpl>) | A | — | Núcleo páginas / perfil | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-payment-page.tpl](<./snipplets/custom-payment-page.tpl>) | A | — | Página pagos | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-pre-promo-page.tpl](<./snipplets/custom-pre-promo-page.tpl>) | A | — | Páginas de estado de campañas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-preventas-page.tpl](<./snipplets/custom-preventas-page.tpl>) | A | — | Página preventas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-shipping-page.tpl](<./snipplets/custom-shipping-page.tpl>) | A | — | Página envíos | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/custom-warranty-page.tpl](<./snipplets/custom-warranty-page.tpl>) | A | — | Página garantías | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/defaults/home/banners_help.tpl](<./snipplets/defaults/home/banners_help.tpl>) | M | — | Home banners fluidos | Parche/adaptador; no reemplazo ciego |
| [snipplets/defaults/home/reviews_help.tpl](<./snipplets/defaults/home/reviews_help.tpl>) | A | — | Opiniones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/defaults/home/sale_video_help.tpl](<./snipplets/defaults/home/sale_video_help.tpl>) | A | — | Home ofertas + video | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/grid/item.tpl](<./snipplets/grid/item.tpl>) | M | — | Catálogo / ficha producto | Parche/adaptador; no reemplazo ciego |
| [snipplets/header/header-advertising.tpl](<./snipplets/header/header-advertising.tpl>) | M | Sí | Cuotas / promociones | Parche/adaptador; no reemplazo ciego |
| [snipplets/header/header.tpl](<./snipplets/header/header.tpl>) | M | — | Navegación | Parche/adaptador; no reemplazo ciego |
| [snipplets/home/home-category-banners-fluid.tpl](<./snipplets/home/home-category-banners-fluid.tpl>) | A | — | Home banners fluidos | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/home/home-featured-grid.tpl](<./snipplets/home/home-featured-grid.tpl>) | M | — | Home grilla / título heredado | Parche/adaptador; no reemplazo ciego |
| [snipplets/home/home-main-product-video.tpl](<./snipplets/home/home-main-product-video.tpl>) | A | — | Home producto + video | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/home/home-reviews.tpl](<./snipplets/home/home-reviews.tpl>) | A | — | Opiniones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/home/home-sale-video.tpl](<./snipplets/home/home-sale-video.tpl>) | A | — | Home ofertas + video | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/home/home-section-switch.tpl](<./snipplets/home/home-section-switch.tpl>) | M | — | Integración / editor | Parche/adaptador; no reemplazo ciego |
| [snipplets/navigation/navigation-nav-list.tpl](<./snipplets/navigation/navigation-nav-list.tpl>) | M | — | Navegación | Parche/adaptador; no reemplazo ciego |
| [snipplets/payment-installments-config.tpl](<./snipplets/payment-installments-config.tpl>) | A | Sí | Cuotas / promociones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/payment-promo-product-eligibility.tpl](<./snipplets/payment-promo-product-eligibility.tpl>) | A | Sí | Cuotas / promociones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/pre-promo-brevo-form.tpl](<./snipplets/pre-promo-brevo-form.tpl>) | A | — | Archivo histórico / sin consumidor | Archivar; sin consumidor localizado |
| [snipplets/product/product-description.tpl](<./snipplets/product/product-description.tpl>) | M | — | Catálogo / ficha producto | Parche/adaptador; no reemplazo ciego |
| [snipplets/product/product-form.tpl](<./snipplets/product/product-form.tpl>) | M | — | Catálogo / ficha producto | Parche/adaptador; no reemplazo ciego |
| [snipplets/product/product-image.tpl](<./snipplets/product/product-image.tpl>) | M | — | Catálogo / ficha producto | Parche/adaptador; no reemplazo ciego |
| [snipplets/product/product-installments-summary.tpl](<./snipplets/product/product-installments-summary.tpl>) | A | — | Cuotas / promociones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/promo-3d-printer-badge.tpl](<./snipplets/promo-3d-printer-badge.tpl>) | A | — | Cuotas / promociones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/reviews/review-card.tpl](<./snipplets/reviews/review-card.tpl>) | A | — | Opiniones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/reviews/reviews-block.tpl](<./snipplets/reviews/reviews-block.tpl>) | A | — | Opiniones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/reviews/reviews-settings.tpl](<./snipplets/reviews/reviews-settings.tpl>) | A | — | Opiniones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/svg/google.tpl](<./snipplets/svg/google.tpl>) | A | — | Opiniones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/svg/mercado-libre.tpl](<./snipplets/svg/mercado-libre.tpl>) | A | — | Opiniones | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/trust-bar.tpl](<./snipplets/trust-bar.tpl>) | A | — | Home confianza / cuotas | Archivo propio; parametrizar y resolver dependencias |
| [snipplets/why-trimetra.tpl](<./snipplets/why-trimetra.tpl>) | A | — | Home propuesta de valor | Archivo propio; parametrizar y resolver dependencias |
| [static/checkout.scss.tpl](<./static/checkout.scss.tpl>) | M | — | Checkout opcional | Parche/adaptador; no reemplazo ciego |
| [static/css/about-page.scss](<./static/css/about-page.scss>) | A | — | Página quiénes somos | Archivo propio; parametrizar y resolver dependencias |
| [static/css/brand-promo.scss](<./static/css/brand-promo.scss>) | ? | Nuevo | Landing marcas | Archivo propio; parametrizar y resolver dependencias |
| [static/css/contact-hours-page.scss](<./static/css/contact-hours-page.scss>) | A | — | Página contacto y horarios | Archivo propio; parametrizar y resolver dependencias |
| [static/css/custom-pages-base.scss](<./static/css/custom-pages-base.scss>) | A | — | Núcleo páginas / perfil | Archivo propio; parametrizar y resolver dependencias |
| [static/css/giveaway-page.scss](<./static/css/giveaway-page.scss>) | A | — | Páginas de estado de campañas | Archivo propio; parametrizar y resolver dependencias |
| [static/css/hot-days-page.scss](<./static/css/hot-days-page.scss>) | A | — | Páginas de estado de campañas | Archivo propio; parametrizar y resolver dependencias |
| [static/css/hot-sale-product-badge.scss](<./static/css/hot-sale-product-badge.scss>) | A | — | Archivo histórico / sin consumidor | Archivar; sin consumidor localizado |
| [static/css/payment-page.scss](<./static/css/payment-page.scss>) | A | — | Página pagos | Archivo propio; parametrizar y resolver dependencias |
| [static/css/pre-promo-page.scss](<./static/css/pre-promo-page.scss>) | A | — | Páginas de estado de campañas | Archivo propio; parametrizar y resolver dependencias |
| [static/css/preventas-page.scss](<./static/css/preventas-page.scss>) | A | — | Página preventas | Archivo propio; parametrizar y resolver dependencias |
| [static/css/shipping-page.scss](<./static/css/shipping-page.scss>) | A | — | Página envíos | Archivo propio; parametrizar y resolver dependencias |
| [static/css/single-product.scss](<./static/css/single-product.scss>) | A | — | Catálogo / ficha producto | Archivo propio; parametrizar y resolver dependencias |
| [static/css/style-async.scss](<./static/css/style-async.scss>) | M | — | Núcleo compartido: varios módulos | Parche/adaptador; no reemplazo ciego |
| [static/css/style-colors.scss](<./static/css/style-colors.scss>) | M | — | Núcleo compartido: varios módulos | Parche/adaptador; no reemplazo ciego |
| [static/css/style-critical.scss](<./static/css/style-critical.scss>) | M | — | Núcleo compartido: varios módulos | Parche/adaptador; no reemplazo ciego |
| [static/css/warranty-page.scss](<./static/css/warranty-page.scss>) | A | — | Página garantías | Archivo propio; parametrizar y resolver dependencias |
| [static/images/9csi-septiembre_octubre/promobanner.jpg](<./static/images/9csi-septiembre_octubre/promobanner.jpg>) | ? | Nuevo | Landing marcas | Recurso de perfil; revisar referencias |
| [static/images/about/.gitkeep](<./static/images/about/.gitkeep>) | A | — | Página quiénes somos | Marcador; no necesario en runtime |
| [static/images/about/about-operation.mp4](<./static/images/about/about-operation.mp4>) | A | — | Página quiénes somos | Recurso de perfil; revisar referencias |
| [static/images/about/about-products_small.jpg](<./static/images/about/about-products_small.jpg>) | A | — | Página quiénes somos | Recurso de perfil; revisar referencias |
| [static/images/about/about-team.webm](<./static/images/about/about-team.webm>) | A | — | Página quiénes somos | Recurso de perfil; revisar referencias |
| [static/images/about/about-workshop.jpg](<./static/images/about/about-workshop.jpg>) | A | — | Página quiénes somos | Recurso de perfil; revisar referencias |
| [static/images/about/about-workshop_small.jpg](<./static/images/about/about-workshop_small.jpg>) | A | — | Página quiénes somos | Recurso de perfil; revisar referencias |
| [static/images/hot-days/filamentos-10kg-hero.webp](<./static/images/hot-days/filamentos-10kg-hero.webp>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/hot-days/hot-days-ad-h264.mp4](<./static/images/hot-days/hot-days-ad-h264.mp4>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/hot-days/hot-days-ad-poster-vertical.webp](<./static/images/hot-days/hot-days-ad-poster-vertical.webp>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/hot-days/hot-days-ad-poster.webp](<./static/images/hot-days/hot-days-ad-poster.webp>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/hot-days/principal_1_MOBILE.png](<./static/images/hot-days/principal_1_MOBILE.png>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/payment-logos/Banco-del-Sol.png](<./static/images/payment-logos/Banco-del-Sol.png>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/payment-logos/Mercado_Pago.svg.webp](<./static/images/payment-logos/Mercado_Pago.svg.webp>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/payment-logos/NaranjaX-logo.svg.png](<./static/images/payment-logos/NaranjaX-logo.svg.png>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/payment-logos/banconacion_logo.png](<./static/images/payment-logos/banconacion_logo.png>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/payment-logos/image-16.png](<./static/images/payment-logos/image-16.png>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/payment-logos/logo-American-Express.png](<./static/images/payment-logos/logo-American-Express.png>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/payment-logos/oncity_logo.png](<./static/images/payment-logos/oncity_logo.png>) | A | — | Recursos históricos / verificar admin | Recurso de perfil; revisar referencias |
| [static/images/shipping-zones-map.png](<./static/images/shipping-zones-map.png>) | A | — | Página envíos | Recurso de perfil; revisar referencias |
| [static/images/sorteo/impresora-3d-bambu-lab-a1-combo.png](<./static/images/sorteo/impresora-3d-bambu-lab-a1-combo.png>) | A | — | Landing marcas: fallback heredado | Recurso de perfil; revisar referencias |
| [static/images/trimetrahub-preview.png](<./static/images/trimetrahub-preview.png>) | A | — | Home propuesta de valor | Recurso de perfil; revisar referencias |
| [static/images/trimetrahub-preview1.png](<./static/images/trimetrahub-preview1.png>) | A | — | Home propuesta de valor | Recurso de perfil; revisar referencias |
| [static/js/about-page.js.tpl](<./static/js/about-page.js.tpl>) | A | — | Página quiénes somos | Archivo propio; parametrizar y resolver dependencias |
| [static/js/brand-promo.js.tpl](<./static/js/brand-promo.js.tpl>) | ? | Nuevo | Landing marcas | Archivo propio; parametrizar y resolver dependencias |
| [static/js/contact-hours-page.js.tpl](<./static/js/contact-hours-page.js.tpl>) | A | — | Página contacto y horarios | Placeholder; mantener solo si router lo requiere |
| [static/js/custom-pages.js.tpl](<./static/js/custom-pages.js.tpl>) | A | — | Núcleo páginas / perfil | Archivo propio; parametrizar y resolver dependencias |
| [static/js/giveaway-page.js.tpl](<./static/js/giveaway-page.js.tpl>) | A | — | Páginas de estado de campañas | Placeholder; mantener solo si router lo requiere |
| [static/js/hot-days-page.js.tpl](<./static/js/hot-days-page.js.tpl>) | A | — | Páginas de estado de campañas | Placeholder; mantener solo si router lo requiere |
| [static/js/instatheme-4705b9ac39b70890a34e138d0638c18530.js](<./static/js/instatheme-4705b9ac39b70890a34e138d0638c18530.js>) | M | — | Integración / editor | Parche/adaptador; no reemplazo ciego |
| [static/js/payment-page.js.tpl](<./static/js/payment-page.js.tpl>) | A | — | Página pagos | Placeholder; mantener solo si router lo requiere |
| [static/js/pre-promo-page.js.tpl](<./static/js/pre-promo-page.js.tpl>) | A | — | Páginas de estado de campañas | Placeholder; mantener solo si router lo requiere |
| [static/js/preventas-page.js.tpl](<./static/js/preventas-page.js.tpl>) | A | — | Página preventas | Placeholder; mantener solo si router lo requiere |
| [static/js/shipping-page.js.tpl](<./static/js/shipping-page.js.tpl>) | A | — | Página envíos | Placeholder; mantener solo si router lo requiere |
| [static/js/store.js.tpl](<./static/js/store.js.tpl>) | M | Sí | Núcleo compartido: varios módulos | Parche/adaptador; no reemplazo ciego |
| [static/js/warranty-page.js.tpl](<./static/js/warranty-page.js.tpl>) | A | — | Página garantías | Placeholder; mantener solo si router lo requiere |
| [static/videos/150-9_cuotas_con_cajas.mp4](<./static/videos/150-9_cuotas_con_cajas.mp4>) | A | — | Video campaña / verificar admin | Recurso de perfil; revisar referencias |
| [static/videos/snapmaker_llego-trimetra3d.mp4](<./static/videos/snapmaker_llego-trimetra3d.mp4>) | A | — | Home producto + video | Recurso de perfil; revisar referencias |
| [templates/category.tpl](<./templates/category.tpl>) | M | Sí | Landing marcas | Parche/adaptador; no reemplazo ciego |
| [templates/home.tpl](<./templates/home.tpl>) | M | — | Integración / editor | Parche/adaptador; no reemplazo ciego |
| [templates/page.tpl](<./templates/page.tpl>) | M | — | Núcleo páginas / perfil | Parche/adaptador; no reemplazo ciego |
| [tests/custom-pages/custom-pages.spec.mjs](<./tests/custom-pages/custom-pages.spec.mjs>) | A | — | Validación | Kit de mantenimiento; fuera de FTPS |
| [tests/custom-pages/promo-countdown.spec.mjs](<./tests/custom-pages/promo-countdown.spec.mjs>) | A | Sí | Validación | Kit de mantenimiento; fuera de FTPS |

## Recursos y consumidores localizados

Búsqueda de ruta literal en archivos de código/config actuales. No consulta settings guardados remotamente. Un recurso sin referencias puede estar seleccionado desde el administrador. Los tamaños no estiman el ZIP final.

| Recurso | KiB | Referencias de código |
|---|---:|---|
| [static/images/9csi-septiembre_octubre/promobanner.jpg](<./static/images/9csi-septiembre_octubre/promobanner.jpg>) | 708.0 | Sin referencia literal; verificar admin |
| [static/images/about/.gitkeep](<./static/images/about/.gitkeep>) | 0.0 | Sin referencia literal; verificar admin |
| [static/images/about/about-operation.mp4](<./static/images/about/about-operation.mp4>) | 17043.9 | [snipplets/custom-about-page.tpl](<./snipplets/custom-about-page.tpl>) |
| [static/images/about/about-products_small.jpg](<./static/images/about/about-products_small.jpg>) | 45.5 | [snipplets/custom-about-page.tpl](<./snipplets/custom-about-page.tpl>); [snipplets/custom-preventas-page.tpl](<./snipplets/custom-preventas-page.tpl>) |
| [static/images/about/about-team.webm](<./static/images/about/about-team.webm>) | 2305.1 | [snipplets/custom-about-page.tpl](<./snipplets/custom-about-page.tpl>) |
| [static/images/about/about-workshop.jpg](<./static/images/about/about-workshop.jpg>) | 213.1 | [snipplets/custom-about-page.tpl](<./snipplets/custom-about-page.tpl>) |
| [static/images/about/about-workshop_small.jpg](<./static/images/about/about-workshop_small.jpg>) | 44.5 | [snipplets/custom-about-page.tpl](<./snipplets/custom-about-page.tpl>) |
| [static/images/hot-days/filamentos-10kg-hero.webp](<./static/images/hot-days/filamentos-10kg-hero.webp>) | 56.3 | Sin referencia literal; verificar admin |
| [static/images/hot-days/hot-days-ad-h264.mp4](<./static/images/hot-days/hot-days-ad-h264.mp4>) | 15553.2 | Sin referencia literal; verificar admin |
| [static/images/hot-days/hot-days-ad-poster-vertical.webp](<./static/images/hot-days/hot-days-ad-poster-vertical.webp>) | 61.6 | Sin referencia literal; verificar admin |
| [static/images/hot-days/hot-days-ad-poster.webp](<./static/images/hot-days/hot-days-ad-poster.webp>) | 50.2 | Sin referencia literal; verificar admin |
| [static/images/hot-days/principal_1_MOBILE.png](<./static/images/hot-days/principal_1_MOBILE.png>) | 40.7 | Sin referencia literal; verificar admin |
| [static/images/payment-logos/Banco-del-Sol.png](<./static/images/payment-logos/Banco-del-Sol.png>) | 9.0 | Sin referencia literal; verificar admin |
| [static/images/payment-logos/Mercado_Pago.svg.webp](<./static/images/payment-logos/Mercado_Pago.svg.webp>) | 21.2 | Sin referencia literal; verificar admin |
| [static/images/payment-logos/NaranjaX-logo.svg.png](<./static/images/payment-logos/NaranjaX-logo.svg.png>) | 26.4 | Sin referencia literal; verificar admin |
| [static/images/payment-logos/banconacion_logo.png](<./static/images/payment-logos/banconacion_logo.png>) | 6.7 | Sin referencia literal; verificar admin |
| [static/images/payment-logos/image-16.png](<./static/images/payment-logos/image-16.png>) | 9.7 | Sin referencia literal; verificar admin |
| [static/images/payment-logos/logo-American-Express.png](<./static/images/payment-logos/logo-American-Express.png>) | 8.6 | Sin referencia literal; verificar admin |
| [static/images/payment-logos/oncity_logo.png](<./static/images/payment-logos/oncity_logo.png>) | 19.4 | Sin referencia literal; verificar admin |
| [static/images/shipping-zones-map.png](<./static/images/shipping-zones-map.png>) | 64.0 | [snipplets/custom-shipping-page.tpl](<./snipplets/custom-shipping-page.tpl>) |
| [static/images/sorteo/impresora-3d-bambu-lab-a1-combo.png](<./static/images/sorteo/impresora-3d-bambu-lab-a1-combo.png>) | 292.8 | [snipplets/brand-promo/landing.tpl](<./snipplets/brand-promo/landing.tpl>) |
| [static/images/trimetrahub-preview.png](<./static/images/trimetrahub-preview.png>) | 99.9 | [snipplets/why-trimetra.tpl](<./snipplets/why-trimetra.tpl>) |
| [static/images/trimetrahub-preview1.png](<./static/images/trimetrahub-preview1.png>) | 131.0 | Sin referencia literal; verificar admin |
| [static/videos/150-9_cuotas_con_cajas.mp4](<./static/videos/150-9_cuotas_con_cajas.mp4>) | 28497.1 | Sin referencia literal; verificar admin |
| [static/videos/snapmaker_llego-trimetra3d.mp4](<./static/videos/snapmaker_llego-trimetra3d.mp4>) | 22358.0 | [config/defaults.txt](<./config/defaults.txt>) |

Total: **25 entradas / 85,61 MiB**, incluida `.gitkeep`.

## Dependencias existentes sin cambios que no deben perderse

Estas piezas no son desarrollos nuevos de este historial. El adaptador comprueba que existan en el destino; no debe sobrescribirlas por conveniencia.

| Dependencia | Función |
|---|---|
| [config/data.json](<./config/data.json>) | Configuración de compilación de preview; no export de settings de la tienda |
| [static/css/style-tokens.tpl](<./static/css/style-tokens.tpl>) | Tokens del tema; afectan los módulos custom |
| [static/js/external.js.tpl](<./static/js/external.js.tpl>) | Bibliotecas del tema |
| [static/js/external-no-dependencies.js.tpl](<./static/js/external-no-dependencies.js.tpl>) | Bibliotecas base; comprobar versiones y disponibilidad |
| [snipplets/grid/quick-shop.tpl](<./snipplets/grid/quick-shop.tpl>) | Compra rápida nativa |
| [snipplets/product/product-variants.tpl](<./snipplets/product/product-variants.tpl>) | Selector de variantes |
| [snipplets/product/product-quantity.tpl](<./snipplets/product/product-quantity.tpl>) | Selector de cantidad |
| [snipplets/product/product-payment-details.tpl](<./snipplets/product/product-payment-details.tpl>) | Detalle nativo de pagos |
| [snipplets/labels.tpl](<./snipplets/labels.tpl>) | Etiquetas nativas de producto |
| [snipplets/svg/](<./snipplets/svg/>) | Iconos nativos usados en nuevos módulos; Google y Mercado Libre sí son agregados |
| [snipplets/whatsapp-chat.tpl](<./snipplets/whatsapp-chat.tpl>) | Botón nativo de WhatsApp; distinto del widget Chatwoot agregado |
| [snipplets/footer/footer.tpl](<./snipplets/footer/footer.tpl>) | Footer nativo; depende de menús/settings externos |
| [templates/product.tpl](<./templates/product.tpl>) | Template de producto que incluye los snippets modificados |
| [templates/contact.tpl](<./templates/contact.tpl>) | Formulario nativo de contacto, conservar |
| [templates/cart.tpl](<./templates/cart.tpl>) | Carrito nativo, conservar |
| [templates/search.tpl](<./templates/search.tpl>) | Búsqueda nativa, conservar |
| [snipplets/home/home-testimonials.tpl](<./snipplets/home/home-testimonials.tpl>) | Testimonios originales, distintos del módulo nuevo de opiniones |
| [snipplets/home/home-main-product.tpl](<./snipplets/home/home-main-product.tpl>) | Producto principal nativo, reutilizado por la home |

## Material local ignorado por Git

Los 22 archivos siguientes están en la carpeta de documentación ignorada. Pueden aportar contenido de referencia, pero no son runtime ni necesariamente describen la implementación vigente. No se debe redistribuir automáticamente documentación operativa de Trimetra.

- [docs/CRO/deep-research-report.md](<./docs/CRO/deep-research-report.md>)
- [docs/Contacto y horarios/contact_channels.docx](<./docs/Contacto y horarios/contact_channels.docx>)
- [docs/Contacto y horarios/operational_hours.xlsx](<./docs/Contacto y horarios/operational_hours.xlsx>)
- [docs/Contacto y horarios/operational_hours_text.docx](<./docs/Contacto y horarios/operational_hours_text.docx>)
- [docs/contrato_de_programacion.md](<./docs/contrato_de_programacion.md>)
- [docs/custom_static_page.md](<./docs/custom_static_page.md>)
- [docs/envios.html](<./docs/envios.html>)
- [docs/features-testimonials.md](<./docs/features-testimonials.md>)
- [docs/garantia/Garantía.jpeg](<./docs/garantia/Garantía.jpeg>)
- [docs/garantia/policies_returns_text.docx](<./docs/garantia/policies_returns_text.docx>)
- [docs/garantia/policies_warranty_printers_text.docx](<./docs/garantia/policies_warranty_printers_text.docx>)
- [docs/landing_sorteo/info_extra.md](<./docs/landing_sorteo/info_extra.md>)
- [docs/landing_sorteo/insert_brevo.md](<./docs/landing_sorteo/insert_brevo.md>)
- [docs/pagos/Promociones Bancarias 3P Abril 2026.xlsx](<./docs/pagos/Promociones Bancarias 3P Abril 2026.xlsx>)
- [docs/pagos/payment_methods.xlsx](<./docs/pagos/payment_methods.xlsx>)
- [docs/pagos/payment_promos.xlsx](<./docs/pagos/payment_promos.xlsx>)
- [docs/pagos/policies_payment_text.docx](<./docs/pagos/policies_payment_text.docx>)
- [docs/pagos/promo_section_template.md](<./docs/pagos/promo_section_template.md>)
- [docs/preventas/info_preventas.md](<./docs/preventas/info_preventas.md>)
- [docs/quienes_somos/quienes_somos.md](<./docs/quienes_somos/quienes_somos.md>)
- [docs/trimetrahub-preview.png](<./docs/trimetrahub-preview.png>)
- [docs/trust-bar/features-trustbar.md](<./docs/trust-bar/features-trustbar.md>)

## Exclusiones del paquete publicable

- `.git/`, backups FTPS/configuración local, configuración de editor, `node_modules/`, reportes y resultados de pruebas.
- [.vscode/settings.json](<./.vscode/settings.json>) ya está versionado desde la base aunque la carpeta figura en `.gitignore`; un `git archive` indiscriminado lo incluiría.
- Documentación de negocio, pruebas y skills: solo en el kit de mantenimiento cuando corresponda, nunca dentro de la raíz a subir al tema.
- Credenciales y configuración de servicios de la tienda origen; el token público de Chatwoot y el formulario Brevo tampoco deben apuntar al origen por defecto.

## Registro de cambios locales al iniciar

Estos archivos necesitan consolidación antes de generar una versión redistribuible. No se modificaron durante este relevamiento.

- Edición local: [layouts/layout.tpl](<./layouts/layout.tpl>)
- Edición local: [snipplets/header/header-advertising.tpl](<./snipplets/header/header-advertising.tpl>)
- Edición local: [snipplets/payment-installments-config.tpl](<./snipplets/payment-installments-config.tpl>)
- Edición local: [snipplets/payment-promo-product-eligibility.tpl](<./snipplets/payment-promo-product-eligibility.tpl>)
- Edición local: [static/js/store.js.tpl](<./static/js/store.js.tpl>)
- Edición local: [templates/category.tpl](<./templates/category.tpl>)
- Edición local: [tests/custom-pages/promo-countdown.spec.mjs](<./tests/custom-pages/promo-countdown.spec.mjs>)
- Nuevo sin seguimiento: [snipplets/brand-promo/brand.tpl](<./snipplets/brand-promo/brand.tpl>)
- Nuevo sin seguimiento: [snipplets/brand-promo/card.tpl](<./snipplets/brand-promo/card.tpl>)
- Nuevo sin seguimiento: [snipplets/brand-promo/context.tpl](<./snipplets/brand-promo/context.tpl>)
- Nuevo sin seguimiento: [snipplets/brand-promo/landing.tpl](<./snipplets/brand-promo/landing.tpl>)
- Nuevo sin seguimiento: [static/css/brand-promo.scss](<./static/css/brand-promo.scss>)
- Nuevo sin seguimiento: [static/images/9csi-septiembre_octubre/promobanner.jpg](<./static/images/9csi-septiembre_octubre/promobanner.jpg>)
- Nuevo sin seguimiento: [static/js/brand-promo.js.tpl](<./static/js/brand-promo.js.tpl>)
