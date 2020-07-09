//
//  MainScene.swift
//  FlappyClone
//
//  Created by Jefferson Santiago on 7/8/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import Foundation
import SceneKit

class MainScene: SCNScene {
    var cameraNode: SCNNode!
    // 'Bird' object
    var bird: Bird!
    // Pipe Object
    var pipe: [Pipe]!
    let maxPipes = 5
    
    let CategoryPipe = 4
    
    
    override init() {
        super.init()
        
        bird = Bird()
        setupCamera()
        setupObjects()
    }
    
    func setupCamera() {
        // Create empty node
       cameraNode = SCNNode()
       
       // Assign camera with a new SCNCamera
       cameraNode.camera = SCNCamera()
       
       // Assign its position in the scene
       cameraNode.position = SCNVector3(x: 0, y: 2, z: 5)
       
       // Add camera node to child of scene root node
       self.rootNode.addChildNode(cameraNode)
    }
    
    func setupObjects() {
        pipe = []
        for i in 1...maxPipes{
            let dist = i*(-10)
            let randomHeight = Int.random(in: 0..<10)
            pipe.append(Pipe(x: 0, y: 5 + CGFloat(randomHeight), z: CGFloat(dist)))
            pipe.append(Pipe(x: 0, y: 15 + CGFloat(randomHeight), z: CGFloat(dist)))
            
        }
        
        self.rootNode.addChildNode(bird.birdNode!)
        
        pipe.forEach(){
            self.rootNode.addChildNode($0.pipeNode!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
