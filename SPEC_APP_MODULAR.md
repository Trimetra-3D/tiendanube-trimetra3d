# App modular privada para Tiendanube con NubeSDK e integración ligera

Estado: especificación de referencia para los seis tickets aprobados y publicados en el repositorio de la app. No implica implementación ni compatibilidad ya comprobada.

## Problem Statement

Las personalizaciones de una tienda Tiendanube crecieron como cambios distribuidos entre widgets, estilos, scripts y plantillas. Es difícil recordar qué mejoras existen, configurarlas, reutilizarlas y sumar otras sin perder control de dependencias o rendimiento.

El usuario necesita trasladar y administrar todas las funciones reutilizables en otras tiendas, empezando por una tienda semi nueva de otro rubro, con productos y home propios. Quiere una app desde el comienzo, sin una herramienta local temporal. No quiere que instalar mejoras o actualizarlas oculte la tienda, retrase contenido esencial, produzca saltos visuales o deje la compra dependiendo de la disponibilidad de nuestra app.

## Solution

Crear una app instalable en una tienda Tiendanube, con un panel de módulos accesible desde el administrador de esa tienda. El administrador configura exclusivamente los módulos de esa instalación: ámbito, ubicación, orden, contenido y apariencia. La app entrega los widgets mediante NubeSDK y conserva las funciones nativas de Tiendanube. Wigy es una referencia funcional; su dashboard multitienda no forma parte del producto solicitado.

No hay rol de responsable de varias tiendas, listado de tiendas, selector de tienda ni dashboard central. Al abrir la app desde una instalación autorizada, el contexto de esa tienda se resuelve automáticamente. Instalar la misma app en otra tienda genera una instalación independiente, no una cuenta de administración conjunta.

Cada módulo muestra sus requisitos y evidencia de compatibilidad. Cuando haga falta estabilizar su ubicación, la app genera un pequeño bloque CSS consolidado y fragmentos breves de ubicación o fallback para pegar manualmente. No se requiere un publicador FTPS ni una reescritura general del tema.

La experiencia se valida por módulo, tema y ubicación. El contenido crítico debe seguir disponible de forma nativa o mediante un fallback inicial útil. El contenido adicional se monta en regiones estables, con un presupuesto medido de aparición. La funcionalidad pesada se solicita mediante interacción. No se promete que NubeSDK convierta sus widgets en HTML del servidor ni que una reserva vacía sea carga inmediata.

## User Stories

1. Como administrador de mi tienda, quiero instalar y abrir la app desde el administrador de Tiendanube, para gestionar exclusivamente los módulos de esta tienda.
2. Como administrador de mi tienda, quiero conservar mi home, catálogo y configuración, para incorporar mejoras sin reconstruir el sitio.
3. Como administrador de mi tienda, quiero consultar un catálogo de módulos con ejemplos y descripciones, para recordar qué funcionalidades tengo disponibles.
4. Como administrador de mi tienda, quiero filtrar módulos por zona y propósito, para encontrar mejoras de inicio, catálogo, promociones, páginas e integraciones.
5. Como administrador de mi tienda, quiero ver dónde aparece cada módulo, para entender su efecto antes de activarlo.
6. Como administrador de mi tienda, quiero distinguir módulos compatibles, pendientes de integración y no validados, para no activar una función que todavía no puede operar correctamente.
7. Como administrador de mi tienda, quiero configurar mi identidad, textos, imágenes, contactos y condiciones, para no publicar datos heredados de Trimetra.
8. Como administrador de mi tienda, quiero aplicar un módulo a toda la tienda, para mantener una configuración general reutilizable.
9. Como administrador de mi tienda, quiero definir módulos por categoría cuando la función lo admita, para adaptar mensajes sin editar cada producto.
10. Como administrador de mi tienda, quiero configurar excepciones por producto, para atender necesidades particulares del catálogo.
11. Como administrador de mi tienda, quiero ver qué configuración gana entre producto, categoría y tienda, para evitar resultados ambiguos o duplicados.
12. Como administrador de mi tienda, quiero ordenar los módulos dentro de ubicaciones admitidas, para controlar su presentación sin alterar la estructura nativa arbitrariamente.
13. Como administrador de mi tienda, quiero editar y duplicar configuraciones, para reutilizar contenido sin repetir trabajo.
14. Como administrador de mi tienda, quiero guardar cambios antes de publicarlos, para revisar su efecto y requisitos de integración.
15. Como administrador de mi tienda, quiero ver dependencias y conflictos antes de activar módulos, para evitar combinaciones incompatibles.
16. Como administrador de mi tienda, quiero mostrar opiniones reales con puntuación, fuente y contexto, para aportar confianza a los compradores.
17. Como administrador de mi tienda, quiero agregar una barra de beneficios propios, para comunicar condiciones útiles de compra.
18. Como administrador de mi tienda, quiero presentar mis diferenciales de marca, para explicar por qué elegir mi negocio.
19. Como administrador de mi tienda, quiero combinar un producto con un video y poster, para mostrar su uso conservando los datos y acciones de compra nativos.
20. Como administrador de mi tienda, quiero combinar ofertas con video, para presentar una selección comercial sin cargar contenido pesado innecesario.
21. Como administrador de mi tienda, quiero agregar banners de categorías responsivos, para facilitar la navegación con recursos propios.
22. Como administrador de mi tienda, quiero habilitar mejoras compatibles de navegación, para hacer más claros mis enlaces sin reemplazar mi menú.
23. Como administrador de mi tienda, quiero mejorar la presentación de las tarjetas de producto, para ordenar la información de precio, cuotas y compra.
24. Como comprador, quiero ver información de cuotas coherente con el producto y la variante, para evaluar mi compra sin interpretar una comunicación como financiación habilitada.
25. Como comprador, quiero identificar variantes disponibles, para elegir sin que las opciones se reordenen inesperadamente mientras carga la página.
26. Como administrador de mi tienda, quiero disponer de una descripción de producto más amplia cuando sea compatible, para presentar mejor su contenido sin perder texto existente.
27. Como administrador de mi tienda, quiero incorporar bloques de descripción enriquecida, para agregar características y explicaciones con medios de dimensiones estables.
28. Como administrador de mi tienda, quiero configurar campañas con fechas, zona horaria y elegibilidad, para mantener mensajes coherentes entre módulos.
29. Como comprador, quiero consultar una cuenta regresiva y su fecha límite, para entender la vigencia sin ver valores ficticios ni saltos del encabezado.
30. Como administrador de mi tienda, quiero mostrar etiquetas promocionales en productos elegibles, para destacar oportunidades sin extender condiciones a productos que no corresponden.
31. Como administrador de mi tienda, quiero disponer de una landing promocional en una ubicación compatible, para reunir contenido y catálogo conservando filtros y navegación nativos.
32. Como administrador de mi tienda, quiero mostrar estados de campaña programada, activa o finalizada, para retirar mensajes vencidos y mantener información coherente.
33. Como administrador de mi tienda, quiero una página informativa de envíos adaptable, para explicar cobertura y condiciones propias.
34. Como administrador de mi tienda, quiero una página de medios de pago, para comunicar alternativas confirmadas sin modificar la financiación real.
35. Como administrador de mi tienda, quiero una página de garantías y devoluciones con mis políticas, para evitar trasladar condiciones específicas de impresión 3D.
36. Como administrador de mi tienda, quiero una página de contacto y horarios, para ofrecer canales oficiales conservando el formulario nativo.
37. Como administrador de mi tienda, quiero una página de quiénes somos con contenido real, para presentar mi equipo y operación.
38. Como administrador de mi tienda, quiero comunicar preventas y consultas de reserva, para mostrar condiciones propias sin prometer un cobro automático de seña.
39. Como comprador, quiero un acceso inmediato a contacto, para poder consultar incluso si el proveedor de chat todavía no cargó.
40. Como administrador de mi tienda, quiero medir interacciones pertinentes, para evaluar módulos sin duplicar eventos ecommerce ni bloquear su presentación.
41. Como administrador de mi tienda, quiero aplicar mejoras de apariencia de checkout únicamente donde sean admitidas, para conservar el proceso de pago.
42. Como administrador de mi tienda, quiero recibir un bloque de integración pequeño y con instrucciones precisas, para mejorar la estabilidad sin mantener grandes modificaciones de código.
43. Como administrador de mi tienda, quiero saber qué fragmento corresponde a cada ubicación, para pegarlo en el lugar correcto y comprobarlo.
44. Como administrador de mi tienda, quiero que una actualización preserve mi CSS ajeno, para no perder personalizaciones previas.
45. Como administrador de mi tienda, quiero instrucciones de retirada, para desactivar o desinstalar sin dejar formularios ocultos ni espacios inexplicables.
46. Como comprador, quiero ver el contenido nativo y poder comprar mientras carga la app, para no depender de su disponibilidad.
47. Como comprador, quiero que los módulos ocupen un espacio estable, para que no se muevan controles o textos mientras los uso.
48. Como comprador, quiero que imágenes y videos tengan proporciones previstas, para evitar desplazamientos durante su descarga.
49. Como comprador, quiero solicitar videos, chat y funciones pesadas cuando los necesite, para no pagar ese costo antes de interactuar.
50. Como comprador, quiero usar los módulos con teclado, zoom y movimiento reducido, para acceder a su contenido sin barreras innecesarias.
51. Como comprador, quiero que la información de producto siga a la variante y ruta actuales, para no recibir una respuesta antigua de otra navegación.
52. Como comprador, quiero que una campaña vencida deje de prometer beneficios, para no basar la compra en condiciones incorrectas.
53. Como administrador de mi tienda, quiero que la app cargue solamente código y datos pertinentes, para limitar solicitudes, bytes y trabajo adicional.
54. Como administrador de mi tienda, quiero configuración cacheada con vigencia, para mejorar tiempos sin servir contenido de otra tienda o promociones vencidas.
55. Como administrador de mi tienda, quiero diagnóstico y evidencia de las pruebas, para saber qué combinación de módulo y tema cumple las reglas.
56. Como administrador de mi tienda, quiero diferenciar cambios guardados, publicados y comprobados, para no confundir una acción administrativa exitosa con una modificación visible.
57. Como administrador de mi tienda, quiero volver a una configuración compatible, para recuperarme de una actualización defectuosa.
58. Como administrador de mi tienda, quiero que desactivar un módulo retire sus efectos de ejecución, para no mantener peticiones, timers o listeners innecesarios.
59. Como administrador de mi tienda, quiero que los fallos de un módulo estén aislados, para conservar el resto de la tienda y de los widgets.
60. Como administrador de mi tienda, quiero que la app explique cuándo una función necesita una integración mayor, para decidirlo antes de asumir mantenimiento adicional.
61. Como mantenedor, quiero registrar cada mejora nueva con su propósito, contrato y versión, para que ninguna modificación vuelva a quedar invisible.
62. Como mantenedor, quiero comprobar rendimiento con red lenta y caché fría, para detectar problemas que una visita rápida no revela.
63. Como mantenedor, quiero probar SDK y configuración demorados o caídos, para verificar que el fallback y la compra nativa sobreviven.
64. Como mantenedor, quiero bloquear releases que incumplan estabilidad o contenido crítico, para evitar trasladar al comprador un problema conocido.
65. Como mantenedor, quiero comenzar con una parte funcional de la app final, para validar el enfoque sin construir una herramienta que luego deba descartarse.

## Implementation Decisions

### Arquitectura y fronteras

1. Construir directamente una app con panel administrativo, backend de configuración y runtime NubeSDK. El patrón de Wigy es referencia de organización y entrega, no autorización para copiar su código.
2. Cada tienda instala y autoriza la app de forma independiente. Se accede desde su administrador de Tiendanube y se conserva ese contexto durante toda la sesión, sin selección ni conexión de otras tiendas. Usar el mecanismo oficial de acceso e integración; no confiar en un ID de tienda aportado por el navegador para autorizar operaciones. Credenciales y tokens permanecen exclusivamente en backend.
3. El panel y sus dependencias no forman parte del bundle de storefront. TypeScript, Node y PostgreSQL son una propuesta de implementación; versiones, framework del panel y hosting no quedaron elegidos.
4. El runtime usa componentes declarativos, slots, estado y eventos oficiales. No manipula el DOM desde el Worker, no duplica el loader de plataforma y no traslada código dependiente de jQuery/Swiper o renderizadores DOM al SDK.
5. Conservar catálogo, precios, stock, carrito, navegación y checkout nativos. Ninguna instalación sustituye automáticamente la home o las descripciones existentes.
6. Slots estándar primero; slots personalizados solo con una integración admitida y comprobada. Pegar HTML en un editor cualquiera no se considera equivalente a declarar un slot del tema.

### Registro y alcance funcional

El catálogo contiene los siguientes 26 candidatos. Su inclusión exige investigar/adaptar la función; no acredita compatibilidad universal ni permite activarla sin validación.

| ID estable propuesto | Función |
|---|---|
| `home.reviews` | Opiniones de clientes |
| `home.benefits` | Barra de beneficios |
| `home.value-proposition` | Propuesta de valor |
| `home.product-video` | Producto con video |
| `home.offers-video` | Ofertas con video |
| `home.category-banners` | Banners de categorías |
| `navigation.enhancements` | Mejoras de navegación |
| `catalog.product-cards` | Tarjetas de producto |
| `catalog.installments` | Resumen de cuotas |
| `catalog.stock-variants` | Presentación de variantes disponibles |
| `product.description-layout` | Descripción amplia |
| `product.rich-description` | Descripción enriquecida |
| `promotions.campaigns` | Configuración de campañas |
| `promotions.countdown` | Cuenta regresiva |
| `promotions.badges` | Etiquetas promocionales |
| `promotions.landing` | Landing de campaña |
| `promotions.status-pages` | Estados de campaña |
| `pages.shipping` | Información de envíos |
| `pages.payment` | Información de medios de pago |
| `pages.warranty` | Garantías y devoluciones |
| `pages.contact` | Contacto y horarios |
| `pages.about` | Quiénes somos |
| `commerce.preorders` | Preventas y consulta de reserva |
| `integrations.chat` | Acceso a chat y fallback de contacto |
| `integrations.analytics` | Medición de interacciones |
| `checkout.appearance` | Apariencia de checkout compatible |

Cada módulo registra propósito, ámbito, ubicaciones, dependencias/conflictos, schema, versión, capacidades requeridas, contrato de carga, recursos, presupuesto, vigencia de datos, eventos, fallback, pruebas y retirada. El mismo registro alimenta catálogo y validadores.

Los módulos que exijan reestructuración no expuesta por SDK, demasiado código manual o información no disponible quedan identificados como integración mayor o no validados. No se reduce el catálogo silenciosamente ni se sustituye una función por otra que aparente equivalencia.

### Modelo de configuración y contratos públicos

- Una instalación identifica la tienda, su autorización, capacidades y datos públicos permitidos. Puede compartirse infraestructura entre instalaciones, con separación de almacenamiento, permisos, caché y respuestas; esto no introduce funciones de administración central para el usuario.
- Una definición de módulo describe su contrato; una instancia configura contenido, ámbito, posición y orden para una tienda. La prioridad más específica sustituye a la general cuando corresponde al tipo: producto > categoría > tienda. No inventar una precedencia entre categorías múltiples sin un desempate explícito.
- Una revisión de configuración agrupa instancias y sus versiones. Los cambios se guardan como borrador y se publican de forma compatible; estado publicado no equivale a comprobado en el storefront.
- Una revisión de integración identifica el CSS/fragmentos manuales requeridos. Un cambio de geometría obliga a comprobar su compatibilidad antes de activar la nueva configuración.
- Una evidencia de compatibilidad relaciona módulo, versión, tema, ubicación, integración, perfil de prueba y resultados. No inferir compatibilidad únicamente del nombre comercial del tema.
- La API pública recibe identidad de tienda y contexto disponible de página/producto/categoría; devuelve una respuesta agregada con widgets efectivos, orden, revisión y vigencia. No publica secretos ni datos privados, ni envía el catálogo entero para resolver una visita.
- Deduplícar peticiones simultáneas y descartar respuestas de contextos anteriores. Usar una consulta normal por contexto, no una por widget o tarjeta. Cargar datos y código en paralelo cuando haya contexto fiable.
- Separar el código en un núcleo pequeño y familias seleccionadas. Un módulo desactivado no monta componentes ni crea solicitudes, medios, timers o listeners propios; el costo fijo compartido se mide igualmente.
- Cachear código versionado cuando el canal lo permita y configuración por tienda/contexto/schema con revisión y caducidad. El contenido estático vigente puede reutilizarse durante revalidación sin cambiar geometría. No cachear una promesa comercial más allá de su validez ni presentar snapshots de precio/stock como autoridad.
- No prometer revocación o propagación instantánea si hay TTL. Los límites de caché y su invalidación deben verificarse durante la implementación.

### Contratos de carga A/B/C

| Clase | Comportamiento requerido |
|---|---|
| A: crítico | El contenido esencial está disponible nativamente o en un fallback inicial útil. El SDK complementa sin quitar acceso a la función |
| B: adicional | El widget monta en un espacio previsto; se miden tanto desplazamientos como tiempo real de aparición |
| C: bajo demanda | La función pesada se carga al solicitarla; su control inicial y alternativa son utilizables |

Una reserva geométrica no cuenta como contenido inicial. Si una función necesita contenido real desde el primer render y no dispone de un fallback suficiente, no se habilita como clase A.

### Reglas de render, interacción y errores

- Nunca ocultar la página, sus contenedores principales, precios, navegación o compra mientras carga la app. No introducir loaders globales ni animaciones obligatorias para descubrir contenido esencial.
- La geometría que afecta al flujo debe existir antes del montaje: altura/proporciones, columnas, gaps y controles por breakpoint. El CSS inyectado junto al contenido no se toma como una reserva temprana.
- Montar un bloque con datos suficientes y estructura estable; evitar insertar sus partes de forma sucesiva. No reordenar automáticamente contenido nativo visible al arrancar.
- No usar huecos grandes ni recortes de información esencial para aparentar CLS cero. No colapsar una reserva tardíamente por timeout. Los estados vacío/error/desactivado requieren una solución probada.
- Un reemplazo de controles nativos requiere señal real de disponibilidad y recuperación probada. La existencia del slot o inicio del SDK no demuestra que el reemplazo esté listo. Sin ese mecanismo, conservar el control nativo y bloquear el reemplazo.
- Mantener dimensiones de imágenes y posters; reutilizar tipografías/tokens y evitar nuevas bibliotecas de iconos o frameworks CSS. Video y servicios pesados bajo demanda por defecto; asignar la fuente tras la acción cuando se requiera cero descarga previa, sin asumir que una sugerencia de preload basta.
- Campañas con fechas y zona horaria explícitas; contador de ancho estable, sin ceros ficticios y con fecha/hora útil como fallback. Vencimiento/error no colapsan el encabezado ni dejan beneficios vencidos activos.
- Reaccionar a eventos oficiales; no polling global para descubrir cambios cubiertos por eventos. Timeouts y reintentos acotados; aislamiento de fallos y limpieza de efectos al cambiar de página.
- Desactivar o retirar no deja formularios nativos ocultos ni elimina contenido del comerciante. Los datos y configuraciones se conservan para una recuperación compatible.

### Integración manual limitada

- Un bloque CSS consolidado por tienda, con namespace y versión: objetivo hasta 50 líneas legibles.
- Fragmentos especiales solo donde hagan falta: objetivo hasta 10 líneas por ubicación, con propósito, lugar de pegado, prueba y retirada.
- No scripts adicionales para copiar, credenciales FTPS en el flujo estándar ni listas masivas de reglas por producto. No selectores globales sobre toda la página o todos los formularios.
- No minificar miles de reglas para aparentar cumplir el límite de líneas. Reutilizar el bloque entre actualizaciones que no cambian geometría.
- Una tienda antigua sin slots o una función con cambios amplios se informa como integración mayor. No se incorpora esa complejidad silenciosamente al perfil estándar.

### Presupuestos iniciales

Objetivos propuestos que deben medirse en un perfil reproducible. No son características garantizadas del SDK ni resultados existentes.

| Dimensión | Objetivo / condición |
|---|---|
| Loader propio | Hasta 3 KiB comprimidos |
| Núcleo común propio | Hasta 25 KiB comprimidos |
| Código de módulos necesarios para primera vista | Hasta 30 KiB comprimidos adicionales |
| Configuración | Una consulta agregada normal por contexto; hasta 20 KiB comprimidos |
| Dependencias del panel administrativo enviadas a tienda | 0 bytes |
| Fuentes o frameworks CSS nuevos por módulo | 0 |
| Layout shifting inesperado atribuible al módulo | 0 en los escenarios definidos |
| Tarea propia/provocada por render en hilo principal | Ninguna mayor de 50 ms en el perfil probado |
| Clase A | Contenido esencial/fallback inicial comprobado; de lo contrario no activable como crítico |
| Clase B visible inicialmente | Objetivo hasta 200 ms después de FCP en el perfil estándar; medir caché fría y caliente |
| Videos, chat y contenido pesado | Bajo demanda por defecto |

Contabilizar también SDK, medios y terceros en el total. No prometer 200 ms en cualquier red. Si un objetivo falla, informar y corregir, usar una integración/fallback admitidos o mantener esa combinación sin validar; no publicar una excepción silenciosa.

### Secuencia de implementación

1. Base permanente de la app: instalación y acceso oficiales desde el administrador de una tienda, panel de sus módulos, configuración versionada y detección de slots/capacidades.
2. Un recorrido funcional con countdown y opiniones o beneficios: configuración, integración pequeña, render, métricas, errores y desactivación.
3. Adaptación de las familias restantes de los 26 candidatos, con estado de compatibilidad por ubicación y tema.
4. Ciclo de vida de cada instalación: actualizaciones, caducidad/invalidación, recuperación de configuración y retirada de la integración de esa tienda.

Esta secuencia no crea un producto local temporal ni habilita módulos solo por haber compilado.

## Testing Decisions

### Frontera principal de prueba

Usar una sola frontera funcional de aceptación siempre que sea posible: **abrir la app desde el administrador de una tienda, configurar/publicar sus módulos y observar el efecto en esa tienda de prueba real**, incluyendo la integración manual, fallos de red y retirada. Validar lo que ve y puede hacer el comerciante/comprador; evitar pruebas que repitan estructura de clases, funciones internas o cadenas de código fuente.

Este enfoque forma parte de los criterios de aceptación de los seis tickets aprobados por el usuario.

Se permiten pruebas complementarias de contrato en la API pública para prioridades, aislamiento, versiones y caducidad difíciles de ejercitar exhaustivamente mediante UI. Deben pasar por la interfaz pública, no añadir seams artificiales a cada componente. El presupuesto de artefactos se verifica automáticamente sobre la salida del build.

### Antecedentes disponibles

El proyecto origen ya utiliza Playwright y axe para páginas custom, accesibilidad, rutas, campañas, comportamiento sin JavaScript, fallback de chat, eventos y adaptación responsive. También tiene pruebas de límites temporales y movimiento reducido del countdown, y un control estático de contratos.

Reutilizar la infraestructura y los escenarios que observen comportamiento externo. Las expectativas literales de fechas, marcas y contenido Trimetra no son contratos de la app genérica. El control estático ni el contador probado con markup local certifican por sí solos render, performance o compatibilidad real de NubeSDK.

### Matriz obligatoria

1. Tienda intacta como referencia y contenido equivalente como comparación: conservar home, productos, configuración y operación nativa con módulos apagados.
2. Abrir desde la instalación autorizada y configurar, ordenar, publicar y desactivar por alcance general/categoría/producto de esa tienda; comprobar precedencia, ausencia de duplicados y ausencia de listado/selector de otras tiendas. Con dos instalaciones de prueba, verificar aislamiento y rechazo de acceso a recursos ajenos, sin introducir una pantalla de administración conjunta.
3. SDK/API/código propio demorados 10 segundos o fallidos: contenido nativo y compra disponibles; clase A con fallback; reservas estables.
4. Respuestas vacías, inválidas, caducadas o de una ruta anterior: estado seguro, errores aislados, reintentos acotados y ausencia de datos equivocados.
5. Tienda demo real con caché fría/caliente, red lenta y CPU limitada; filmstrip, momento de aparición, CLS con atribución, LCP, INP, bytes y requests. No basta una captura final o una puntuación global.
6. Anchos 320, 390, 768 y 1440 px, teclado, zoom 200%, textos largos, medios/fuentes demorados y movimiento reducido.
7. Variantes y productos con/sin stock, precio/cuotas ausentes, quickshop, cambios de página y navegación atrás/adelante: foco, controles e información correctos.
8. Campaña antes/durante/después, vencimiento con página abierta, reloj cliente incorrecto y caché antigua: comunicación válida sin colapsar el bloque.
9. Recursos bajo demanda: poster/control disponible; ninguna descarga pesada anticipada en el perfil ligero; recuperación si falla el proveedor.
10. Cambios de geometría y versiones incompatibles: integración pendiente visible y activación bloqueada hasta comprobar la combinación.
11. Desactivación/desinstalación, integración ausente o antigua y script bloqueado: no quedan controles nativos ocultos ni contenido del comerciante borrado.
12. Los 26 candidatos permanecen representados; cada módulo activable tiene evidencia por versión, ubicación y tema. Un módulo pendiente no se presenta como una funcionalidad ya implementada.

Registrar resultados y ambiente junto a las versiones probadas. Una falla de contenido crítico o estabilidad impide habilitar esa combinación. La ausencia de navegador, tienda piloto o evidencia significa no validado, nunca éxito supuesto.

## Out of Scope

- Dashboard central, rol de responsable de varias tiendas, selector/listado de tiendas, conexión de otra tienda desde el panel y gestión cruzada entre instalaciones.

- Asistente local intermedio, ZIP como producto principal o app publicadora automática de archivos de tema por FTPS.
- Render de todos los widgets por Twig/servidor; promesas de SSR automático de NubeSDK, cero bytes, latencia universal o CLS global de toda la tienda igual a cero.
- Copiar código propietario de Wigy, todas sus funcionalidades comerciales o mecanismos no verificados de su backend.
- Reemplazar la home/catálogo del destino, migrar a otro tema, realizar cambios amplios de plantillas o copiar branding/contenido comercial de Trimetra.
- Configurar financiación real, inventar descuentos, cobrar señas automáticamente o sustituir controles sensibles de checkout con overlays frágiles.
- Manipulación directa del DOM desde el Worker, scripts alternativos para eludir restricciones de apps, loaders SDK duplicados y formularios nativos ocultos sin recuperación.
- Marketplace público, facturación a terceros y comercialización masiva en la primera etapa.
- Activar automáticamente los 26 módulos, certificar temas no probados o degradar silenciosamente funciones que requieran integración mayor.
- Publicación en una tienda real, instalación de apps, alta de servicios o cambios en el código del tema durante la redacción de esta especificación.

## Further Notes

- El código existente es un tema personalizado con dependencias compartidas; todavía no hay backend, panel ni runtime de esta app. El inventario histórico identificó 118 diferencias contra el respaldo inicial. Esa cifra no es una estimación de archivos necesarios para la app.
- La inspección pública de Wigy encontró loader/runtime y consulta de configuración por tienda/producto. El contenido inspeccionado del countdown estaba ausente del HTML inicial. Eso respalda el modelo de entrega elegido, pero no demuestra su latencia o CLS ni valida nuestra implementación.
- Los documentos de planificación anteriores que proponían publicación nativa de todo el tema son investigación de una alternativa descartada. Prevalecen la app NubeSDK, las reglas de carga y la integración manual pequeña acordadas al final de la conversación.
- La aclaración del usuario sobre acceso por tienda reemplaza la interpretación anterior de un panel multitienda. «Inicialmente para tiendas que administro» describe el público inicial, no una funcionalidad de gestión conjunta.
- Siguen pendientes la URL/tema exactos del destino, tienda piloto, registro/autorización de la app, hosting y comprobación de capacidades por módulo. Son requisitos de ejecución; no motivo para inventar endpoints, compatibilidad o acceso de publicación.
- Antes de aplicar los presupuestos temporales debe fijarse el perfil de prueba estándar: dispositivo/CPU, red, caché, contenido y procedimiento repetible. Los límites propuestos se conservan como objetivos hasta comprobarlos, sin convertirlos en una garantía comercial.
- Referencias primarias: [NubeSDK](https://tiendanube.dev/es-AR/apps/nube-sdk/overview), [slots personalizados](https://tiendanube.dev/es-AR/apps/nube-sdk/slots/custom-slots), [organización de widgets de Wigy](https://guia.wigy.app/es/articles/14668343-como-creo-un-widget), [integración CSS de reemplazos](https://guia.wigy.app/es/articles/16291459-mas-informacion-cambio-en-widgets-con-reemplazo-del-formulario-en-tiendanube).
- Tracker de implementación: [Trimetra-3D/tiendanube-modules](https://github.com/Trimetra-3D/tiendanube-modules/issues). Los seis tickets están publicados con `ready-for-agent` y dependencias nativas. No se creó un issue adicional para esta spec.
