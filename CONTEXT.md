# Portabilidad del diseño Tiendanube

Vocabulario para trasladar las personalizaciones de esta tienda a otra que use el mismo tema.

## Lenguaje

**Tienda origen**:
La tienda Trimetra 3D de la que provienen las personalizaciones relevadas.

**Tienda destino**:
La tienda que recibirá el diseño y conservará sus propios datos y operación comercial.

**Tema base**:
El diseño de Tiendanube sobre el que se construyeron las personalizaciones. El mismo nombre comercial no garantiza que dos copias tengan la misma versión.

**Personalización**:
Una modificación o incorporación al tema base que aporta comportamiento, presentación o contenido propio.

**Módulo portable**:
Una personalización trasladable junto con sus dependencias y necesidades de configuración.

**Catálogo de módulos**:
La lista consultable de funcionalidades del paquete, con su propósito, ubicación y requisitos. Incluye tanto widgets visibles como mejoras del funcionamiento de la tienda.

**Gestor de módulos**:
El panel de la app abierto desde el administrador de una tienda para descubrir, configurar y mantener sus módulos. No administra varias tiendas desde un dashboard central.

**Administrador de la tienda**:
La persona que instala y utiliza la app en el contexto de esa tienda. Su acceso no implica un rol de gestión conjunta de otras tiendas.

**Instalación de la app**:
La autorización y configuración independientes con las que una tienda utiliza la app. Otra tienda tiene su propia instalación, aunque comparta el servicio técnico que la ejecuta.

**Integración de tema**:
Los pequeños ajustes incorporados al diseño para ubicar módulos, reservar espacio o conservar contenido útil mientras se carga la app. No implican que todo widget SDK exista en el HTML inicial.

**Adaptador de tema**:
La compatibilidad específica con una familia y versión comprobadas de diseño: ubicaciones, estilos y pequeños ajustes requeridos. No equivale a un publicador automático de archivos.

**Fallback inicial**:
El contenido nativo útil que permanece disponible mientras un módulo carga o no está disponible. Un espacio vacío reservado no cumple esa función.

**Módulo compatible**:
Un módulo cuyo funcionamiento y contrato de carga fueron comprobados para una combinación concreta de tema y ubicación. Su existencia en el catálogo no acredita esa compatibilidad.

**Versión publicada**:
La combinación de módulos y configuración efectivamente aplicada y comprobada en una tienda. Se distingue de los cambios todavía guardados como borrador en la app.

**Módulo instalado**:
Un módulo cuyos componentes requeridos ya se incorporaron a una tienda. Puede permanecer desactivado.

**Módulo habilitado**:
Un módulo activado en la configuración de la tienda. Que aparezca ante un comprador también depende de su ubicación, contenido y condiciones de uso.

**Paquete de portabilidad**:
El conjunto distribuible de módulos, recursos e instrucciones para reproducir el diseño en otra tienda.
_Evitar_: Plugin nativo de Tiendanube, plugin de WooCommerce.

**Perfil de tienda**:
Los datos de identidad, contacto, contenido y condiciones comerciales propios de una tienda.

**Campaña**:
Una comunicación comercial con vigencia y productos elegibles; no equivale a la financiación real habilitada para comprar.
