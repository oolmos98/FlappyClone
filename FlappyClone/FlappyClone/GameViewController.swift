//
//  GameViewController.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/6/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

/*
 Setting up from
 https://www.raywenderlich.com/1261-scene-kit-tutorial-with-swift-part-1-getting-started
 
 Collision and Camera
 https://github.com/brianadvent/HitTheTree/blob/master/HitTheTree/GameViewController.swift
 
 */

import UIKit
import SceneKit
import SpriteKit

class GameViewController: UIViewController {
    
    var sceneView: SCNView!
    
    var sceneScene: SCNScene!
    
    var cameraNode: SCNNode!
    
    var user = User()
    
    // 'Bird' object
    var bird: Bird!
    
    var pipe: [Pipe]!
    let maxPipes = 5
    
    let CategoryPipe = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        setupCamera()
        setupObjects()
    }
    
    // Handles device rotation
    override var shouldAutorotate: Bool {
        return true
    }
    
    // Hides status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    func setupView(){
        // retrieve the SCNView
        sceneView = (self.view as! SCNView)
        
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = false //False since we are manipulating the camera via ball movements and touches
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    func setupScene() {
        
        sceneScene = SCNScene(named: "art.scnassets/MainScene.scn")
        
        sceneView.delegate = self
        sceneView.scene = MainScene()
        sceneScene.physicsWorld.contactDelegate = self
        
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.numberOfTapsRequired = 1
        
        tapRecognizer.addTarget(self, action: #selector(GameViewController.sceneViewTapped(recognizer:)))
        sceneView.addGestureRecognizer(tapRecognizer)
        
        
        // Adds a Overlay to the scene, this uses SpriteKit
        sceneView.overlaySKScene = Overlay(size: sceneView.frame.size)
    }
    
    func setupCamera() {
        // Create empty node
        cameraNode = SCNNode()
        
        // Assign camera with a new SCNCamera
        cameraNode.camera = SCNCamera()
        
        // Assign its position in the scene
        cameraNode.position = SCNVector3(x: 0, y: 2, z: 5)
        
        // Add camera node to child of scene root node
        sceneScene.rootNode.addChildNode(cameraNode)
    }
    
    // This function organizes the objects in our MainScene by adding
    // them to the MainScene root and positioning.
    func setupObjects(){
        
        
            bird = Bird()
            
            //needed so that once ball is in contact with pipe, physicsWorld func is called
            //bird.birdNode!.physicsBody?.contactTestBitMask = CategoryPipe
            
            pipe = []
            for i in 1...maxPipes{
                let dist = i*(-10)
                pipe.append(Pipe(x: 0, y: 5, z: CGFloat(dist)))
                pipe.append(Pipe(x: 0, y: 15, z: CGFloat(dist)))
                
            }
            
            sceneScene.rootNode.addChildNode(bird.birdNode!)
            
            pipe.forEach(){
                sceneScene.rootNode.addChildNode($0.pipeNode!)
            }
        
    }
    
    @objc func sceneViewTapped (recognizer:UITapGestureRecognizer) {
        //        let location = recognizer.location(in: sceneView)
        //        let hitResults = sceneView.hitTest(location, options: nil)
        //
        //        if(hitResults.count > 0){
        //            let result = hitResults.first
        //            if let node = result?.node{
        //                if node.name == "ball"{
        //                    bird.birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 1.5, z: 0), asImpulse: true)
        //                }
        //            }
        //        }
        
        
        bird.jump()
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}




//Render function. what to render based on sudden changes such as moving the camera if an object moves.
extension GameViewController : SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        
        //Camera follows the ball.
        
            let ball = bird.birdNode!.presentation
            let ballPosition = ball.position
            
            let targetPosition = SCNVector3(x: ballPosition.x, y: ballPosition.y + 4, z:ballPosition.z + 20)
            var cameraPosition = cameraNode.position
            
            let camDamping:Float = 0.3
            
            //Linear Interpolation
            let xComponent = (cameraPosition.x * (1 - camDamping)) + (targetPosition.x * camDamping)
            let yComponent = (cameraPosition.y * (1 - camDamping)) + (targetPosition.y * camDamping)
            let zComponent = (cameraPosition.z * (1 - camDamping)) + (targetPosition.z * camDamping)
            
            cameraPosition = SCNVector3(x: xComponent, y: yComponent, z: zComponent)
            
            cameraNode.position = cameraPosition
            // bird.birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 0.2, z: 0), asImpulse: true)
            //print(cameraNode.position)
            
            //print(ballPosition)
            let bound = ((-10) * Float(maxPipes)) - 10
            if(ballPosition.z < bound){
                //print("called .z")
                bird.birdNode?.position = SCNVector3(0,0,0)
                bird.birdNode?.physicsBody?.clearAllForces()
                
            }
            if(ballPosition.x > 0.5 || ballPosition.x < -0.5){
                //print("called .x")
                bird.birdNode?.position = SCNVector3(0,ballPosition.y,ballPosition.z)
                bird.birdNode?.physicsBody?.clearAllForces()
                
            }
        
        
    }
    
}

//Collision?
extension GameViewController : SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        var contactNode:SCNNode!
        
        print(contact.nodeA.name ?? "None")
        
        if contact.nodeA.name == "ball" {
            contactNode = contact.nodeB
        }
        else{
            contactNode = contact.nodeA
        }
        
        if contactNode.physicsBody?.categoryBitMask == CategoryPipe {
            bird.birdNode?.position = SCNVector3(0,0,0)
            bird.birdNode?.physicsBody?.resetTransform()
            bird.birdNode?.physicsBody?.clearAllForces()
            
            
        }
        
        
    }
}
