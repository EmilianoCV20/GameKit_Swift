====================================================
appCoreGraphics – Swift (UIKit)
====================================================

Autor: Emiliano Cepeda  
Creado: 02/12/24  
Plataforma: iOS  
Lenguaje: Swift (UIKit)  

----------------------------------------------------
1. Overview
----------------------------------------------------
appCoreGraphics es una aplicación para iOS desarrollada en Swift (UIKit) que utiliza Core Graphics para dibujar una escena ilustrada de forma dinámica y reactiva al estado emocional seleccionado. La vista principal representa un paisaje con cielo degradado, montañas, césped y flores dibujadas manualmente, mientras que una imagen del personaje y un texto de estado se actualizan según el nivel de ánimo elegido.

La app sirve como práctica de:
- Dibujo personalizado con CGContext, CGPath, CGGradient y CGLayer.
- Creación de una vista custom (SkyView) que se redibuja con setNeedsDisplay().
- Uso de un enum (RageLevel) para controlar la apariencia de toda la escena.
- Integración de UIImageView, UILabel y UIButton para interactuar con la vista.
- Aplicación de colores, gradientes y trazos en tiempo de ejecución.

----------------------------------------------------
2. Estructura de Archivos
----------------------------------------------------

/AppDelegate.swift  
    Implementación estándar del ciclo de vida de la aplicación (UIApplicationDelegate).

/GameViewController.swift 
    Contiene una clase auxiliar ContainerScrollView que actúa como contenedor de un UIScrollView. En el proyecto mostrado no concentra la lógica visual principal, pero forma parte de la base de la app.

/GameScene.swift  
    Archivo donde se define la lógica visual y de estado:
    - enum RageLevel: Int, CaseIterable  
        • Estados disponibles: happy, somewhatHappy, neutral, somewhatAngry, angry.  
        • Propiedades calculadas:
            - image — retorna la imagen del personaje correspondiente al estado.  
            - tweet — retorna un texto descriptivo asociado al estado.
    - class SkyView: UIVie
        • Vista personalizada encargada de dibujar toda la escena con Core Graphics.  
        • Propiedad interna `rageLevel` y método setRageLevel(_:) para actualizar el estado y redibujar.  
        • Métodos de dibujo:
            - draw(_:) — punto de entrada de dibujo.  
            - drawSky(in:rageLevel:context:colorSpace:) — cielo con gradientes según el estado.  
            - drawMountains(in:in:with:) — montañas de fondo y primer plano con variaciones aleatorias.  
            - drawGrass(in:in:with:) — césped con degradados según el estado.  
            - drawPetal(in:inDegrees:inContext:) — pétalos de flores mediante elipses transformadas.  
            - drawFlowers(in:rageLevel:in:with:) — flores y clones distribuidos en la escena.  
        • Función auxiliar:
            - degreesToRadians(_:) — conversión de grados a radianes.

/ViewController.swift  
    Controlador principal de la interfaz:
    - Propiedades UI:
        • skyView: SkyView — vista custom que dibuja el paisaje.  
        • characterImageView: UIImageView — muestra la imagen del personaje según el estado.  
        • stateLabel: UILabel — muestra el estado actual.  
        • currentRageLevel: RageLevel — estado actual de la escena.
    - setupUI()`:
        • Configura SkyView, UIImageView, UILabel y un botón de cambio de estado.  
        • Usa Auto Layout para posicionar elementos.
    - changeStateTapped():
        • Avanza al siguiente estado de ánimo o vuelve a .happy al llegar al final.
    - updateScene(for:):
        • Actualiza SkyView, la imagen del personaje y el texto del estado.

----------------------------------------------------
3. Funcionalidad Clave
----------------------------------------------------
• Dibujo personalizado con Core Graphics:
  - La escena se compone mediante CGContext, CGGradient, CGPath, CGLayer y transformaciones geométricas.  
  - Se dibujan cielo, montañas, césped y flores de forma programática.

• Estados visuales dinámicos:  
  - El enum RageLevel controla los colores del cielo, montañas, césped y flores, generando una escena distinta por estado.  
  - También define una imagen del personaje y un texto tipo “tweet” para cada estado.

• Vista custom redibujable:  
  - SkyView hereda de UIView y se actualiza al cambiar el estado con setNeedsDisplay().  
  - Esto permite que toda la ilustración cambie de forma dinámica.

• Interacción con botón:  
  - Un botón “Cambiar Estado” permite recorrer los diferentes niveles de ánimo y actualizar la escena.

• Uso de capas y repetición visual:  
  - drawFlowers genera una flor base y la clona varias veces con transformaciones, creando un patrón visual más rico.

----------------------------------------------------
4. Recursos / Assets necesarios
----------------------------------------------------
Asegúrate de incluir en el Asset Catalog las siguientes imágenes exactas usadas por RageLevel.image:
- happy
- somewhat_happy
- neutral
- somewhat_angry
- angry

Además, el proyecto requiere:
- Una imagen o asset visual del personaje para cada estado.
- Storyboard o configuración de la vista principal con los componentes necesarios si no se crean por código.

(Recomendado) verificar que los assets estén bien nombrados para evitar fallos al cargar imágenes con UIImage(named:).

----------------------------------------------------
5. Requerimientos
----------------------------------------------------
• iOS 13 o superior.  
• Xcode con soporte para Swift 5+.  
• Framework principal: UIKit.  
• Storyboard o configuración por código para `ViewController.swift`.  
• Asset Catalog con las imágenes indicadas en la sección de recursos.  
• No requiere permisos especiales.

----------------------------------------------------

