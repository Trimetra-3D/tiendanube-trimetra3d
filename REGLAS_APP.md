# Reglas de la app modular

Estado: contrato de diseño para implementar. Arquitectura elegida por el usuario: panel y widgets por NubeSDK, tomando Wigy como referencia funcional; pequeños ajustes manuales de CSS/HTML cuando aporten estabilidad. No se copia su código. No hay implementación ni mediciones propias todavía.

Estas reglas tienen prioridad sobre las propuestas anteriores de publicación automática de archivos de tema. Véanse el [plan vigente](./PLAN_PORTABILIDAD.md), el [catálogo](./CATALOGO_MODULOS.md) y la [investigación de Wigy](./INVESTIGACION_WIGY_TECNICA.md).

**Contexto obligatorio:** una instalación por tienda. Se abre desde el administrador de esa tienda y gestiona únicamente sus módulos. No hay dashboard central, selector/listado de tiendas ni rol de responsable de varias tiendas. El aislamiento entre instalaciones es una obligación técnica, no una función de gestión conjunta.

## 1. Principio de carga

**La tienda nunca debe esperar a nuestra app para mostrar su contenido nativo o permitir comprar.** Los widgets SDK pueden necesitar descarga y configuración. Eso no se disfraza como render de servidor ni se resuelve ocultando la página.

Cada módulo declara cuál de estos contratos ofrece:

| Clase | Contrato | Ejemplo |
|---|---|---|
| A: contenido crítico | La función esencial ya existe en el tema o en un pequeño fallback HTML inicial. El SDK solo complementa dentro de una región estable | Precio/compra nativos; mensaje básico de campaña; enlace de contacto |
| B: contenido adicional | El widget monta en un espacio previsto, sin desplazar el resto. Su aparición se mide por separado | Reseñas, beneficios o bloque multimedia añadido |
| C: bajo demanda | Se carga al solicitarlo; el control para abrirlo está disponible sin depender del proveedor pesado | Reproducción de video, chat, modal |

Reservar espacio evita parte del CLS, **no equivale a tener el contenido listo**. Si un módulo debe mostrar contenido real desde el primer render y no hay fallback nativo suficiente, queda pendiente de integración; no se presenta como clase A.

## 2. Reglas obligatorias

### R01 — Nunca ocultar la tienda para cargar la app

Prohibido ocultar `body`, contenedores principales, precios o navegación hasta que llegue JS. Prohibidos loaders globales, esperas artificiales, overlays de carga y animaciones de entrada obligatorias para descubrir contenido esencial.

### R02 — SDK y ubicaciones oficiales

Usar componentes/eventos de NubeSDK y slots existentes. No manipular el DOM desde el Worker, duplicar el loader de plataforma ni insertar scripts alternativos para eludir su ciclo de carga. Un slot personalizado requiere integración explícita y comprobada en el tema; HTML común pegado en cualquier editor no crea automáticamente un slot NubeSDK.

### R03 — Cargar solo lo pertinente

Loader y núcleo pequeños; código separado por familias de widgets. No descargar todas las funcionalidades porque una tienda active una sola. Resolver ruta, producto, categoría y prioridades antes de montar. Un módulo desactivado no genera componentes, timers, listeners, solicitudes ni medios propios. El costo fijo compartido se mide aunque todos los módulos estén desactivados.

### R04 — Sin cascadas evitables de peticiones

Una respuesta de configuración agregada por contexto; prohibido un fetch por widget o tarjeta. Iniciar configuración y carga de código en paralelo cuando exista contexto fiable. No esperar a terminar de descargar la biblioteca completa para pedir los datos. Deduplícar solicitudes simultáneas y descartar respuestas de una navegación anterior.

### R05 — Caché con versión y vigencia

Recursos de código inmutables/versionados cuando el canal de distribución lo permita. Configuración pública cacheable con revisión, validación condicional y caducidad explícita; comprobar CORS y headers admitidos. Caché separada por tienda/contexto/schema, nunca por una clave global compartida.

Puede mostrarse contenido estático previamente validado mientras se revalida solo si sigue vigente y no cambia la geometría. No reutilizar precios, stock, financiación o promociones vencidas. Una revocación no puede prometerse instantánea si existe TTL. No incluir tokens, datos privados o secretos en la configuración pública.

### R06 — Geometría antes del contenido

Los widgets que afectan el flujo necesitan espacio definido antes de montar: altura de barra, proporciones de medios, columnas, gaps y controles por breakpoint. El CSS de reserva debe estar disponible con el diseño inicial; inyectarlo junto con el widget ya es tarde para garantizar estabilidad.

No usar una misma altura arbitraria para todos los dispositivos ni grandes huecos para encubrir contenido ausente. Si la altura depende de texto/configuración, validar los límites editoriales y dimensiones con textos largos y zoom. No recortar información esencial para alcanzar CLS cero. Una reserva vacía no se elimina tardíamente por timeout.

### R07 — Un render estable por ubicación

Resolver datos necesarios antes del primer montaje del bloque; evitar añadir título, imagen, precio y botones sucesivamente. Actualizar datos dentro de la misma estructura y con claves estables. No reordenar productos, variantes o secciones visibles automáticamente durante el arranque. No usar polling global para descubrir cambios si existen eventos SDK apropiados.

### R08 — Conservar funciones nativas y un fallback útil

Precio, stock, cuotas reales, carrito, compra y formularios pertenecen a Tiendanube. Si falla la app, la tienda conserva esos controles. Prohibido ocultar permanentemente el formulario nativo con CSS sin una recuperación comprobada para SDK bloqueado, configuración vacía, módulo desactivado y desinstalación.

Preferir contenido adicional sobre reemplazos. Si un reemplazo necesita señal de disponibilidad, debe indicar que el componente está efectivamente listo, no solo que existe el slot o arrancó el SDK. No inventar una señal o atributo que la plataforma no expone. Sin ese mecanismo y su prueba, el reemplazo queda deshabilitado.

### R09 — Medios sin cambios de tamaño

Declarar dimensiones/proporciones, `srcset`/tamaños adecuados y poster de video. No introducir nuevas fuentes de iconos ni familias tipográficas por módulo. Reutilizar estilos/tokens del tema.

Video sin descarga hasta acción en el perfil ligero; `preload="none"` por sí solo no basta para garantizarlo. Chat/iframes y reproductores externos cargan bajo demanda. Su contenedor no empuja el contenido de la tienda. Medios visibles prioritarios no quedan sujetos a una segunda cadena de lazy loading innecesaria.

### R10 — Campañas coherentes y estables

El contador actualiza dígitos de ancho estable, no reconstruye la barra. No mostrar `00` ficticios antes de tener la hora válida. Ofrecer fecha/hora real como fallback si la precisión inicial no puede garantizarse. Programada, activa, vencida y error conservan geometría durante la visita. Al vencer, mensaje neutral y condiciones actualizadas; no colapsar la barra ni seguir comunicando una promo vencida.

### R11 — Errores acotados

Timeouts definidos, solicitudes cancelables/lógicamente descartables y reintentos limitados. No loops de reintento, timers por tarjeta ni observadores infinitos. Un módulo fallido no bloquea otros ni genera excepciones globales. Limpiar listeners/timers al cambiar de página. Mostrar información diagnóstica en el panel; no errores técnicos al comprador.

### R12 — Compatibilidad real y una fuente de configuración

Cada módulo declara slots, ubicación, tema probado, dependencias, límites de contenido y qué opciones cambian geometría. Reglas por ámbito con prioridad explícita producto > categoría > tienda; desempate y orden deterministas.

No renderizar duplicados de información nativa. Si hace falta desactivar algo en Tiendanube, la app lo indica y verifica; no simula haberlo hecho. Respetar la home y catálogo propios. SDK no equivale a permiso para reestructurar cualquier plantilla.

### R13 — Medir el costo completo

Medir loader, núcleo, módulos, configuración, imágenes, SDK y terceros. Separar costo propio del de plataforma sin esconderlo en el total. El panel administrativo y sus bibliotecas nunca viajan al storefront. Cero CLS no basta si el widget aparece tarde: medir ambas cosas.

### R14 — Publicación y retirada con versiones

Versionar código, schema, configuración e integración manual. El panel distingue guardado, publicado y comprobado. Un cambio de geometría requiere actualizar/verificar el bloque de integración antes de declararse listo. Previsualizar por tienda y activar progresivamente; posibilidad de volver a una versión compatible.

Desactivar/desinstalar informa qué CSS/HTML retirar. No borrar contenido del comerciante. La integración debe conservar un estado visual razonable sin app; si una reserva grande quedaría vacía, ese módulo necesita un fallback útil o no cumple el perfil ligero.

## 3. Integración manual pequeña

Propuesta de límite para el perfil estándar:

- **Un bloque CSS consolidado por tienda**, identificado con namespace y versión. Objetivo inicial: hasta 50 líneas legibles; el tamaño no se disfraza minificando miles de reglas.
- **Un fragmento por ubicación especial**, idealmente una llamada a slot o un contenedor/fallback breve; objetivo hasta 10 líneas por ubicación.
- Slots estándar primero. El panel genera el código exacto y muestra dónde pegarlo, para qué sirve, cómo comprobarlo y cómo quitarlo.
- Ningún script adicional para copiar. Ninguna credencial FTPS requerida por el flujo estándar. Ningún cambio amplio de plantillas oculto detrás de «instalar».
- No reglas globales sobre `body`, `.container`, todos los botones o todos los formularios. No listas enormes de selectores por producto. No repetir el bloque por cada widget.
- Reutilizar el bloque en actualizaciones que no cambian geometría. Si cambia, generar reemplazo explícito del bloque propio, preservando CSS ajeno.

El lugar de pegado debe ser compatible con el tema y entregar el CSS a tiempo. No se promete que cualquier campo HTML/CSS del administrador cumpla eso. Una tienda antigua sin slots SDK puede requerir más cambios de los permitidos: se informa como preparación adicional, no se da por «integración pequeña».

Si se superan estos límites, el módulo se marca **requiere integración mayor** y queda fuera del perfil estándar hasta decidir su alcance. No ampliar silenciosamente la cantidad de código que el usuario debe mantener.

## 4. Presupuestos verificables iniciales

Objetivos propuestos para desarrollo; todavía no medidos ni garantizados. Se aplican por contexto, con contenido equivalente y perfil de prueba reproducible.

| Recurso / comportamiento | Presupuesto o condición |
|---|---|
| Loader propio | <= 3 KiB comprimidos |
| Núcleo común propio | <= 25 KiB comprimidos |
| Módulos necesarios para la primera vista | <= 30 KiB comprimidos adicionales; excepciones documentadas, no silenciosas |
| Configuración | Una consulta agregada normal por contexto, <= 20 KiB comprimidos; evitar repetir por widget |
| Framework del panel en tienda | 0 bytes |
| Fuentes/framework CSS agregados por módulo | 0 |
| CLS inesperado atribuible al módulo | 0 en los escenarios de aceptación |
| Trabajo propio en hilo principal | Ninguna tarea > 50 ms en el perfil probado; incluir el trabajo que provoca renderizar desde el Worker |
| Contenido clase A | Esencial ya visible en primer render por vía nativa/fallback; si no, bloquea activación como clase A |
| Contenido clase B visible inicialmente | Objetivo: listo <= 200 ms después de FCP en el perfil estándar acordado; medir caché fría/caliente. Si no se cumple, informar limitación o exigir fallback; no llamarlo inmediato |
| Videos/servicios pesados | Bajo demanda por defecto |

No hay garantía universal de 200 ms en cualquier red. El presupuesto obliga a detectar un diseño que no cumple, no a declarar que una red lenta deja de existir. Registrar además LCP, INP, TTFB, requests y bytes totales frente a la tienda sin app y a contenido equivalente.

## 5. Pruebas que bloquean una release

1. SDK, configuración y código propio retrasados 10 segundos: tienda nativa visible y comprable; clase A con fallback, reservas estables y sin ocultación global.
2. Configuración vacía, error, timeout, módulo deshabilitado, app retirada y caché antigua: sin formularios nativos ocultos ni reservas grandes inexplicables.
3. Móvil/desktop, 320/390/768/1440 px, textos largos, zoom 200%, fuentes/medios lentos; navegación atrás/adelante y cambio de variante/ruta.
4. Capturar filmstrip y tiempos de aparición por módulo, además de CLS con atribución. Medir primera visita y caché caliente; no usar solo una captura final o una puntuación Lighthouse.
5. Verificar requests por contexto, deduplicación, descarte de respuestas viejas, caducidad de promociones y ausencia de timers/listeners duplicados.
6. Comprobar presupuesto de bundles automáticamente y estado renderizado en demo real. La falta de un navegador/prueba deja estado «no validado».
7. Comprobar integración pegada: versión, ubicación, CSS temprano, desactivación y retirada. La vista previa del panel no sustituye a la tienda real.

Cada release guarda sus resultados por módulo + ubicación + tema. Si falla estabilidad o contenido crítico, no se habilita esa combinación.

## 6. Ficha obligatoria para módulos nuevos

ID/versiones; propósito; ámbito y prioridad; slots admitidos; clase A/B/C; contenido inicial/fallback; CSS de integración y dimensiones; recursos y presupuesto; datos requeridos y TTL; eventos SDK; dependencias/conflictos; estado vacío/error; migración/retirada; pruebas y evidencia.

Cada cambio futuro entra al registro y al catálogo visible. La app mostrará **compatible**, **necesita pegar integración**, **requiere integración mayor** o **no validado**, en lugar de ofrecer activar cualquier cosa sin conocer sus requisitos.
