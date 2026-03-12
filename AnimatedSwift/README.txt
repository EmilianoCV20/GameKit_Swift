====================================================
AnimatedSwift – Swift (SpriteKit)
====================================================

Autor: Emiliano Cepeda
Creado: 29/11/24  
Plataforma: iOS  
Lenguaje: Swift (SpriteKit)  

----------------------------------------------------
1. Overview
----------------------------------------------------
AnimatedSwift es un proyecto de juego/demo para iOS construido con SpriteKit cuyo objetivo es practicar
animaciones de sprites, manejo de atlas de texturas, interacción por toque y movimientos automáticos mediante 
temporizadores. La escena incluye múltiples nodos tipo `SKSpriteNode` (pokémon en este ejemplo) que están 
animados a partir de `SKTextureAtlas`, se mueven hacia puntos tocados por el usuario y realizan movimientos 
aleatorios cuando hay inactividad.

Características principales:
- Carga y animación de sprites desde `SKTextureAtlas`.  
- Movimiento suave de sprites hacia posiciones objetivo con cálculo de duración dependiente de la distancia.  
- Detección de toques en pantalla para mover sprites seleccionados aleatoriamente.  
- Temporizador de inactividad que dispara movimientos automáticos aleatorios.  
- Fondo compuesto (cielo, terreno, nubes) renderizado con nodos de forma (`SKShapeNode`).  
- Presentación de la escena en `SKView` mediante `GameViewController`.

----------------------------------------------------
2. Estructura de Archivos
----------------------------------------------------

/AppDelegate.swift  
    Implementación estándar del ciclo de vida de la aplicación (UIApplicationDelegate).  

/GameViewController.swift  
    - Configura el `SKView` y presenta la instancia de `GameScene`.  
    - Ajustes recomendados: `scene.scaleMode = .resizeFill`, `view.ignoresSiblingOrder = true`.  
    - Opcional: activar `showsFPS` y `showsNodeCount` para depuración.

/GameScene.swift  
    Clase principal de la lógica del juego:
    - `didMove(to:)` — inicializa la escena (fondo, sprites y temporizador).  
    - Manejo de textura/animación:
        • Carga de `SKTextureAtlas(named:)`.  
        • Construcción de arrays de `SKTexture` para animación por frame.  
        • `SKAction.animate` dentro de `SKAction.repeatForever`.  
    - Movimiento:
        • `movePokemon(_:to:)` calcula distancia y duración según velocidad relativa a pantalla.  
        • Ajusta la escala x para orientar el sprite (izquierda/derecha).  
    - Entrada táctil:
        • `touchesEnded(_:with:)` captura posición de toque y mueve un sprite aleatorio.  
    - Inactividad:
        • Temporizador (`Timer`) que lanza `moveRandomPokemon` periódicamente.  
        • `resetInactivityTimer()` para reiniciar temporizador tras interacción.

/Assets (Texture Atlases)  
    - Carpetas/Atlases con nombres que coincidan con los usados en `buildPokemon(named:at:)` (por ejemplo: "Hooh", "Articuno"). Cada atlas debe contener las texturas `Hooh1, Hooh2, ...` etc.  
    - Otros recursos gráficos: imágenes de fondo o formas (si corresponde).

----------------------------------------------------
3. Funcionalidad Clave
----------------------------------------------------
• Animaciones por frame: cada personaje usa un `SKTextureAtlas` que contiene las frames de su animación; 
éstas se reproducen indefinidamente.  
• Movimiento físico suave: la duración del movimiento se calcula a partir de la distancia y una velocidad 
relativa al ancho del marco, resultando en movimientos coherentes independientemente del tamaño de pantalla.  
• Respuesta al usuario: al tocar la escena, se selecciona un sprite al azar y se le ordena moverse hacia la 
posición tocada.  
• Movimiento autónomo: cuando el usuario no interactúa, un temporizador mueve sprites a posiciones aleatorias 
para dar sensación de vida en la escena.  
• Gestión de orientación: el sprite refleja su escala horizontal para mirar hacia la dirección del movimiento.

----------------------------------------------------
4. Recursos / Assets necesarios
----------------------------------------------------
- Texture atlases nombrados (ej.: `Hooh.atlas`, `Articuno.atlas`) con las imágenes numeradas de la animación 
(Hooh1, Hooh2, ...).  
- Opcional: imágenes o assets para fondo, nubes o elementos decorativos.  
- Configurar en el paquete: asegurarse de que los `.atlas` estén incluidos en el target de la app.

----------------------------------------------------
5. Requerimientos
----------------------------------------------------
• iOS 11+ (SpriteKit soporta versiones antiguas, pero se recomienda iOS 13+ para compatibilidad con modernas 
APIs).  
• Xcode 11+ con Swift 5+.  
• Habilitar recursos de atlas en el proyecto (agregar los folders `.atlas` o assets adecuados).  
• Para probar en dispositivo: habilitar la ejecución en el equipo de desarrollo y firmar el provisioning.

----------------------------------------------------
