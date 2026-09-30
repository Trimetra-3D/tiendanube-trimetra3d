# Tickets aprobados de la app

Repositorio privado: [Trimetra-3D/tiendanube-modules](https://github.com/Trimetra-3D/tiendanube-modules). Los seis tickets están publicados con `ready-for-agent` y dependencias nativas de GitHub.

Una instalación por tienda, accesible desde su administrador; sin dashboard central. Se mantienen los 26 módulos y las pruebas dentro de seis entregas.

## Tickets

1. **[App instalada y primer módulo funcional](https://github.com/Trimetra-3D/tiendanube-modules/issues/1)** — **Bloqueado por:** ninguno.
   **Entrega:** Instalar la app, abrirla desde el administrador de esa tienda y configurar una barra de beneficios que funcione en el storefront.

2. **[Módulos de inicio](https://github.com/Trimetra-3D/tiendanube-modules/issues/2)** — **Bloqueado por:** [#1](https://github.com/Trimetra-3D/tiendanube-modules/issues/1).
   **Entrega:** Configurar opiniones, propuesta de valor, banners y bloques de producto/ofertas con video, conservando la home propia de la tienda.

3. **[Catálogo, navegación y fichas de producto](https://github.com/Trimetra-3D/tiendanube-modules/issues/3)** — **Bloqueado por:** [#1](https://github.com/Trimetra-3D/tiendanube-modules/issues/1).
   **Entrega:** Aplicar mejoras compatibles a navegación, tarjetas, cuotas, variantes y descripciones sin perder contenido ni funcionalidades nativas.

4. **[Promociones y preventas](https://github.com/Trimetra-3D/tiendanube-modules/issues/4)** — **Bloqueado por:** [#3](https://github.com/Trimetra-3D/tiendanube-modules/issues/3).
   **Entrega:** Configurar campañas, countdown, badges, landings y preventas con alcance y vigencia propios de la tienda.

5. **[Páginas informativas e integraciones](https://github.com/Trimetra-3D/tiendanube-modules/issues/5)** — **Bloqueado por:** [#3](https://github.com/Trimetra-3D/tiendanube-modules/issues/3).
   **Entrega:** Configurar las páginas informativas de la marca y habilitar chat, medición y apariencia de checkout donde sean compatibles.

6. **[Actualizaciones y validación final](https://github.com/Trimetra-3D/tiendanube-modules/issues/6)** — **Bloqueado por:** [#2](https://github.com/Trimetra-3D/tiendanube-modules/issues/2), [#4](https://github.com/Trimetra-3D/tiendanube-modules/issues/4), [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5).
   **Entrega:** Actualizar y restaurar módulos/configuración, retirar la app de forma segura y preparar una release piloto con evidencia de todos los módulos habilitados.

## Cobertura

| Módulo | Issue |
|---|---|
| `home.benefits` | [#1](https://github.com/Trimetra-3D/tiendanube-modules/issues/1) |
| `home.reviews` | [#2](https://github.com/Trimetra-3D/tiendanube-modules/issues/2) |
| `home.value-proposition` | [#2](https://github.com/Trimetra-3D/tiendanube-modules/issues/2) |
| `home.product-video` | [#2](https://github.com/Trimetra-3D/tiendanube-modules/issues/2) |
| `home.offers-video` | [#2](https://github.com/Trimetra-3D/tiendanube-modules/issues/2) |
| `home.category-banners` | [#2](https://github.com/Trimetra-3D/tiendanube-modules/issues/2) |
| `navigation.enhancements` | [#3](https://github.com/Trimetra-3D/tiendanube-modules/issues/3) |
| `catalog.product-cards` | [#3](https://github.com/Trimetra-3D/tiendanube-modules/issues/3) |
| `catalog.installments` | [#3](https://github.com/Trimetra-3D/tiendanube-modules/issues/3) |
| `catalog.stock-variants` | [#3](https://github.com/Trimetra-3D/tiendanube-modules/issues/3) |
| `product.description-layout` | [#3](https://github.com/Trimetra-3D/tiendanube-modules/issues/3) |
| `product.rich-description` | [#3](https://github.com/Trimetra-3D/tiendanube-modules/issues/3) |
| `promotions.campaigns` | [#4](https://github.com/Trimetra-3D/tiendanube-modules/issues/4) |
| `promotions.countdown` | [#4](https://github.com/Trimetra-3D/tiendanube-modules/issues/4) |
| `promotions.badges` | [#4](https://github.com/Trimetra-3D/tiendanube-modules/issues/4) |
| `promotions.landing` | [#4](https://github.com/Trimetra-3D/tiendanube-modules/issues/4) |
| `promotions.status-pages` | [#4](https://github.com/Trimetra-3D/tiendanube-modules/issues/4) |
| `commerce.preorders` | [#4](https://github.com/Trimetra-3D/tiendanube-modules/issues/4) |
| `pages.shipping` | [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5) |
| `pages.payment` | [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5) |
| `pages.warranty` | [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5) |
| `pages.contact` | [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5) |
| `pages.about` | [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5) |
| `integrations.chat` | [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5) |
| `integrations.analytics` | [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5) |
| `checkout.appearance` | [#5](https://github.com/Trimetra-3D/tiendanube-modules/issues/5) |

Cada ticket incluye sus pruebas. El último verifica la combinación y la operación de la release. El primer ticket es el único sin bloqueos iniciales.
