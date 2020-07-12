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
    var menuScene: Menu!
    
    var cameraNode: SCNNode!
    
    var user = User()
    
    // 'Bird' object
    var bird: Bird!
    
    var pipe: [Pipe]!
    let maxPipes = 5
    
    let CategoryPipe = 4
    
    var overlayScene: Overlay!
    
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
        
        sceneView.showsStatistics = false
        sceneView.allowsCameraControl = false //False since we are manipulating the camera via ball movements and touches
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    func setupScene() {
        
        mainScene = Main()
        menuScene = Menu()
        
        sceneView.delegate = self
        sceneView.scene = menuScene.menuScene
        
        
        
        prepareSoundEngine(rootNode: mainScene.bird.birdNode!)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.numberOfTapsRequired = 1
        
        tapRecognizer.addTarget(self, action: #selector(GameViewController.sceneViewTapped(recognizer:)))
        tapRecognizer.cancelsTouchesInView = false
        
        sceneView.addGestureRecognizer(tapRecognizer)
        
    }
    func presentGame(){
        
        menuScene.state = .playing
        
        // Adds a Overlay to the scene, this uses SpriteKit
        overlayScene = Overlay(size: sceneView.frame.size)
        sceneView.overlaySKScene = overlayScene
        
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)  //SKTransition.crossFade(withDuration: 1.0)
        sceneView.present(
            mainScene.mainScene,
            with: transition,
            incomingPointOfView: nil,
            completionHandler: nil
        )
    }
    
    
    
    func prepareSoundEngine(rootNode: SCNNode) {
        let sound = SCNAudioSource(named: "Sounds/init.mp3")!
        sound.load()
        let player = SCNAudioPlayer(source: sound)
        
        player.didFinishPlayback = {
            rootNode.removeAudioPlayer(player)
        }
        
        rootNode.addAudioPlayer(player)
    }
    
    
    
    @objc func sceneViewTapped (recognizer:UITapGestureRecognizer) {
        
        //this is used typically, for now tapping can be anywhere and all it does is bounce the bird
        
        if(menuScene.state == .menu){
            let location = recognizer.location(in: sceneView)
            let hitResults = sceneView.hitTest(location, options: nil)
            
            if(hitResults.count > 0){
                let result = hitResults.first
                if let node = result?.node{
                    if node.name == "hud"{
                        presentGame()
                    }
                }
            }
        }
        else{
            if(!mainScene.started){
                mainScene.bird.birdNode?.physicsBody?.isAffectedByGravity = true
                
                mainScene.started = true
            }
            mainScene.bird.jump()
            
        }
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
        
        if(!mainScene.started){
            mainScene.bird.birdNode?.physicsBody?.isAffectedByGravity = false
        }
        if(!mainScene.resetting){
            mainScene.updateCamera()
            mainScene.checkPass()
        }
        
        
        if let overlay = sceneView.overlaySKScene as? Overlay {
            overlay.score = mainScene.score
        }
        
        
        
    }
    
}
