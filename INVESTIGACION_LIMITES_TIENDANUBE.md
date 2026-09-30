# Límites de plataforma para la app modular

Investigación documental: 28/09/2026. Fuentes primarias. No se modificó ni publicó código de tienda. Complementa el [plan](./PLAN_PORTABILIDAD.md) y el [catálogo](./CATALOGO_MODULOS.md). «Confirmado» significa documentado, no comprobado en una tienda de destino.

## Resultado

**NubeSDK no ofrece una garantía documentada de HTML inicial ni de render antes del primer paint.** La solución compatible con el requisito visual es preparar el diseño en el tema y servirlo con la página. Eso es una conclusión arquitectónica; no demuestra por sí mismo que Tiendanube admita nuestra app como publicador automatizado de temas.

**Hay una condición de plataforma pendiente, además de la prueba técnica:** confirmar la clasificación de una app privada que administra y publica personalizaciones de tema. No podemos considerar que subir scripts a `static` los exime de la política de NubeSDK.

## Lo que está confirmado

| Tema | Evidencia primaria | Implicación |
|---|---|---|
| Ejecución de NubeSDK | Corre en Web Workers del navegador; UI declarativa en slots, sin acceso directo al DOM. [Visión general](https://tiendanube.dev/es-AR/apps/nube-sdk/overview) | Aislamiento y eventos no equivalen a SSR. No usar SDK como requisito para que aparezca contenido crítico. |
| Slots FTP | La plataforma inyecta el loader por `head_content`; los slots son contenedores vacíos que monta el SDK. Copias FTP anteriores al 11/05/2026 pueden carecer de ellos. [Guía FTP](https://tiendanube.dev/es-AR/apps/nube-sdk/ftp-themes) | Tener el contenedor en Twig no significa que el contenido de la app venga en el HTML. Inspeccionar ambas cosas por separado. |
| Slots personalizados | Se declaran en plantillas modificables y la app llama `nube.render()`. [Custom slots](https://tiendanube.dev/es-AR/apps/nube-sdk/slots/custom-slots) | Sirven para ubicación; no resuelven la demora inicial del contenido. |
| Scripts clásicos | Carga por primera interacción por defecto; `onload` requiere autorización para storefront. [Scripts API](https://tiendanube.github.io/api-documentation/resources/script) | Ni el trigger aprobado garantiza ejecución anterior al primer paint. No es la base futura para los módulos. |
| JavaScript de tema | Documentado como recurso estático del diseño; existen hooks funcionales de plantilla. [Carga JS](https://docs.tiendanube.com/help/como-cargo-javascript), [hooks](https://docs.tiendanube.com/help/hooks-de-javascript) | Conservar comportamiento nativo de variantes y carrito. Esta documentación no declara una excepción para scripts de apps. |

La [guía de migración](https://tiendanube.dev/es-AR/apps/nube-sdk/migration-guide) confirma que no hay acceso a `document`, `window`, jQuery o renderizadores DOM tradicionales desde el Worker. Por eso no se puede pegar allí el JS actual de widgets y esperar equivalencia. También documenta eventos de carrito, envío, pago y órdenes; la integración debe usar sus contratos, no selectores improvisados.

## Política vigente y app privada

La [documentación de apps](https://tiendanube.dev/es-AR/apps/admin/overview) distingue distribución pública y «Para Tus Clientes», esta última sin homologación y restringida a comerciantes seleccionados. También indica:

- NubeSDK obligatorio en homologación desde el 05/06/2026.
- Bloqueo de nuevas instalaciones sin SDK desde el 30/08/2026.
- Inicio de deprecación y desinstalación progresiva de apps legadas desde el 30/10/2026.
- Apps privadas que inyectan scripts también están alcanzadas; no quedan exentas por ser privadas.

La [guía de homologación](https://tiendanube.dev/apps/publish/homologation/overview) confirma el alcance a privadas con scripts. La clasificación exacta de una app de administración/publicación de temas no está resuelta por estas páginas. Instalar un SDK sin función real para «cumplir» tampoco demuestra cumplimiento.

**Decisión propuesta:** app privada de gestión desde el comienzo; publicar HTML/CSS del tema como personalización de diseño, sujeto a validar el canal y la clasificación. Utilizar SDK para capacidades que correspondan al modelo oficial de apps. No trasladar scripts de app a archivos del tema para evitar restricciones.

## Checkout: separar apariencia de funciones

La ruta documentada para estilos es `static/checkout.scss.tpl`, con acceso a colores y tipografías de la plantilla. [CSS en checkout](https://docs.tiendanube.com/help/cmo-aplicar-css-en-el-checkout).

El esquema actualizado agrega variables CSS para los componentes; su aplicación requiere habilitar «Usar los colores de tu diseño en el checkout» en el administrador. [Variables de checkout](https://docs.tiendanube.com/help/actualizar-las-variables-css-en-el-checkout).

**Contrato propuesto para `checkout.appearance`:** colores, tipografía y ajustes CSS compatibles; activación opcional, validada por tienda. No incluye reestructurar HTML de checkout, inventar financiación, mover formularios ni mostrar nueva información crítica mediante scripts tardíos. UI adicional mediante SDK debe declarar su carácter asíncrono. No encontramos garantía documental de primer paint para esa UI.

## Datos, permisos y automatización

La [autenticación oficial](https://tiendanube.github.io/api-documentation/authentication) usa OAuth, intercambio de código por token y `state` contra CSRF. `read_products` cubre catálogo; `write_content` permite páginas. Pedir solo permisos usados y guardar tokens exclusivamente en backend. Las credenciales FTP son una conexión diferente: OAuth no las concede automáticamente.

| Recurso | Alcance comprobado | Plan propuesto |
|---|---|---|
| Páginas | CRUD y HTML localizado con `read_content`/`write_content`. [Pages](https://tiendanube.github.io/api-documentation/resources/page) | Preparar contenido en la app y publicarlo por API; guardar IDs y versión anterior. No recrear páginas existentes por slug sin elección. |
| Productos | API de consulta y edición. [Products](https://tiendanube.github.io/api-documentation/resources/product) | Elegir IDs reales del destino en el panel; nunca reutilizar IDs de Trimetra ni escribir catálogo para instalar un widget. |
| Precio/stock visibles | Twig dispone de precio, stock y variantes nativos. [Product de tema](https://docs.tiendanube.com/help/product) | Resolverlos con datos de la tienda al renderizar y sus mecanismos nativos de actualización; nunca congelarlos en un build. |
| Menús | Twig dispone de `menus` y `navigation`. [Layout](https://docs.tiendanube.com/help/layouts) | Respetar navegación actual. No se encontró API pública documentada para escribir menús; altas de enlaces requieren flujo del administrador hasta verificar otra vía. |
| Tema activo | `GET /store` informa `current_theme`. [Store](https://tiendanube.github.io/api-documentation/resources/store) | Identificación orientativa; no ofrece por sí mismo archivos, versión completa ni actualización de settings. |

**Inconsistencia Pages a resolver en staging:** el resumen dice que las páginas siempre están publicadas, mientras el cuerpo de creación admite `publish`. No depender de borradores ocultos hasta verificarlo. El borrador puede vivir en la app; crear página solo al publicar. No asumir transacción atómica entre Pages API y FTP.

En los recursos públicos consultados no encontramos API de escritura de archivos de tema, settings o menús. Esto limita lo que podemos prometer usando únicamente OAuth; no prueba que no exista algún acceso adicional habilitable por Tiendanube.

### Resolver selecciones de productos en el render nativo

**Existe evidencia oficial del filtro Twig `get_products`.** El tutorial de [productos relacionados](https://docs.tiendanube.com/help/productos-relacionados) transforma IDs de un metafield en objetos de producto y los renderiza con la tarjeta del tema. El tutorial de [alternativos y complementarios](https://docs.tiendanube.com/help/productos-alternativos-y-complementarios) también usa ese filtro.

Propuesta concreta para home con video, ofertas y preventas: elegir productos vía API en el panel, publicar solamente sus IDs en configuración Twig y resolverlos mediante `get_products` durante el render. Así no se congelan precios/stock ni se necesita un fetch del navegador. **Aún hay que probar** tipos de entrada, orden, límites, productos ocultos/borrados y disponibilidad del filtro en home/página/categoría: las fuentes muestran el contexto de relacionados, no un contrato universal de esos casos. Resolver una vez por colección, no una consulta por tarjeta; medir impacto en TTFB.

La alternativa documentada son las colecciones nativas `sections`, de hasta 40 productos, que se organizan desde el administrador y exponen `sections.<clave>.products`. [Sections](https://docs.tiendanube.com/help/sections). No se encontró API para modificar su selección: si se utiliza esta vía, el panel debe explicar el paso real de configuración en Tiendanube. No fingir que crear la definición de colección también la llena.

Para una landing con filtros, orden y paginación de catálogo, preferir la ruta de categoría y sus objetos nativos. Un conjunto de IDs resuelto por `get_products` no demuestra soporte de paginación/filtros del controlador de catálogo. Para colecciones pequeñas se puede renderizar el conjunto completo; para catálogo grande, conservar el flujo nativo o mantener el módulo pendiente de validación. No filtrar después de paginar si eso deja páginas vacías o totales incorrectos.

## Publicación de tema y riesgo concreto

El [CLI oficial FTP](https://tiendanube.dev/themes/developer-tools/cli/ftp-theme-development) documenta pull/push/watch y sincronización incremental. También dice que push elimina archivos remotos ausentes en la copia local.

**Consecuencia:** nunca ejecutar un push completo desde una carpeta que solo contenga módulos. El publicador necesitará copia íntegra reciente + control de conflictos, o un mecanismo validado de escrituras por lista explícita que preserve el resto. La presencia del CLI no acredita atomicidad, rollback transaccional, propagación instantánea ni autorización de automatización dentro de nuestra app. Medir/confirmar esas capacidades por separado.

## Contrato honesto de rendimiento

Estos son requisitos de diseño propuestos, no promesas de la plataforma:

- HTML y CSS de la presentación crítica disponibles con el documento inicial. Ninguna consulta a nuestro backend en el recorrido de compra para decidir el diseño.
- Publicar configuraciones relativamente estables: textos, fechas, selección de productos, recursos y reglas. No snapshots de precio, stock, carrito o condiciones finales de pago.
- Contador: mensaje y caja visibles desde el inicio; actualización numérica sin cambiar geometría. La fecha y el estado deben seguir siendo correctos ante caché, expiración o fallo de JS.
- Video: poster estable y dimensiones iniciales; reproducción/interacción no equivale a descargar todo antes del primer paint.
- Chat: enlace o botón nativo inmediato; conversación remota necesita conexión/carga. Si exigimos conversación completa instantánea y cero carga extra, no podemos garantizar ambos requisitos.
- Analytics: la emisión de eventos tiene trabajo y tráfico. Debe estar fuera de la dependencia visual y sin duplicación de tracking; no describirlo como costo cero.
- Nuevos módulos deberán declarar render inicial, actualización, dependencias, permisos, bytes y pruebas. Los 26 pueden permanecer en catálogo, aunque alguno no sea activable hasta cumplir su contrato.

## Confirmaciones necesarias antes de habilitar publicación

1. ¿Admite Tiendanube una app «Para Tus Clientes» que gestione/publíque Twig, CSS y configuración del tema con acceso separado, sin renderizar esa UI mediante SDK? ¿Qué JS de interacción se clasifica como tema y cuál como script de app?
2. ¿Qué canal oficial permite automatizar publicación y autenticación en este escenario? ¿Existen límites de frecuencia, edición o desinstalación del publicador?
3. ¿Hay garantía o mecanismo de activación atómica y propagación de archivos/configuración? Si no, probar despliegue por versiones, compatibilidad entre versiones y rollback sin asumir transacciones.
4. ¿Existe vía pública admitida para settings/menús y borradores de páginas? Hasta entonces, exponer esos pasos en el estado de instalación.

No se contactó a terceros. Las preguntas precisan los vacíos encontrados; las pruebas de rendimiento y reversión también son obligatorias para convertir la propuesta en una implementación validada.
