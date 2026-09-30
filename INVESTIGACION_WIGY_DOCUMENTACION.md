# Wigy: documentación pública y alcance real

Investigación: 2026-09-28. Fuentes primarias: sitio, centro de ayuda y ficha oficial Tiendanube. Sin instalar, crear cuenta, contratar ni contactar a terceros. Esta nota documenta el producto y sus instrucciones; la inspección de scripts/HTML de la demo es evidencia complementaria independiente.

## Conclusión

La [inspección técnica de las demos](./INVESTIGACION_WIGY_TECNICA.md) complementa esta revisión: se identificó NubeSDK, consulta pública por tienda/producto y contenido ausente del HTML inicial. No se midieron tiempos visuales ni CLS.

Wigy demuestra que un panel central con módulos opcionales, configuración y reglas por tienda/producto es un producto viable. Su existencia **no prueba** render en HTML inicial, CLS cero, ausencia de overhead ni que soporte cualquier modificación del tema. La propia documentación exige intervenciones manuales en el tema para ciertos reemplazos y reconoce incompatibilidades. No identificar su tecnología como NubeSDK, FTP, SSR o inyección tradicional solo por el aspecto del panel.

## Producto y administración

- Nombre oficial: **Wigy**; ficha publicada por **Sipems**, acceso mediante aplicación externa. Ofrece creación visual de módulos desde su dashboard y personalización de textos, colores y estilos. La publicación en el marketplace acredita la existencia de la integración, no sus características de rendimiento. [Ficha Tiendanube](https://www.tiendanube.com/tienda-aplicaciones-nube/wigy).
- Su catálogo agrupa conversión, multimedia, urgencia, confianza, popups y descripción. Ejemplos cercanos a nuestro proyecto: badges de pago/envío, cuenta regresiva, preguntas frecuentes, galerías, bloques de contenido, reseñas y banners. También ofrece bundles, favoritos, aviso de stock y regalo en carrito. Las tarjetas enlazan demos propias; sus descripciones son oferta funcional, no especificaciones de implementación. [Catálogo](https://wigy.app/todos).
- La guía explica este flujo: aplicación instalada y cuenta creada → dashboard Widgets → ámbito → tipo → información y estilo → crear. Después permite editar, desactivar, eliminar o duplicar. La prioridad documentada por tipo es **producto > categoría > tienda**: la definición más específica sustituye a la general. No requiere copiar un widget distinto a cada producto. [Crear widget](https://guia.wigy.app/es/articles/14668343-como-creo-un-widget).
- Permite aplicación general, con excepciones según función. El alcance de categoría requiere datos de producto sincronizados y también tiene excepciones. No todos los módulos admiten todos los ámbitos. [Masivos](https://guia.wigy.app/es/articles/14668055-como-creo-widgets-de-forma-masiva), [categorías](https://guia.wigy.app/es/articles/14670105-como-creo-un-widget-por-categoria).
- Tiene ordenación por arrastrar y soltar en regiones de ficha: antes/después de descripción y antes del carrito. Los bundles que sustituyen el formulario tienen restricciones de ubicación. [Orden](https://guia.wigy.app/es/articles/14668651-como-cambio-el-orden-de-los-widgets).
- Para home, crea ciertos widgets con alcance general y elige ubicación y si deben ocultarse en la ficha. No todos los tipos ofrecen las mismas opciones. [Widgets de inicio](https://guia.wigy.app/es/articles/15554240-como-creo-widgets-en-la-pagina-de-inicio-de-mi-tienda).
- Soporta varias tiendas con suscripción por tienda. Al cancelar, los widgets dejan de verse y la configuración permanece para reactivar. Esto documenta dependencia operativa del servicio; por sí solo no revela si la comprobación ocurre en frontend, backend o publicación. [Precio y FAQ](https://www.wigy.app/precio).

## Hallazgo central: no todas las modificaciones son automáticas

La guía publicada el **24/08/2026**, anunciando un cambio del **28/08**, explica que anteriormente Wigy ocultaba partes del formulario nativo mediante JavaScript. Con cambios y requisitos de Tiendanube, ahora exige CSS explícito en el tema para ocultarlo. Afecta al modo de reemplazo de bundles de cantidad, 2x1/3x2 y packs complementarios.

El panel genera las reglas por producto y un bloque consolidado. El comerciante debe pegarlas en el CSS de la tienda; de otro modo pueden aparecer ambos formularios. Al dejar de usar el widget/app debe retirar ese CSS. La guía no identifica en ese texto el mecanismo técnico concreto que motivó la restricción. [Cambio de renderizado](https://guia.wigy.app/es/articles/16291459-mas-informacion-cambio-en-widgets-con-reemplazo-del-formulario-en-tiendanube).

Otra guía indica expresamente que hay estilos/ocultamientos que no pueden ejecutar desde la app y enseña a usar CSS avanzado del editor clásico o CSS personalizado de Ipanema, conservando reglas existentes. [Inserción de CSS](https://guia.wigy.app/es/articles/16292129-como-inserto-codigo-css-en-mi-tiendanube).

El badge de cuotas también puede duplicar información nativa. La solución documentada consiste en desactivar las cuotas originales en el personalizador y publicar el diseño. [Ocultar cuotas nativas](https://guia.wigy.app/es/articles/15939451-como-oculto-el-mensaje-nativo-de-tiendanube-de-cuotas-sin-interes).

**Implicación para nuestro plan:** la experiencia comercial puede ser muy sencilla sin que la integración sea universal ni completamente automática. La gestión de reemplazos, compatibilidad y desinstalación continúa siendo necesaria incluso en un producto existente.

## Rendimiento, compatibilidad y sincronización

| Aspecto | Evidencia pública | Límite de la conclusión |
|---|---|---|
| Compatibilidad | Help y términos excluyen Patagonia | No generalizar a todo tema/versiones |
| Activación | Help avisa posible espera de 5–10 minutos tras suscribirse | Es propagación de activación, **no** demora de cada visita |
| Stock | Ciertos bundles no aparecen sin stock suficiente | La ausencia de widget no implica fallo de carga |
| Datos de producto | Help recomienda sincronizar manualmente si el dashboard no refleja un cambio | No asumir actualización instantánea garantizada |
| SSR, CLS, FCP/LCP, bytes, CPU | No encontré garantías ni mediciones publicadas en las páginas revisadas | Requiere medir demo/storefront; marketing no basta |

Fuentes: [Visibilidad y compatibilidad](https://guia.wigy.app/es/articles/14782748-por-que-no-se-ven-los-widgets-en-mi-tienda), [sincronización](https://guia.wigy.app/es/articles/14668678-por-que-no-se-actualiza-la-informacion-de-mi-producto), [términos](https://wigy.app/terminos).

No revisé una pantalla de consentimiento autenticada; **permisos OAuth exactos no confirmados**. La política de privacidad enumera datos de cuenta, integración, configuración y uso, pero no sustituye un listado técnico de scopes. [Privacidad](https://wigy.app/privacidad).

## Documentación que requiere lectura cuidadosa

Un artículo de promociones conserva el cuerpo antiguo que dice que Wigy solo refleja promociones, pero una actualización destacada del **22/07/2026** informa que ahora puede generarlas desde su configuración. La actualización más reciente impide afirmar categóricamente que Wigy nunca modifica promociones. No se verificó qué API usa ni qué tipos cubre. [Precios y promociones](https://guia.wigy.app/es/articles/14667780-por-que-no-coinciden-los-precios-de-los-descuentos-y-promociones-de-mi-widget-con-el-carrito).

Los términos de diciembre de 2025 describen una función exclusivamente visual; no usarlos como descripción técnica completa de capacidades posteriores. La política de noviembre de 2025 tampoco basta para explicar módulos más nuevos como suscripciones de stock. La discrepancia documental no permite deducir por sí sola un incumplimiento. [Términos](https://wigy.app/terminos), [privacidad](https://wigy.app/privacidad).

## Demos oficiales útiles para pruebas

- [Cuenta regresiva](https://wigy.mitiendanube.com/productos/cuenta-regresiva/).
- [Badge de cuotas](https://wigy.mitiendanube.com/productos/badge-de-cuotas/).
- [Segunda demo](https://wigydemostraciones.mitiendanube.com), enlazada desde catálogo para favoritos y regalo en carrito.

Estas URLs están enlazadas por el [catálogo oficial](https://wigy.app/todos). Una ficha del crawler no equivale al HTML original ni a una traza de navegación. Las conclusiones de carga deben usar respuesta HTML, red, ejecución y render del navegador, distinguir tema nativo de Wigy y precisar página/fecha/condiciones.

## Aplicación a nuestro sistema

Adoptar como referencia de producto: catálogo visible, reglas con prioridad, panel por tienda, ubicación, edición masiva, estados activos y documentación. Son patrones funcionales; no requieren copiar implementación propietaria.

Para aceptar el mismo mecanismo de entrega, todavía debe demostrarse que cumple nuestros requisitos: contenido y geometría iniciales, CSS oportuno, carga sin interacción y costo acotado. Si los módulos aparecen mediante JS, que la demo parezca rápida con buena conexión no cumple automáticamente esa exigencia. Un panel similar puede administrar módulos nativos con una arquitectura distinta; la tecnología debe decidirse por evidencia y alcance, no por la existencia de un competidor.
