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
 
 */

import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    var sceneView: SCNView!
    
    var sceneScene: SCNScene!
    
    var cameraNode: SCNNode!
    
    // 'Bird' object
    let bird = Bird()
    
    
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
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
    }
    
    func setupScene() {
        
        sceneScene = SCNScene(named: "art.scnassets/MainScene.scn")
        
        sceneView.scene = sceneScene
        
        sceneView.delegate = self

        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.numberOfTapsRequired = 1
        
        tapRecognizer.addTarget(self, action: #selector(GameViewController.sceneViewTapped(recognizer:)))
        sceneView.addGestureRecognizer(tapRecognizer)
        
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
    
    func setupObjects(){
        sceneScene.rootNode.addChildNode(bird.birdNode!)
        
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
        bird.birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 1.5, z: -0.5), asImpulse: true)

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
        //Referenced https://github.com/brianadvent/HitTheTree/blob/master/HitTheTree/GameViewController.swift
        
       let ball = bird.birdNode!.presentation
       let ballPosition = ball.position
       
       let targetPosition = SCNVector3(x: ballPosition.x, y: ballPosition.y + 2, z:ballPosition.z + 15)
       var cameraPosition = cameraNode.position
       
       let camDamping:Float = 0.3
       
       let xComponent = (cameraPosition.x * (1 - camDamping)) + (targetPosition.x * camDamping)
       let yComponent = (cameraPosition.y * (1 - camDamping)) + (targetPosition.y * camDamping)
       let zComponent = (cameraPosition.z * (1 - camDamping)) + (targetPosition.z * camDamping)
       
       cameraPosition = SCNVector3(x: xComponent, y: yComponent, z: zComponent)

        cameraNode.position = cameraPosition
       // bird.birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 0.2, z: 0), asImpulse: true)
        print(cameraNode.position)
        
    }
}
