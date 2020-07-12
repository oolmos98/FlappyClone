//
//  Bird.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/6/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import Foundation
import SceneKit



class Bird {
    
    var birdNode:SCNNode?
    
    var scene:SCNScene! = SCNScene(named: "art.scnassets/bird.scn")!
    
    var initLocation: SCNVector3!
    
    // Sound Effects
    var tapSource: SCNAudioSource?
    var collisionSource: SCNAudioSource?

    init() {
        birdNode = scene.rootNode.childNode(withName: "bird", recursively: true)!
        initLocation = birdNode?.position
        
        
        
        tapSource = SCNAudioSource(fileNamed: "Sounds/whoosh.mp3")
        tapSource!.loops = false
        tapSource!.load()
        birdNode!.addAudioPlayer(SCNAudioPlayer(source: tapSource!))
        
        collisionSource = SCNAudioSource(fileNamed: "Sounds/yeet.mp3")
        collisionSource!.loops = false
        collisionSource!.load()
        birdNode!.addAudioPlayer(SCNAudioPlayer(source: collisionSource!))
        
    }
    
    func playTapSound() {
        //guard birdNode!.audioPlayers.count == 0 else { return }
        //
        let playAudio = SCNAction.playAudio(tapSource!, waitForCompletion: false)
        birdNode!.runAction(playAudio)
    }
    
    func playCollisionSound() {
        //guard birdNode!.audioPlayers.count == 0 else { return }
        //
        let playAudio = SCNAction.playAudio(collisionSource!, waitForCompletion: false)
        birdNode!.runAction(playAudio)
    }
    
    func jump(){
        
        if(birdNode!.position.x != 0){
            birdNode!.physicsBody?.applyForce(SCNVector3(x: -birdNode!.position.x, y: 1.7, z: -0.8), asImpulse: true)
            
        }
        else{
            birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 1.5, z: -0.5), asImpulse: true)
        }
        playTapSound()
    }
    
    
    
    func resetBird() {
        //birdNode!.removeAllAudioPlayers()
    }
    
}
