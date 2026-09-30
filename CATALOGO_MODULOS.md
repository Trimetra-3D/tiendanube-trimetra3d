# Catálogo propuesto de módulos

Estado: planificación de una app por NubeSDK con estructura de gestión inspirada en Wigy y pequeñas integraciones manuales de CSS/HTML. Los componentes provienen del tema origen; todavía no se adaptaron como módulos instalables. Todos serán opcionales. Véanse el [plan](./PLAN_PORTABILIDAD.md), las [reglas obligatorias](./REGLAS_APP.md) y el [inventario](./INVENTARIO_PORTABILIDAD.md).

La [auditoría de render](./INVESTIGACION_RENDER_MODULOS.md) cubre los **26 IDs** y sus obstáculos de origen; sus propuestas de publicación nativa pertenecen a la arquitectura anterior. Ahora cada módulo debe clasificarse A/B/C según las [reglas](./REGLAS_APP.md) y comprobarse en SDK/ubicación real. Distinguir «por adaptar», «necesita integración pequeña», «requiere integración mayor» y «compatible comprobado»; no ofrecer activación funcional sin evidencia.

## Qué debería verse en el gestor

El gestor es el panel de la app abierto desde el administrador de la tienda donde está instalada. Presenta exclusivamente módulos y configuraciones de esa instalación, sin listado ni selector de otras tiendas.

Cada ficha del panel web mostrará nombre, descripción, ejemplo visual, dónde aparece, configuración, versión, requisitos y dependencias. El catálogo mostrará también mejoras sin un bloque visual propio. Filtrar por Inicio, Catálogo, Promociones, Páginas e Integraciones; distinguir disponible, instalado, configurado, publicado y visible. No habrá un asistente local intermedio.

Ejemplo conceptual de ficha, no estado real de la tienda:

> **Cuenta regresiva de campaña** — Promociones / encabezado
>
> Comunica cuándo comienza o termina una campaña.
>
> Configuración: fechas, horario, mensaje y destino del enlace.
>
> Requiere: una campaña válida. No habilita financiación en checkout.
>
> Acciones propuestas: Ver ejemplo · Configurar · Habilitar · Ver cambios.

## Funcionalidades reutilizables

Los identificadores siguientes son propuestos. Agrupan funciones para el usuario; la extracción definirá qué componentes compartidos necesita cada una.

| ID propuesto | Nombre visible | Dónde aparece / qué aporta | Adaptación necesaria |
|---|---|---|---|
| `home.reviews` | Opiniones de clientes | Home u otras páginas; tarjetas, puntuaciones, fuente y carrusel/grilla | Datos e imágenes reales de la nueva marca; carga manual |
| `home.benefits` | Barra de beneficios | Home u otra ubicación elegida; beneficios y enlaces | Textos, iconos, URLs y condiciones propios |
| `home.value-proposition` | Por qué elegirnos | Bloque de diferenciales de marca | Quitar TrimetraHub y copy del origen |
| `home.product-video` | Producto con video | Producto comprable junto a un video | Producto seleccionado, video y poster |
| `home.offers-video` | Ofertas con video | Carrusel de ofertas junto a video | Selección de productos y recursos propios |
| `home.category-banners` | Banners de categorías | Grilla/carrusel adaptable a móvil | Banners, categorías y enlaces propios |
| `navigation.enhancements` | Navegación mejorada | Jerarquía, separaciones y tratamientos visuales del menú | Conservar menú actual; generalizar detecciones por nombres/URLs |
| `catalog.product-cards` | Tarjetas de producto mejoradas | Jerarquía de precios, botones y alineación | Respetar datos de precio y colores del destino |
| `catalog.installments` | Resumen de cuotas | Cards y ficha; actualización al cambiar variante | Datos nativos de pago y campaña configurada si corresponde |
| `catalog.stock-variants` | Variantes disponibles primero | Orden/prioridad de colores con stock | Mantener selección y comportamiento nativo de variantes |
| `product.description-layout` | Descripción amplia | Ficha con mayor espacio para descripción; bloque social configurable | Preservar contenido del catálogo y comportamiento elegido |
| `product.rich-description` | Descripciones enriquecidas | Estilos para bloques de características, especificaciones y contenido | Plantillas de contenido genéricas; no convertir descripciones existentes sin elección |
| `promotions.campaigns` | Configuración de campañas | Fechas, zona horaria, comunicación y productos elegibles compartidos | Reemplazar reglas de impresión 3D por criterios genéricos configurables |
| `promotions.countdown` | Cuenta regresiva | Barra superior antes/durante la campaña | Depende de configuración de campaña; finalización controlada |
| `promotions.badges` | Etiquetas promocionales | Tarjetas y galería de producto | Elegibilidad compartida; textos y condiciones propios |
| `promotions.landing` | Página de campaña con catálogo | Hero, destacados, filtros, orden y paginación | Generalizar la landing de Bambu Lab/Snapmaker; preservar categoría del destino |
| `promotions.status-pages` | Estado de campañas | Página programada, vigente o finalizada y metadatos correspondientes | No equivale a reconstruir formularios o campañas históricas completas |
| `pages.shipping` | Página de envíos | Página informativa de logística | Cobertura, mapa y condiciones del negocio |
| `pages.payment` | Página de medios de pago | Explicación visual de alternativas de pago | Solo información confirmada del destino |
| `pages.warranty` | Página de garantías y devoluciones | Condiciones y consulta | Sustituir completamente la política de componentes 3D |
| `pages.contact` | Contacto y horarios | Canales, horarios y ubicación | Datos de destino; preservar contacto nativo |
| `pages.about` | Quiénes somos | Presentación, equipo, imágenes/videos y opiniones opcionales | Contenido real de la nueva marca |
| `commerce.preorders` | Preventas | Productos, condiciones y consulta de reserva | Generalizar selección/fechas; no implementa cobro automático de seña |
| `integrations.chat` | Chat de atención | Widget y consultas contextuales con fallback | Cuenta/inbox propios; capacidad opcional de contexto |
| `integrations.analytics` | Medición de interacciones | Eventos de CTA, FAQ, contacto y campañas | Configurar herramientas de destino; no duplicar ecommerce nativo |
| `checkout.appearance` | Apariencia del checkout | Ajustes visuales y comunicación de pago | Compatibilidad y necesidad por verificar; apagado por defecto |

La biblioteca incluye todos estos candidatos; instalar el paquete no los activa ni los inserta en la home. Sus dependencias se resolverán sin activar ubicaciones no elegidas. La cuenta regresiva y los badges pueden compartir un motor de campañas sin obligar a mostrar ambos.

## Material que no equivale a un módulo listo

- Formulario Brevo histórico: conservar como referencia. Requiere revisar su reutilización y configurar formulario/dominio propios antes de ofrecer captación funcional.
- Videos, logos bancarios, imágenes y campañas de Trimetra: recursos del perfil origen; no contenido por defecto para otra marca.
- Scripts vacíos o placeholders: no son funcionalidades adicionales.
- Reglas por marca/modelo 3D, cobertura por componentes y enlaces de Trimetra: no se trasladan como reglas genéricas.

## Cómo sumar módulos después

1. Registrar la nueva mejora con nombre, propósito y zona de la tienda; no importa si afecta home, listado, búsqueda, ficha, carrito o footer.
2. Separar su código, configuración, contenido y puntos de integración. Declarar dependencias y compatibilidad con tema o extensión de app.
3. Añadir ficha, ejemplo visual, versión y notas de actualización. El registro alimentará el catálogo del gestor y los controles disponibles en el editor.
4. Preparar instalación, desactivación y actualización sin perder cambios del destino. Probar la funcionalidad y las regresiones que pueda causar.

## Contrato de carga de cada módulo

- Clasificar su vía: UI/eventos oficiales de NubeSDK o personalización nativa del tema. Los slots personalizados están documentados por Tiendanube, pero su contenido se monta mediante el SDK; no implican SSR.
- No copiar JS dependiente del DOM/jQuery al Worker de NubeSDK. La app entrega widgets por SDK y genera únicamente la integración manual pequeña admitida; no publica archivos de tema automáticamente.
- Registrar contenido inicial, reserva geométrica, fallback y tiempo de aparición. El contenido crítico nativo se conserva mientras el widget descarga código/configuración.
- Agrupar configuración por contexto, cargarla en paralelo con código, usar caché versionada/vigente y no ocultar que el widget depende de procesamiento posterior.
- Declarar dimensiones/proporciones y fallback de contenido asíncrono. Comprobar que carga, fallo y expiración no desplacen la página.
- Mantener precio, stock y condiciones finales conectados a datos nativos; no congelarlos en artefactos de publicación.
- Documentar prueba de primer render, rendimiento y reversión junto con la ficha. Una mejora no está lista solo porque funcione tras terminar de cargar todo.
- Aplicar los presupuestos y condiciones de publicación del [plan](./PLAN_PORTABILIDAD.md). Chat completo, medición externa y checkout declaran sus límites; mantener el contenido visual propio independiente de sus proveedores.

Este documento es el catálogo inicial de planificación. Al implementar, su contenido deberá derivarse del registro de módulos para no convertirse en otra lista desactualizada.
