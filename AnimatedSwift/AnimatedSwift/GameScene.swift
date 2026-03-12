//
//  GameScene.swift
//  AnimatedSwift
//
//  Created by Emiliano Cepeda on 29/11/24.
//
import SpriteKit

class GameScene: SKScene {
    
    private var pokemonNodes: [SKSpriteNode] = [] // Lista para guardar todos los Pokémon
    private var pokemonWalkingFrames: [[SKTexture]] = [] // Lista para guardar las animaciones de cada Pokémon
    private var inactivityTimer: Timer? // Temporizador para detectar inactividad
    
    override func didMove(to view: SKView) {
        drawBackground() // Dibujar fondo
        buildPokemon(named: "Hooh", at: CGPoint(x: frame.midX, y: frame.height * 0.3))
        buildPokemon(named: "Articuno", at: CGPoint(x: frame.midX - 100, y: frame.height * 0.4))
        startInactivityTimer() // Inicia el temporizador al inicio
    }
    
    // MARK: - Background Drawing
    func drawBackground() {
        let ground = SKShapeNode(rect: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height * 0.2))
        ground.fillColor = .green
        ground.strokeColor = .clear
        addChild(ground)
        
        let sky = SKShapeNode(rect: CGRect(x: frame.minX, y: ground.frame.maxY, width: frame.width, height: frame.height * 0.8))
        sky.fillColor = .blue
        sky.strokeColor = .clear
        addChild(sky)
        
        let cloud1 = createCloud(at: CGPoint(x: frame.midX - 200, y: frame.height * 0.8))
        let cloud2 = createCloud(at: CGPoint(x: frame.midX + 150, y: frame.height * 0.7))
        let cloud3 = createCloud(at: CGPoint(x: frame.midX - 580, y: frame.height * 0.4))
        let cloud4 = createCloud(at: CGPoint(x: frame.midX + 400, y: frame.height * 0.5))
        addChild(cloud1)
        addChild(cloud2)
        addChild(cloud3)
        addChild(cloud4)
    }
    
    func createCloud(at position: CGPoint) -> SKShapeNode {
        let cloud = SKShapeNode()
        let circle1 = SKShapeNode(circleOfRadius: 30)
        let circle2 = SKShapeNode(circleOfRadius: 40)
        let circle3 = SKShapeNode(circleOfRadius: 30)
        
        circle1.position = CGPoint(x: -35, y: 0)
        circle2.position = CGPoint(x: 0, y: 15)
        circle3.position = CGPoint(x: 35, y: 0)
        
        for circle in [circle1, circle2, circle3] {
            circle.fillColor = .white
            circle.strokeColor = .clear
            cloud.addChild(circle)
        }
        
        cloud.position = position
        return cloud
    }
    
    // MARK: - Pokémon Setup
    func buildPokemon(named name: String, at position: CGPoint) {
        let animatedAtlas = SKTextureAtlas(named: name)
        var walkFrames: [SKTexture] = []
        
        let numImages = animatedAtlas.textureNames.count
        for i in 1...numImages {
            let textureName = "\(name)\(i)"
            walkFrames.append(animatedAtlas.textureNamed(textureName))
        }
        
        let firstFrameTexture = walkFrames[0]
        let pokemon = SKSpriteNode(texture: firstFrameTexture)
        pokemon.position = position
        addChild(pokemon)
        
        // Guardar nodo y animaciones
        pokemonNodes.append(pokemon)
        pokemonWalkingFrames.append(walkFrames)
        
        // Iniciar animación
        animatePokemon(pokemon: pokemon, withFrames: walkFrames)
    }
    
    func animatePokemon(pokemon: SKSpriteNode, withFrames frames: [SKTexture]) {
        if pokemon.action(forKey: "walkingAnimation") == nil {
            pokemon.run(SKAction.repeatForever(
                SKAction.animate(with: frames,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true)),
                        withKey: "walkingAnimation")
        }
    }
    
    func movePokemon(_ pokemon: SKSpriteNode, to location: CGPoint) {
        resetInactivityTimer()
        
        let speed = frame.size.width / 5.0
        let moveDifference = CGPoint(x: location.x - pokemon.position.x, y: location.y - pokemon.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        let moveDuration = distanceToMove / speed
        
        pokemon.xScale = moveDifference.x < 0 ? abs(pokemon.xScale) : -abs(pokemon.xScale)
        
        let moveAction = SKAction.move(to: location, duration: TimeInterval(moveDuration))
        pokemon.run(moveAction, withKey: "moving")
    }
    
    // MARK: - Handle touches
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        // Elegir un Pokémon al azar para moverlo
        if let randomPokemon = pokemonNodes.randomElement() {
            movePokemon(randomPokemon, to: location)
        }
    }
    
    // MARK: - Inactivity and Random Movement
    func startInactivityTimer() {
        inactivityTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveRandomPokemon), userInfo: nil, repeats: true)
    }
    
    func resetInactivityTimer() {
        inactivityTimer?.invalidate()
        startInactivityTimer()
    }
    
    @objc func moveRandomPokemon() {
        guard let randomPokemon = pokemonNodes.randomElement() else { return }
        let randomX = CGFloat.random(in: frame.minX...frame.maxX)
        let randomY = CGFloat.random(in: frame.minY...frame.maxY)
        let randomLocation = CGPoint(x: randomX, y: randomY)
        movePokemon(randomPokemon, to: randomLocation)
    }
}
