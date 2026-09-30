# Contrato de render de los 26 módulos

Auditoría estática del repositorio: 2026-09-28. Solo planificación; no se modificó el runtime ni se probó una tienda remota. Complementa el [catálogo](./CATALOGO_MODULOS.md) y el [plan](./PLAN_PORTABILIDAD.md). Los riesgos identificados por código no equivalen a un CLS medido en producción.

## Decisión arquitectónica

La app debe ser el gestor y publicador de una integración nativa del tema. No debe reconstruir la tienda desde el navegador. Publica configuración, Twig y recursos versionados; Tiendanube resuelve productos, precios, stock y HTML en cada respuesta. El visitante no consulta nuestro backend para descubrir, configurar o renderizar módulos.

Cada módulo declara: ubicaciones opt-in, compatibilidad con la versión del tema, dependencias, plantilla, estilos de geometría inicial, estilos secundarios, JS de interacción, datos nativos necesarios, dimensiones de medios y prueba de degradación. La biblioteca tiene 26 candidatos; no significa cargar 26 módulos en cada ruta. Deshabilitado debe significar sin markup, CSS, JS ni recursos propios en esa ruta.

La home y el catálogo de destino siguen siendo la fuente de verdad. No se reemplazan con los del origen. Instalar deja módulos disponibles; insertar, reordenar o sustituir una ubicación es una decisión explícita. Las rutas existentes tampoco se apropian por coincidencia de nombre.

### Qué significa «desde el inicio»

- Texto, estructura, clases y estado visual inicial: presentes en el HTML de respuesta, aunque se bloquee el JS de nuestros módulos.
- CSS que determina geometría y visibilidad: antes del primer render, inline acotado o stylesheet normal en `head`. CSS bloqueante evita el cambio tardío de estilo, pero tiene costo de descarga y puede retrasar FCP: se presupuesta y mide.
- Imágenes del primer viewport: URL real en HTML, dimensiones/proporción conocidas, prioridad selectiva. El HTML inicial no garantiza que la imagen ya se descargó; no cargar imágenes visibles con un placeholder que necesita JS para descubrir su URL.
- Carruseles: tarjetas y geometría disponibles sin inicializador. JS agrega navegación sin cambiar ancho, altura o cantidad visible.
- El JS puede llegar después sin cambiar el aspecto. No se oculta contenido hasta `ready`, `load`, un observer o una llamada de API.
- La ausencia de saltos no prueba ausencia de aparición tardía: hay que medir ambas cosas. Un esqueleto fijo evita CLS, pero no satisface el requisito de contenido real inicial.

## Matriz completa

«Nativo» describe el destino propuesto; no declara que el código actual ya cumpla el contrato. Las páginas informativas usan el patrón de CSS normal en `head` de [layout](./layouts/layout.tpl), líneas 87–92.

| ID | HTML inicial y datos | CSS inicial | JS permitido después / trabajo necesario |
|---|---|---|---|
| `home.reviews` | Opiniones, autor, puntuación, fuente y controles desde [reviews-block](./snipplets/reviews/reviews-block.tpl) y [review-card](./snipplets/reviews/review-card.tpl); contenido aprobado, no fetch al proveedor. | Mover geometría y recortes de texto de CSS async a bundle condicional inicial; avatar con dimensiones; navegación con espacio estable. | Expandir texto y avanzar tarjetas. Preferir scroll-snap; si conserva Swiper, geometría idéntica antes/después. No ocultar opiniones hasta inicializar. |
| `home.benefits` | Textos, iconos y enlaces desde [trust-bar](./snipplets/trust-bar.tpl). | Grid/scroll horizontal inicial; hoy la geometría está en CSS async. | Puede ser 0 JS. Desplazamiento nativo en móvil. |
| `home.value-proposition` | Diferenciales desde [why-trimetra](./snipplets/why-trimetra.tpl), generalizado con contenido propio. | Grid, medios y tipografía inicial; hoy casi todo está en CSS async. | Puede ser 0 JS. Eliminar dependencia visual de animaciones de entrada; imagen con proporción conocida. |
| `home.product-video` | Producto, precio, formulario nativo y poster desde [home-main-product-video](./snipplets/home/home-main-product-video.tpl). Mantener producto explícitamente elegido por destino. | Ya hay marco 9:16 en [style-critical](./static/css/style-critical.scss), línea 2117; extraer estilo condicional y conservar geometría del formulario/galería. | Compra y variantes nativas; reproducción tras acción. Poster obligatorio; no insertar video tardíamente ni publicar stock/precio como constantes. Evitar selección aleatoria si se busca estabilidad editorial. |
| `home.offers-video` | Productos de selección nativa y poster desde [home-sale-video](./snipplets/home/home-sale-video.tpl). | Marco de video ya tiene proporción; cards necesitan ancho inicial igual al carrusel activado. | Scroll-snap o Swiper compartido; reproducción explícita por defecto. Autoplay es opción con costo, no compatible con promesa de overhead despreciable en todos los dispositivos. |
| `home.category-banners` | Banners/enlaces desde [home-category-banners-fluid](./snipplets/home/home-category-banners-fluid.tpl). URL real de todas las imágenes visibles inicialmente, no solo del primer elemento. | Proporciones desktop/móvil y anchos de slides calculados por CSS desde el principio. | Navegar carrusel, opcional. Corregir lazy actual dependiente de JS; para imágenes fuera del viewport usar carga nativa diferida cuando sea compatible con el tema. |
| `navigation.enhancements` | Decorar navegación nativa en [navigation-nav-list](./snipplets/navigation/navigation-nav-list.tpl); configuración por destino, sin inferir promociones por palabras como «9 cuotas». | Separadores, énfasis y tamaños del menú desde el inicio. No depender de medir y redistribuir enlaces después del paint. | Apertura/cierre y teclado. Conservar menú del destino; probar textos largos, traducciones y resize. |
| `catalog.product-cards` | Precio, descuento nativo, nombre y CTA desde [item](./snipplets/grid/item.tpl). | Grid y espacios de precio/cuotas consistentes, proporción de imagen y CTA estable. | Compra rápida/selección nativas. Eliminar normalización inicial tardía de etiquetas de efectivo; resolver texto durante render o conservar etiqueta nativa. |
| `catalog.installments` | [product-installments-summary](./snipplets/product/product-installments-summary.tpl) usa datos nativos del producto y campaña confirmada; primer resultado ya renderizado. | Región de cuotas estable para variaciones razonables de longitud, sin recortar información. | Actualización únicamente al cambiar variante con datos nativos. Un cálculo visual de cuotas no crea financiación; no congelar importes en el artefacto publicado. |
| `catalog.stock-variants` | Orden inicial de opciones debe salir del Twig con disponibilidad nativa para la combinación seleccionada; fuente actual [product-variants](./snipplets/product/product-variants.tpl). | Geometría y estado agotado inicial. | Tras interacción actualizar disponibilidad conservando foco y selección. Si el contexto Twig no permite resolver la disponibilidad exacta, publicar orden estable original y declarar limitada esta función; no «arreglarlo» reordenando visible al arrancar. |
| `product.description-layout` | Estructura desde [product](./templates/product.tpl) y [product-description](./snipplets/product/product-description.tpl), sin mover DOM. | Columnas/anchura inicial; estilos solo en ficha o ubicación de producto que los requiera. | Compartir/abrir contenido opcional. Comentarios sociales externos son excepción al contrato: opt-in, espacio reservado o apertura explícita. |
| `product.rich-description` | HTML existente del producto preservado. Plantillas enriquecidas nuevas son opt-in; [single-product.scss](./static/css/single-product.scss) como origen de estilos. | CSS por ficha/contenido relevante; imágenes/tablas con geometría y overflow previstos. | Acordeones nativos `details`; no convertir o envolver descripciones existentes al cargar. No garantizar estabilidad de HTML arbitrario con medios sin dimensiones hasta corregir ese contenido. |
| `promotions.campaigns` | Configuración publicada localmente y evaluación de estado/criterios en servidor; origen [payment-installments-config](./snipplets/payment-installments-config.tpl) y [eligibility](./snipplets/payment-promo-product-eligibility.tpl). | Sin interfaz propia. | No necesita SDK por visita. Calcular estado una vez por respuesta y elegibilidad una vez por producto. Verificar caché de HTML/plantillas antes de prometer transición exacta a una hora. |
| `promotions.countdown` | Barra visible desde Twig con mensaje correcto y fecha límite; origen [header-advertising](./snipplets/header/header-advertising.tpl). Si la caché impide segundos correctos, mostrar fecha/hora real desde el inicio y definir explícitamente ese fallback, nunca `00` ni bloque vacío. | Altura y ancho de dígitos reservados; igual geometría en estado programado, activo y finalizado. | Tick pequeño sin dependencia de `LS.ready`; cambia texto, no inserta la barra. En vencimiento reemplaza contenido dentro del mismo espacio hasta navegación, no colapsa el header. |
| `promotions.badges` | Etiquetas ya resueltas en [promo-3d-printer-badge](./snipplets/promo-3d-printer-badge.tpl), generalizado por reglas compartidas. | Tamaño y posicionamiento inicial, sin depender de una clase que JS añade después. | 0 JS inicial. Si el estado cambia durante sesión, mismo espacio reservado o actualización en navegación; evitar comunicar promoción vencida. |
| `promotions.landing` | Categoría nativa elegida, filtros, productos y paginación desde [landing](./snipplets/brand-promo/landing.tpl). | [brand-promo.scss](./static/css/brand-promo.scss) solo en la ruta publicada, antes del paint; hero y cards dimensionados. | Filtros/formularios nativos como base; JS de mejora opcional. No reconstruir catálogo por API desde cliente; preservar total de productos, filtros y paginación del destino. |
| `promotions.status-pages` | Body, title, description y robots coherentes desde [page-context](./snipplets/custom-pages/page-context.tpl) y plantillas de estado. | CSS de la página inicial. | No requiere JS para decidir qué mostrar. Validar caché al programar estado; no reactivar formularios históricos ni redirigir tarde con JS. |
| `pages.shipping` | Contenido propio y mapa estático desde [custom-shipping-page](./snipplets/custom-shipping-page.tpl). | CSS inicial de página y dimensiones del mapa (ya hay width/height en línea 60). | `details` y CTA funcionan sin JS; mapa interactivo, si se incorpora, por acción y en marco fijo. No pedir cobertura al backend de nuestra app para renderizar la página. |
| `pages.payment` | Medios y condiciones confirmados desde [custom-payment-page](./snipplets/custom-payment-page.tpl). | Logos/proporciones y CSS de página inicial. | Puede ser 0 JS salvo medición. Información no equivale a configurar pagos reales. |
| `pages.warranty` | Políticas reales desde [custom-warranty-page](./snipplets/custom-warranty-page.tpl), no reglas por componentes 3D. | CSS de página inicial. | `details`/links nativos; chat opcional con fallback. Puede funcionar con JS propio bloqueado. |
| `pages.contact` | Datos, horarios y enlaces reales desde [custom-contact-hours-page](./snipplets/custom-contact-hours-page.tpl); preservar contacto/formulario nativo. | CSS inicial; iconos SVG locales; mapa, si existe, con marco fijo. | Chat/contexto y medición secundarios. Teléfono/email/WhatsApp siguen siendo links si falla el proveedor. |
| `pages.about` | Texto, equipo, imágenes y posters desde [custom-about-page](./snipplets/custom-about-page.tpl); opiniones nativas opcionales. | CSS inicial y dimensiones reales; corregir dependencia del CSS async de opiniones reutilizadas. | Reproducción por acción. Ya hay medios diferidos y poster; mantener visibilidad del contenido aunque falle video o JS. |
| `commerce.preorders` | Selección de productos y condiciones desde [custom-preventas-page](./snipplets/custom-preventas-page.tpl), precios/stock nativos. | CSS inicial, hero y tarjetas dimensionados; opiniones con contrato compartido. | Consulta contextual con link fallback. No ofrece cobro parcial automático ni nuevas reglas de checkout. |
| `integrations.chat` | Botón/enlace de contacto propio en HTML; origen [whatsapp-chat](./snipplets/whatsapp-chat.tpl) y [custom-pages.js](./static/js/custom-pages.js.tpl), línea 86. | Botón con tamaño estable; panel superpuesto fuera del flujo. | Cargar proveedor al abrir y preservar fallback. El contenido remoto del chat no puede garantizarse inmediato ni sin costo; launcher sí. Carga anticipada opcional presupuestada. |
| `integrations.analytics` | Atributos de evento en HTML, sin interfaz y sin bloquear contenido. | 0 CSS. | Listener delegado pequeño y cola no bloqueante; proveedor externo independiente. No esperar analítica para renderizar ni duplicar ecommerce nativo. No garantizar costo cero del tercero. |
| `checkout.appearance` | No pertenece al render Twig del storefront. [checkout.scss.tpl](./static/checkout.scss.tpl) necesita contrato separado de compatibilidad y controles soportados. | Solo estilos oficialmente soportados/verificados para ese checkout. | Bloqueado por defecto. No trasladar overlays por selectores de implementación. NubeSDK/slots de checkout, si se eligen, se validan aparte y no se presentan como HTML inicial del tema. |

## Obstáculos concretos en el código actual

### 1. Cuenta regresiva oculta hasta JS

[header-advertising](./snipplets/header/header-advertising.tpl), línea 35, entrega el enlace con `hidden`; líneas 41, 45, 50 y 55 entregan `00`. [store.js](./static/js/store.js.tpl), línea 622, recién lo muestra; líneas 570 y 591 lo ocultan por error/expiración. La inicialización ocurre dentro de `LS.ready.then` en [layout](./layouts/layout.tpl), línea 199.

Esto contradice directamente «sin aparición tardía». El CSS crítico ya existe, pero no reemplaza la necesidad de estado inicial visible. Además el cambio de mensaje/clase activa puede alterar geometría. Se debe resolver en servidor, mantener cifras tabulares y reservar altura para el mensaje más largo permitido. Al expirar durante la visita, conservar altura y reemplazar por comunicación neutral. No afirmar que una cuenta exacta al segundo en HTML cacheado será siempre correcta.

No se encontró en el código propio inspeccionado una escritura explícita de `padding-top` del body para compensar el header; sí hay mediciones de header y cálculos de menú/sticky en [store.js](./static/js/store.js.tpl), líneas 690, 719, 848 y 3262. El posible ajuste de compensación por JS privado de plataforma debe verificarse en la tienda real. No se declara un bug concreto de padding sin esa evidencia.

### 2. Geometría de módulos en CSS asíncrono

[layout](./layouts/layout.tpl), línea 81, carga `style-async.scss` con `media="print"` y lo activa en `onload`. En [style-async](./static/css/style-async.scss), líneas 1124, 1550 y 1658, empiezan los estilos de reseñas, beneficios y propuesta de valor. Unos estilos de iconos en el CSS crítico no cubren su layout.

Extraer geometría al bundle inicial de las rutas/ubicaciones que usan cada módulo. No convertir todo el stylesheet histórico en bloqueante global: eso evita parte del salto trasladando el costo a FCP. Lo necesario es selección por ruta y módulo, con presupuesto de CSS.

### 3. Inicialización de carruseles y ocultación de controles

[external-no-dependencies](./static/js/external-no-dependencies.js.tpl), línea 17, difiere cada `new Swiper` a otra tarea. [store.js](./static/js/store.js.tpl), líneas 994 y 1388, configura slides/breakpoints de reseñas y ofertas; líneas 1018 y 1406 eliminan/ocultan controles. En ofertas se fijan cantidades 2.05/2.5/2/4 según breakpoint, líneas 1409–1418.

No se midió que cada carrusel salte. El riesgo se valida comparando rectángulos antes/después con CSS/JS retrasados. Recomendación: scroll-snap para módulos nuevos sencillos; si requiere Swiper, CSS inicial reproduce exactamente breakpoints, gaps y proporciones y no aparece paginación sin espacio previsto. Reutilizar una sola biblioteca presente, nunca cargar una copia por módulo.

### 4. Cambios de contenido y orden visibles al iniciar

[store.js](./static/js/store.js.tpl), línea 2493, reordena botones de colores mediante `appendChild`; [product-variants](./snipplets/product/product-variants.tpl), línea 38, los emite en orden original. El orden inicial debe resolverse por disponibilidad nativa de la combinación seleccionada. Si no es viable con los datos disponibles, mantener orden estable y limitar explícitamente el módulo.

[store.js](./static/js/store.js.tpl), líneas 2244–2279, reescribe nodos de texto de precio en efectivo al arrancar; se repite para cards cargadas y variantes. Resolver el copy en el render cuando exista una vía nativa soportada. Si el componente nativo no permite personalizarlo, conservar su texto, evitando una sustitución visual inicial.

### 5. Medios grandes y descubrimiento tardío de imágenes

[home-sale-video](./snipplets/home/home-sale-video.tpl), línea 19, pide metadata; el poster es opcional, línea 22. El autoplay al entrar en viewport está en [store.js](./static/js/store.js.tpl), línea 1445. Los marcos ya tienen proporciones en [style-critical](./static/css/style-critical.scss), líneas 2117 y 2558: esto protege geometría, no ancho de banda/CPU.

[home-category-banners-fluid](./snipplets/home/home-category-banners-fluid.tpl), línea 46, limita la carga directa a ciertos primeros banners. Otros usan `data-srcset`/lazyload; si varias columnas son visibles, parte del contenido puede aparecer después de JS aunque no salte. El render inicial debe descubrir todas las imágenes visibles; limitar `fetchpriority="high"` al candidato LCP real.

Existen videos fuente de 17.45 MB, 15.93 MB y 2.36 MB en el repositorio; no significa que se transfieran enteros en cada visita. Evitar autoplay por defecto, exigir poster optimizado y transcodificar al publicar cuando se acepte video nuevo. Mantener duración/resolución adecuadas; no cargar videos ajenos al módulo/ruta. Las imágenes con dimensiones aún requieren descarga: no se promete instantaneidad de medios en conexiones arbitrarias.

### 6. Elegibilidad repetida por producto

[item](./snipplets/grid/item.tpl), línea 95, incluye badge; línea 219, resumen de cuotas. [promo-3d-printer-badge](./snipplets/promo-3d-printer-badge.tpl), líneas 1–3, vuelve a cargar estado, cuotas y elegibilidad. [product-installments-summary](./snipplets/product/product-installments-summary.tpl), líneas 3–6, hace lo mismo. [landing](./snipplets/brand-promo/landing.tpl), líneas 7 y 15, recorre selecciones y vuelve a clasificar marcas.

Esto es trabajo del servidor y crecimiento de HTML, no solo costo JS. Normalizar contexto de campaña una vez por respuesta y pasar resultado de elegibilidad una vez por producto a badge/cuotas. Limitar cantidad de destacados, evitar escanear el catálogo entero o publicar listas gigantes de IDs por cada card. Mantener el precio y stock en variables nativas. No declarar ganancia de TTFB antes de medir.

### 7. Checkout y terceros requieren excepción explícita

[checkout.scss.tpl](./static/checkout.scss.tpl), línea 1523, inicia un overlay sobre el iframe de pago; líneas 1530 y 1545 usan posicionamiento absoluto y selectores concretos. No es un mecanismo estable para un módulo portable ni prueba de datos financieros correctos. Mantenerlo fuera del perfil de compatibilidad garantizada hasta validación oficial y prueba real del checkout.

[product-description](./snipplets/product/product-description.tpl), líneas 20 y 23, incluye comentarios de Facebook y un contenedor vacío de reviews externo. El contenido del tercero no puede cumplir el contrato de HTML inicial por el solo hecho de reservar espacio. Ofrecer carga explícita, contenido nativo equivalente cuando sea legítimo, o declararlo fuera del requisito estricto. Igual criterio para chat remoto.

## Medidas disponibles y límites

| Archivo fuente local | Bytes en disco |
|---|---:|
| [store.js.tpl](./static/js/store.js.tpl) | 176748 |
| [external-no-dependencies.js.tpl](./static/js/external-no-dependencies.js.tpl) | 95842 |
| [style-critical.scss](./static/css/style-critical.scss) | 129989 |
| [style-async.scss](./static/css/style-async.scss) | 61709 |

Son fuentes con Twig/SCSS/comentarios; **no son bytes transferidos, JS ejecutado, CSS compilado ni prueba de impacto de la app**. El layout incluye JS inline y ramas condicionadas. Medir respuesta real, compresión, caché, parse/evaluate, estilos usados, TTFB y costo incremental frente al destino sin módulos.

## Pruebas de aceptación por módulo

1. HTML de respuesta contiene texto, estructura, estado y URLs de medios requeridos; bloqueo del backend de la app no afecta a la tienda publicada.
2. Bloquear JS propio: layout y contenido esenciales permanecen visibles; links/formularios nativos siguen funcionando según capacidades del tema. No exigir que funciones nativas de Tiendanube basadas en JS funcionen si se bloquea todo JS.
3. Retrasar JS propio y CSS secundario 5–10 s: ningún módulo inicial aparece recién al terminar esa demora; filmstrip y comparación de geometría lo verifican.
4. Primera visita sin caché y caché caliente, móvil/desktop, red lenta y CPU limitada; scroll temprano antes de terminar la carga; textos largos, zoom y fuentes retrasadas. Medir CLS atribuido y también aparición visual tardía.
5. Probar campaña antes/durante/después, cruce de vencimiento con página abierta, reloj cliente incorrecto y caché potencialmente vieja; no colapsar la barra ni dejar comunicar financiación vencida sin control.
6. Variantes múltiples, agotados, productos sin precio/cuotas, quickshop, paginación/búsqueda y productos agregados después de publicar; no congelar catálogo.
7. Reinstalación, actualización, desactivación y fallo de la app: contenido nativo conservado y tienda funcional. Un módulo solo pasa a «compatible» con evidencia de su versión/ubicación.

El objetivo verificable es cero saltos atribuibles al módulo durante las pruebas definidas y ausencia de render inicial dependiente de JS. No es garantía universal de CLS total cero, cero bytes o disponibilidad instantánea de cualquier proveedor. Deben medirse por separado regresiones y cambios ya existentes en el tema, las fuentes, el contenido comercial y los servicios de Tiendanube.
