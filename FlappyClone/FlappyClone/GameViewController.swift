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
    var mainScene: Main!
    
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
        //setupCamera()
        // setupObjects()
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
        
        mainScene = Main()
        
        sceneView.delegate = self
        sceneView.scene = mainScene.mainScene
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.numberOfTapsRequired = 1
        
        tapRecognizer.addTarget(self, action: #selector(GameViewController.sceneViewTapped(recognizer:)))
        sceneView.addGestureRecognizer(tapRecognizer)
        
        
        // Adds a Overlay to the scene, this uses SpriteKit
        sceneView.overlaySKScene = Overlay(size: sceneView.frame.size)
    }
    
    @objc func sceneViewTapped (recognizer:UITapGestureRecognizer) {
        
        //this is used typically, for now tapping can be anywhere and all it does is bounce the bird
        
        
        //        let location = recognizer.location(in: sceneView)
        //        let hitResults = sceneView.hitTest(location, options: nil)
        //
        //        if(hitResults.count > 0){
        //            let result = hitResults.first
        //            if let node = result?.node{
        //                if node.name == "bird"{
        //                    bird.birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 1.5, z: 0), asImpulse: true)
        //                }
        //            }
        //        }
        
        
        mainScene.bird.jump() //bird jump hehe
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
        mainScene.updateCamera()
        mainScene.checkPass()
        
    }
    
}
