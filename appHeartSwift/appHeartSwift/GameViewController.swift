//
//  GameViewController.swift
//  appHeartSwift
//
//  Created by Emiliano Cepeda on 30/11/24.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crear una nueva escena
        let scene = SCNScene()
        
        // Crear y añadir una cámara a la escena
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scene.rootNode.addChildNode(cameraNode)
        
        // Crear y añadir una luz a la escena
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 20, z: 20)
        scene.rootNode.addChildNode(lightNode)
        
        // Añadir una luz ambiental a la escena
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Crear figuras animadas
        //createGrid(scene: scene, function: squareFunction)
        // Añadir la pelota al centro
        //addBouncingBall(scene: scene)
        
        // Crear figuras animadas 2
        createGrid(scene: scene, function: sinFunction)
        
        // Configurar el SCNView
        let scnView = self.view as! SCNView
        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.black
    }
    
    //Crea el grid CON CAPSULAS
    /*
    func createGrid(scene: SCNScene, function: (Float, Float) -> Float) {
        let gridSize = 30
        let capsuleRadius: CGFloat = 1.0 / CGFloat(gridSize - 1)
        let capsuleHeight: CGFloat = capsuleRadius * 4.0
        var z: Float = Float(-gridSize + 1) * Float(capsuleRadius)
        
        for _ in 0..<gridSize {
            var x: Float = Float(-gridSize + 1) * Float(capsuleRadius)
            for j in 0..<gridSize {
                let capsule = SCNCapsule(capRadius: capsuleRadius, height: capsuleHeight)
                //let hue = CGFloat(abs(x * z))
                //let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
                //capsule.firstMaterial?.diffuse.contents = color
                
                // Alternar los colores según la posición
                let color: UIColor
                if j <= 10 {
                    color = UIColor.green // Verde
                } else if j <= 20 {
                    color = UIColor.white // Blanco
                } else {
                    color = UIColor.red // Rojo
                }
                capsule.firstMaterial?.diffuse.contents = color
                
                let capsuleNode = SCNNode(geometry: capsule)
                capsuleNode.position = SCNVector3(x, 0, z)
                scene.rootNode.addChildNode(capsuleNode)
                
                let y = CGFloat(function(x, z))
                let moveUp = SCNAction.moveBy(x: 0, y: y, z: 0, duration: 1.0)
                let moveDown = SCNAction.moveBy(x: 0, y: -y, z: 0, duration: 1.0)
                let sequence = SCNAction.sequence([moveUp, moveDown])
                let repeatedSequence = SCNAction.repeatForever(sequence)
                capsuleNode.runAction(repeatedSequence)
                
                x += 2.0 * Float(capsuleRadius)
            }
            z += 2.0 * Float(capsuleRadius)
        }
    }*/
    
    //GRID CON PIRAMIDES
    func createGrid(scene: SCNScene, function: (Float, Float) -> Float) {
        let gridSize = 30
        let capsuleRadius: CGFloat = 1.0 / CGFloat(gridSize - 1)
        let capsuleHeight: CGFloat = capsuleRadius * 4.0
        var z: Float = Float(-gridSize + 1) * Float(capsuleRadius)
        
        for _ in 0..<gridSize {
            var x: Float = Float(-gridSize + 1) * Float(capsuleRadius)
            for j in 0..<gridSize {
                // Crear una pirámide
                let pyramid = SCNPyramid(
                    width: capsuleRadius,
                    height: capsuleHeight,
                    length: capsuleRadius
                )
                
                // Alternar los colores según la posición
                let color: UIColor
                if j <= 10 {
                    //color = UIColor.green // Verde
                    color = UIColor(red: 45/255, green: 87/255, blue: 44/255, alpha: 1)
                } else if j <= 20 {
                    color = UIColor.white // Blanco
                } else {
                    color = UIColor.red // Rojo
                }
                pyramid.firstMaterial?.diffuse.contents = color
                
                // Crear nodo de la pirámide
                let pyramidNode = SCNNode(geometry: pyramid)
                pyramidNode.position = SCNVector3(x, 0, z)
                scene.rootNode.addChildNode(pyramidNode)
                
                // Animación
                let y = CGFloat(function(x, z))
                let moveUp = SCNAction.moveBy(x: 0, y: y, z: 0, duration: 1.0)
                let moveDown = SCNAction.moveBy(x: 0, y: -y, z: 0, duration: 1.0)
                let sequence = SCNAction.sequence([moveUp, moveDown])
                let repeatedSequence = SCNAction.repeatForever(sequence)
                pyramidNode.runAction(repeatedSequence)
                
                x += 2.0 * Float(capsuleRadius)
            }
            z += 2.0 * Float(capsuleRadius)
        }
    }

    //Pelota que rebota
    func addBouncingBall(scene: SCNScene) {
        // Crear la esfera
        let ballRadius: CGFloat = 0.5
        let sphere = SCNSphere(radius: ballRadius)
        sphere.firstMaterial?.diffuse.contents = UIColor.red
        
        let ballNode = SCNNode(geometry: sphere)
        ballNode.position = SCNVector3(0, 2.5, 0) // Posición inicial
        scene.rootNode.addChildNode(ballNode)
        
        // Animación de rebote
        let bounceDown = SCNAction.moveBy(x: 0, y: -2, z: 0, duration: 1)
        let bounceUp = SCNAction.moveBy(x: 0, y: 2, z: 0, duration: 1)
        let bounceSequence = SCNAction.sequence([bounceDown, bounceUp])
        let repeatBounce = SCNAction.repeatForever(bounceSequence)
        ballNode.runAction(repeatBounce)
    }
    
    func sinFunction(x: Float, z: Float) -> Float {
        return 0.2 * sin(5 * x + 3 * z) + 0.1 * cos(5 * x + 10 * z + 0.6) + 0.05 * cos(x * x * z)
    }
    
    func squareFunction(x: Float, z: Float) -> Float {
        return x * x + z * z
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

