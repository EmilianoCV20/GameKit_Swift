====================================================
appHeartSwift – Swift (UIKit / SceneKit)
====================================================

Autor: Emiliano Cepeda  
Creado: 30/11/24  
Plataforma: iOS  
Lenguaje: Swift (UIKit / SceneKit)  

----------------------------------------------------
1. Overview
----------------------------------------------------
appHeartSwift es una aplicación para iOS desarrollada en Swift que utiliza SceneKit para crear una escena 3D animada basada en una cuadrícula de primitivas. El proyecto construye una escena con cámara, iluminación y una malla de figuras 3D que se desplazan verticalmente de forma continua mediante acciones de SceneKit. La escena incluye una función matemática para generar el movimiento de cada elemento y permite interactuar con la cámara desde la vista.

La app sirve como práctica de:
- Creación de escenas 3D con SceneKit.
- Configuración de cámara y luces en una escena.
- Uso de primitivas 3D (SCNPyramid, SCNSphere) con materiales.
- Animaciones repetidas con SCNAction.
- Construcción de patrones visuales mediante funciones matemáticas.

----------------------------------------------------
2. Estructura de Archivos
----------------------------------------------------

/AppDelegate.swift  
    Implementación estándar del ciclo de vida de la aplicación (UIApplicationDelegate).

/GameViewController.swift  
    Controlador principal que configura la escena SceneKit:
    - Crea un SCNScene programáticamente.
    - Añade cámara (SCNCamera) y luces (SCNLight) de tipo omni y ambient.
    - Configura el SCNView para mostrar la escena.
    - Llama a createGrid(scene:function:) para construir una cuadrícula de figuras 3D animadas.
    - Incluye addBouncingBall(scene:) como ejemplo de una esfera con rebote.
    - Define funciones matemáticas para controlar el movimiento:
        • sinFunction(x:z:)
        • squareFunction(x:z:)
    - Oculta la barra de estado.

/PrimitivesScene.swift  
    Clase base heredada de SCNScene. Actualmente funciona como contenedor vacío o punto de expansión para una escena personalizada.

/Assets / Recursos SceneKit  
    El proyecto no depende de assets obligatorios para funcionar, ya que las figuras se crean programáticamente. Si existen texturas o recursos adicionales, se usan como complemento.

----------------------------------------------------
3. Funcionalidad Clave
----------------------------------------------------
• Escena 3D programática  
  - Se crea una SCNScene desde código sin depender de un archivo SceneKit externo.

• Cámara y luces 
  - La escena incluye una cámara con posición fija y dos fuentes de luz: una omni y una ambiental.

• Cuadrícula animada
  - createGrid(scene:function:) construye una cuadrícula de figuras 3D (SCNPyramid) distribuidas en el espacio.
  - Cada figura se anima verticalmente con SCNAction.moveBy y SCNAction.repeatForever.

• Coloración por secciones 
  - Las pirámides cambian de color según su posición en la cuadrícula, generando un patrón visual con verde, blanco y rojo.

• Funciones matemáticas para movimiento**  
  - sinFunction(x:z:) define una superficie ondulada basada en seno y coseno.
  - squareFunction(x:z:) ofrece una alternativa simple basada en cuadrado de coordenadas.

• Ejemplo adicional de animación
  - addBouncingBall(scene:) crea una esfera con movimiento de rebote continuo.

----------------------------------------------------
4. Recursos / Assets necesarios
----------------------------------------------------
No se requieren assets obligatorios para la escena principal, ya que las figuras se generan por código.  
En caso de usar recursos adicionales, se recomienda incluir:
- Texturas para materiales.
- Escenas SceneKit exportadas si se desea ampliar el proyecto.
- Archivos .scn o .dae opcionales para elementos 3D extra.

----------------------------------------------------
5. Requerimientos
----------------------------------------------------
• iOS 13 o superior.  
• Xcode con soporte para Swift 5+.  
• Framework: SceneKit.  
• Storyboard o configuración de GameViewController con SCNView como vista principal.  
• No requiere permisos especiales.

----------------------------------------------------
