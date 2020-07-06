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
    
    var scnView: SCNView!
    
    var scnScene: SCNScene!
    
    var cameraNode: SCNNode!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        setupCamera()
        setupObjects()
    }
    
    
    
    
    //Handles device rotation
    override var shouldAutorotate: Bool {
        return true
    }
    
    //Hides status bar
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
        scnView = (self.view as! SCNView)
        
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true

        
        
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
    }
    
    func setupCamera() {
        // Create empty node
        cameraNode = SCNNode()
        
        // Assign camera with a new SCNCamera
        cameraNode.camera = SCNCamera()
        
        // Assign its position in the scene
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        // Add camera node to child of scene root node
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func setupObjects(){
        var geometry: SCNGeometry
        
        geometry = SCNSphere(radius: 2.0)
        geometry.firstMaterial?.diffuse.contents = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1 )
    
        let geoNode = SCNNode(geometry: geometry)
        
        //Adds physics properties such as gravity on init. Physics engine is applied to this object for type .dynamic
        geoNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        scnScene.rootNode.addChildNode(geoNode)

    }
    
}
