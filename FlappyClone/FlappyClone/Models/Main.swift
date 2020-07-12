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
    let maxPipes = 10
    
    let CategoryPipe = 4
    
    //far enough passed = reset basically.
    var bound: Float = 0
    
    //No need to recaculate depth when resetting
    var depth: [Int] = []
    let maxHeightRange = 10
    let depthOffset = -15
    
    var currentIndex = 0
    
    var failed_passed = false
    
    var score = 0
    
    var resetting:Bool = false
    
    var started:Bool = false
    
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
        
        cameraNode.eulerAngles.y = Float.pi/10
        // Add camera node to child of scene root node
        mainScene.rootNode.addChildNode(cameraNode)
    }
    
    func setupObjects() {
        mainScene.rootNode.addChildNode(bird.birdNode!)
        
        pipe = []
        var dist = 0
        for i in 0..<maxPipes{
            dist = i*(depthOffset) - 10
            
            depth.append(dist)
            let randomHeight = Int.random(in: 0..<maxHeightRange)
            pipe.append(Pipe(x: 0, y: 5 + CGFloat(randomHeight), z: CGFloat(dist), dir: true))
            pipe.append(Pipe(x: 0, y: 15 + CGFloat(randomHeight), z: CGFloat(dist), dir: false))
            
        }
        bound = pipe[pipe.count-1].position.z - 10
        
        
        pipe.forEach(){
            mainScene.rootNode.addChildNode($0.pipeNode!)
        }
        
        
    }
    
    
    func randomize(){
        
        self.hidePipe(yah: true)
        
        var i = 0
        while(i < maxPipes * 2){
            // Reusing same depth, no need to recalculate
            let index:Int = i/2
            let dist = depth[index]
            
            // random height must be calculated
            let randomHeight = Int.random(in: 0..<maxHeightRange)
            
            pipe[i].changePosition(x: 0, y: 5 + CGFloat(randomHeight), z: CGFloat(dist))
            pipe[i+1].changePosition(x: 0, y: 15 + CGFloat(randomHeight), z: CGFloat(dist))
            
            i += 2
        }
        
        bound = pipe[pipe.count-1].pipeNode!.position.z - 10
        self.hidePipe(yah: false)
        
        
    }
    
    func animate() -> SCNAction{
        return SCNAction.rotate(by: CGFloat(2.0*Double.pi), around: bird.birdNode!.position, duration: 1)
    }
    
    func checkPass(){
        
        if(!resetting){
            if(currentIndex < pipe.count){
                if((pipe[currentIndex].pipeNode?.presentation.position.z)! > (bird.birdNode?.presentation.position.z)!){
                    pipe[currentIndex].pipeNode?.isHidden = true
                    pipe[currentIndex+1].pipeNode?.isHidden = true
                    
                    randomizePipe(i: currentIndex, j: currentIndex+1)
                    score += 1
                    currentIndex += 2
                }
            }
            else{
                currentIndex = 0
            }
        }
    }
    
    func randomizePipe(i: Int, j: Int){
        let prevPipeIndex = (i == 0) ? ((maxPipes*2) - 1) : (i - 1)
        let dist = pipe[prevPipeIndex].pipeNode!.position.z + Float(depthOffset)
        
        let randomHeight = Int.random(in: 0..<maxHeightRange)
        
        pipe[i].changePosition(x: 0, y: 5 + CGFloat(randomHeight), z: CGFloat(dist))
        pipe[j].changePosition(x: 0, y: 15 + CGFloat(randomHeight), z: CGFloat(dist))
        
        pipe[i].pipeNode?.isHidden = false
        pipe[j].pipeNode?.isHidden = false
    }
    
    func updateCamera(){
        let ball = bird.birdNode!.presentation
        let ballPosition = ball.position
        
        let targetPosition = SCNVector3(x: ballPosition.x + 10, y: ballPosition.y + 4, z:ballPosition.z + 20)
        var cameraPosition = cameraNode.position
        
        let camDamping:Float = 0.3
        
        //Linear Interpolation
        let xComponent = (cameraPosition.x * (1 - camDamping)) + (targetPosition.x * camDamping)
        let yComponent = (cameraPosition.y * (1 - camDamping)) + (targetPosition.y * camDamping)
        let zComponent = (cameraPosition.z * (1 - camDamping)) + (targetPosition.z * camDamping)
        
        cameraPosition = SCNVector3(x: xComponent, y: yComponent, z: zComponent)
        
        cameraNode.position = cameraPosition

        
        if(ballPosition.x > 0.5 || ballPosition.x < -0.5){
            bird.birdNode?.position = SCNVector3(0,ballPosition.y,ballPosition.z)
            bird.birdNode?.physicsBody?.clearAllForces()
            
        }
    }
    func reset(type: Bool) {
        self.resetting = true
        self.currentIndex = 0
        self.score = type ? 0 : self.score
        self.bird.birdNode?.physicsBody?.resetTransform()
        self.bird.birdNode?.physicsBody?.clearAllForces()
        self.bird.resetBird() 
        self.randomize()
        self.bird.birdNode?.position = self.bird.initLocation
        
        self.resetting = false
        self.hidePipe(yah: false)
        
        self.started = false
    }
    
    func hidePipe(yah: Bool) {
        pipe.forEach(){
            $0.pipeNode?.isHidden = yah
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
            bird.playCollisionSound()
            bird.birdNode?.runAction(animate() , completionHandler:{
                self.reset(type: true)
            })
        }
    }
}
