# Publicación nativa de módulos en Tiendanube

Investigación: 28/09/2026. Alcance: documentación y código público oficial; sin acceso a credenciales, sin conexión FTP a tiendas, sin publicación. Complementa el [plan de portabilidad](./PLAN_PORTABILIDAD.md).

## Conclusión que cambia el plan

**La vía técnicamente adecuada para el primer render es generar Twig y CSS del tema desde el backend de la app.** Tiendanube confirma que procesa Twig en el servidor y entrega el HTML final al navegador. El panel de la app puede quedar fuera de la carga de cada visita. Esto evita necesitar un script para insertar la estructura visual, pero no elimina el costo del HTML, CSS, imágenes y trabajo de renderizado agregados. [Arquitectura oficial de temas clásicos](https://tiendanube.dev/es-AR/themes/classic-themes/getting-started).

**La publicación segura al tema legacy todavía tiene una brecha concreta.** La documentación ofrece clonar, previsualizar y publicar temas legacy; pero su sincronización de archivos sigue siendo por FTP, y el cliente FTP oficial no permite seleccionar un `theme-id`. No está demostrado que podamos editar un clon legacy aislado y luego publicarlo. No se debe presentar ese circuito como resuelto. [CLI: soporte por tipo de tema](https://tiendanube.dev/es-AR/themes/developer-tools/cli/overview), [FTP](https://tiendanube.dev/es-AR/themes/developer-tools/cli/ftp-theme-development), [configuración FTP del código oficial](https://github.com/TiendaNube/cli/blob/aa1f23687af8a40986a874988bc9dc823aeb9d86/src/category/theme/ftp/theme-ftp-client-config.ts).

## Evidencia y límites

| Capacidad | Verificado | Implicación para nuestra app |
|---|---|---|
| HTML inicial nativo | Twig se procesa del lado servidor | Publicar componentes Twig, no esperar a un loader para construirlos. [Fuente](https://tiendanube.dev/es-AR/themes/classic-themes/getting-started) |
| CSS inicial | Tiendanube documenta CSS crítico inline y estilos de colores sincrónicos | Colocar estilos de estructura en la ruta crítica del tema; el CSS diferido no debe modificar geometría ya visible. [Fuente](https://docs.tiendanube.com/help/mejorando-la-carga-del-css) |
| Listar/clonar/previsualizar/publicar legacy | Documentado por CLI | Canal oficial de gestión; no prueba de que FTP escriba sobre el clon. [Fuente](https://tiendanube.dev/es-AR/themes/developer-tools/cli/theme-management) |
| Publicación y conservación del anterior | `theme publish` vuelve productivo el elegido y conserva el anterior inactivo | Permite diseñar reversión por publicación del anterior, pendiente comprobar su comportamiento en la tienda destino. No hay SLA de invalidación de caché en esa guía. [Fuente](https://tiendanube.dev/es-AR/themes/developer-tools/cli/theme-management) |
| Sincronizar archivos legacy | `theme ftp pull/push/watch`, con credenciales FTP | FTPS desde proceso backend es técnicamente automatizable; no depende de un script del navegador del comprador. [Fuente](https://tiendanube.dev/es-AR/themes/developer-tools/cli/ftp-theme-development) |
| Sincronizar archivos por API | Documentado exclusivamente para temas seccionables | No asumir que la API de archivos del CLI funciona sobre legacy. [Fuente](https://tiendanube.dev/es-AR/themes/developer-tools/cli/sectionable-theme-development) |
| Configuración legacy | `settings.txt` define campos; Twig lee `settings.nombre`; `defaults.txt` define valores por defecto | Esquema y defaults no equivalen a exportar los valores actuales del comerciante. No se encontró en estas fuentes un endpoint documentado para leer/escribir todos los valores legacy. [Fuente](https://tiendanube.dev/es-AR/themes/classic-themes/getting-started) |
| Configuración seccionable | `config/settings_data.json` contiene valores del comerciante y viaja en pull/push | Capacidad diferente; no trasladarla al tema legacy por analogía. [Fuente](https://tiendanube.dev/es-AR/themes/developer-tools/cli/sectionable-theme-development) |

## Qué demuestra el código oficial del CLI

Se inspeccionó el repositorio público `TiendaNube/cli`, revisión `aa1f23687af8a40986a874988bc9dc823aeb9d86`, del 25/09/2026. Las citas se fijan a esa revisión para distinguir implementación observada de garantías de plataforma. El paquete npm consultado declara versión `2.3.2` y ese repositorio; esto **no demuestra** que cada línea de `main` esté incluida en el paquete. [Repositorio fijado](https://github.com/TiendaNube/cli/tree/aa1f23687af8a40986a874988bc9dc823aeb9d86), [metadatos npm](https://registry.npmjs.org/@tiendanube/cli/latest).

### FTP no ofrece despliegue transaccional en el cliente inspeccionado

- Conexión `basic-ftp`, puerto 21, `secure: true`.
- Subida directa a `/<ruta relativa>` mediante `uploadFrom`; no se observa archivo temporal, rename, commit de lote ni selección de instalación.
- `SyncAll` ejecuta grupos de subida y eliminación concurrentemente.
- La comparación incremental usa tamaño y fecha de modificación, tolerando dos segundos; no hashes de contenido.
- Los archivos vacíos se omiten en esa implementación.

Todo lo anterior está observado en [ThemeFtpClient](https://github.com/TiendaNube/cli/blob/aa1f23687af8a40986a874988bc9dc823aeb9d86/src/category/theme/ftp/theme-ftp-client.ts). No implica que el servidor carezca de rename: **su soporte y atomicidad no están demostrados por el cliente ni por las guías consultadas**.

La guía además afirma expresamente que `ftp push` elimina los archivos remotos ausentes localmente. Por eso **nunca usar un push desde una carpeta que contenga únicamente nuestros módulos**. Sería una sincronización destructiva del resto del tema. [Documentación FTP](https://tiendanube.dev/es-AR/themes/developer-tools/cli/ftp-theme-development).

Propuesta: transporte propio con lista exacta de archivos permitidos, sin borrados implícitos, snapshot previo y comprobación de contenido mediante descarga. No prometer atomicidad entre archivos. Esta es una decisión de nuestra arquitectura, no una capacidad documentada de Tiendanube.

### Existe un canal de temas en el cliente API; no equivale a acceso universal de apps

El código usa `/v1/{storeId}/theme-installations`, operaciones `/clone`, `/publish`, `/files`, hashes y lectura/escritura de archivos. Las escrituras por lote pueden dividirse en varios requests. Su existencia no acredita permisos de un token OAuth de nuestra app ni soporte de archivos legacy. [Cliente API oficial](https://github.com/TiendaNube/cli/blob/aa1f23687af8a40986a874988bc9dc823aeb9d86/src/category/theme/api/theme-api-client.ts).

La documentación limita `pull/push/watch` por API a seccionables. En ellos, editar código exige fork; sin fork se permite la personalización de templates JSON y settings de comerciante. El fork deja de recibir actualizaciones automáticas del código base; actualizar es otra operación planificada. [Desarrollo seccionable](https://tiendanube.dev/es-AR/themes/developer-tools/cli/sectionable-theme-development).

Detalle de la comprobación: `theme push` resuelve el ID y rechaza un árbol de origen FTP salvo uso de `--force`; después consulta instalación y hashes, y habilita archivos de código únicamente si `forked === true`. Esa ruta cliente no comprueba explícitamente el tipo legacy, pero el manejador oficial contempla el error servidor `THEME_NOT_SECTIONABLE`. La ausencia del control local **no demuestra** soporte del servidor; un token CLI autorizado tampoco convierte un legacy en seccionable. Además, sus prefijos de sincronización incluyen `snippets/`, no el `snipplets/` legacy. [Comando push](https://github.com/TiendaNube/cli/blob/aa1f23687af8a40986a874988bc9dc823aeb9d86/src/category/theme/api/commands/theme-api-push.ts), [plan de diferencias](https://github.com/TiendaNube/cli/blob/aa1f23687af8a40986a874988bc9dc823aeb9d86/src/category/theme/api/theme-api-diff-plan.ts), [errores API](https://github.com/TiendaNube/cli/blob/aa1f23687af8a40986a874988bc9dc823aeb9d86/src/category/theme/api/theme-api-error.ts), [prefijos](https://github.com/TiendaNube/cli/blob/aa1f23687af8a40986a874988bc9dc823aeb9d86/src/category/theme/api/theme-api-constants.ts).

Esto abre una alternativa futura de publicación completa por borradores, pero migrar de legacy a seccionable es un proyecto de adaptación del tema, **no un requisito que podamos imponer silenciosamente a la tienda existente**.

## Autenticación y operación desde backend

La autorización CLI abre el navegador, requiere iniciar sesión y entrega una cadena Base64 con `store_id` y `access_token`. Admite uso no interactivo/CI con ese token. FTP usa otro juego de credenciales, obtenidas desde el administrador. La guía no acredita que una instalación OAuth de nuestra app entregue automáticamente estos accesos. [Primeros pasos CLI](https://tiendanube.dev/es-AR/themes/developer-tools/cli/getting-started), [decodificación del token](https://github.com/TiendaNube/cli/blob/aa1f23687af8a40986a874988bc9dc823aeb9d86/src/category/theme/api/theme-api-authorize-support.ts).

Propuesta de onboarding para tiendas propias: registrar separadamente autorización de gestión de temas y autorización FTPS; guardarlas cifradas en el backend, aislar cada tienda y ejecutar publicaciones con un único job por tienda. Usar el CLI oficial como proceso versionado es una opción; llamar los endpoints encontrados directamente requiere aclarar permisos/contrato admitido para nuestra app. No automatizar login ni copiar sesiones del administrador como sustituto de autorización soportada.

Las guías de temas prueban una vía de personalización del tema. **No autorizan eludir requisitos de NubeSDK para scripts de aplicaciones.** Antes de distribuir la app, confirmar con Tiendanube que la combinación de panel privado, publicación de código nativo y comportamiento propio del tema es admitida en este caso. Separar esa validación de la prueba de rendimiento.

## Estructura compatible que debe generar el compilador

Para legacy, respetar `layouts/`, `templates/`, **`snipplets/`**, `static/` y `config/`. Los seccionables utilizan otras convenciones; no mezclar `snippets/` con `snipplets/` por error. La guía legacy muestra `snipplet`, `include` y `embed`, así como assets en `static/`. [Estructura legacy](https://tiendanube.dev/es-AR/themes/classic-themes/getting-started).

Propuesta de salida: componentes propios debajo de `snipplets/<namespace>/`, assets dentro de `static/`, e integración mínima en los puntos del tema que ya renderizan header, cards, ficha y páginas. Referencias mediante helpers nativos, por ejemplo `static_url`. No inventar una carpeta raíz `/plugins/` o `/releases/` que el servidor de temas tenga obligación de servir. [Carga de CSS oficial](https://docs.tiendanube.com/help/como-cargo-css-ftp), [includes](https://docs.tiendanube.com/help/snipplet-include-y-embed).

Las subcarpetas de versión profunda, includes dinámicos y límites de nombres deben probarse antes de elegir una estrategia de releases inmutables. Si no funcionan, generar nombres de archivo versionados dentro de ubicaciones ya admitidas. No depender de que una variable asignada dentro de un include cambie el contexto del padre: pasar parámetros explícitos y generar llamadas concretas.

Sí hay evidencia de subcarpetas en snipplets: los ejemplos oficiales incluyen `header/header-advertising.tpl` y `snipplets/forms/form-select.tpl`. Por tanto, no existe fundamento en estas fuentes para afirmar que snipplets deba ser completamente plano. Esto no garantiza profundidad ilimitada ni creación de cualquier carpeta FTP. [Ejemplos de includes](https://docs.tiendanube.com/help/snipplet-include-y-embed).

## Protocolo propuesto de publicación

1. **Descubrimiento sin escritura:** tipo/versión del tema, instalación activa, archivos/huellas, acceso real del token y destino efectivo FTPS. Guardar snapshot completo del código y registrar límites de captura de configuración/admin.
2. **Preparación:** resolver módulos y dependencias, compilar solo los habilitados, incorporar su configuración propia al artefacto; preservar íntegramente home, productos y configuración ajena.
3. **Concurrencia:** comparar código remoto contra snapshot antes de tocar archivos compartidos. Conflicto externo = detener publicación; nunca sobrescribir automáticamente una edición del comerciante.
4. **Destino aislado preferido:** clonar, subir al clon, verificar HTML/CSS real por preview, aprobar pruebas y publicar. **Legacy: esta ruta queda condicionada a demostrar cómo dirigir FTP al clon.** Seccionable: el flujo CLI está documentado, sujeto al acceso y fork adecuados.
5. **Si no existe aislamiento legacy:** no reemplazarlo con una supuesta publicación FTP atómica. Documentar la limitación y evaluar con Tiendanube un destino de prueba/publicación soportado. La alternativa de subir versiones inactivas y cambiar un único punto de entrada requiere pruebas de consistencia y recuperación; reduce superficie, no garantiza cero estados intermedios.
6. **Verificación:** releer archivos, comprobar marcador de release en HTML inicial, recursos correctos y recorridos críticos. Publicado significa observado en storefront, no solo upload exitoso. No hay garantía documental de propagación instantánea de caché.
7. **Reversión:** volver al tema anterior conservado si el canal lo permite; si se restauran archivos, hacerlo desde snapshot con comprobación de conflictos y orden de dependencias. Una restauración FTP múltiple también puede ser parcial.

Este protocolo es una propuesta de ingeniería; las garantías verificadas de Tiendanube están separadas arriba.

## Pruebas que cierran las incertidumbres

| Prueba | Criterio para aprobar |
|---|---|
| Autorización | Gestión de temas funciona en una tienda propia con credenciales soportadas; registrar cómo renovar/revocar sin login automatizado. |
| Aislamiento legacy | Identificar el destino FTP de un clon y demostrar que escribirlo no cambia el activo. Si no existe, ese modo no se ofrece. |
| Preservación | Clonar/construir mantiene home, settings, imágenes de admin, productos y páginas; lista explícita de recursos que clone/pull no exporta. |
| Consistencia | Inyectar fallo tras cada fase de subida, comprobar que producción conserva versión completa o detectar/revertir la inconsistencia. |
| Caché | Medir tiempo de propagación y combinación HTML/assets desde primera visita; no hacer cambios visuales en cliente para ocultar errores de publicación. |
| Primer render | Con JS bloqueado, estructura y estilos de módulos visibles ya están en la respuesta inicial; bloquear backend de app no cambia storefront publicado. |
| Desinstalación | Quitar solo los bloques y archivos propios, con comparación de huellas; conservar cambios posteriores del comerciante. |

La investigación sí confirma la base del renderizado nativo. No confirma un ciclo legacy completamente automático, aislado y atómico. El plan robusto debe conservar esta condición de aceptación explícita, en vez de convertirla en una promesa.
