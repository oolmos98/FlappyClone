//
//  Main.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/9/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import Foundation
import SceneKit

class Main: NSObject {
    
    var cameraNode: SCNNode!
    var mainScene: SCNScene!
    
    var bird: Bird!
    // Pipe Object
    var pipe: [Pipe]!
    let maxPipes = 5
    
    let CategoryPipe = 4
    
    var bound: Float = 0
    
    
    override init() {
        super.init()
        
        bound = ((-10) * Float(maxPipes)) - 10
        
        mainScene = SCNScene(named: "art.scnassets/MainScene.scn")
        mainScene.physicsWorld.contactDelegate = self
        
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
        mainScene.rootNode.addChildNode(cameraNode)
    }
    
    func setupObjects() {
        mainScene.rootNode.addChildNode(bird.birdNode!)
        
        pipe = []
        var dist = -15
        for i in 1...maxPipes{
            dist = i*(-10) + dist
            print(dist)
            let randomHeight = Int.random(in: 0..<10)
            pipe.append(Pipe(x: 0, y: 5 + CGFloat(randomHeight), z: CGFloat(dist), dir: true))
            pipe.append(Pipe(x: 0, y: 15 + CGFloat(randomHeight), z: CGFloat(dist), dir: false))
            
        }
        bound = pipe[pipe.count-1].position.z - 10
        
        
        pipe.forEach(){
            mainScene.rootNode.addChildNode($0.pipeNode!)
        }
        
    }
    
    func randomize(){
        
        var i = 0
        while(i < maxPipes-1){
            let dist = (i*(-10)) - 30
            
            let randomHeight = Int.random(in: 0..<10)
            
            pipe[i].changePosition(x: 0, y: 5 + CGFloat(randomHeight), z: CGFloat(dist))
            pipe[i+1].changePosition(x: 0, y: 15 + CGFloat(randomHeight), z: CGFloat(dist))
            
            i += 2
        }
        
        bound = pipe[pipe.count-1].position.z - 10
        
        
    }
    
    func updateCamera(){
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
        
        if(ballPosition.z < bound){
            bird.birdNode?.position = SCNVector3(0,0,0)
            bird.birdNode?.physicsBody?.clearAllForces()
            randomize()
        }
        if(ballPosition.x > 0.5 || ballPosition.x < -0.5){
            bird.birdNode?.position = SCNVector3(0,ballPosition.y,ballPosition.z)
            bird.birdNode?.physicsBody?.clearAllForces()
            
        }
    }
    
}

extension Main : SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        print("hit")
        var contactNode:SCNNode!
        
        if contact.nodeA.name == "bird" {
            contactNode = contact.nodeB
        }
        else{
            contactNode = contact.nodeA
        }
        
        if contactNode.physicsBody?.categoryBitMask == CategoryPipe {
            bird.birdNode?.position = bird.initLocation
            randomize()
            bird.birdNode?.physicsBody?.resetTransform()
            bird.birdNode?.physicsBody?.clearAllForces()
        }
    }
}
