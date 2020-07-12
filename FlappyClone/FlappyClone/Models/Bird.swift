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
    var source: SCNAudioSource?
    
    init() {
        birdNode = scene.rootNode.childNode(withName: "bird", recursively: true)!
        initLocation = birdNode?.position
        
        
        
        source = SCNAudioSource(fileNamed: "Sounds/yeet.mp3")
        source!.loops = false
        source!.load()
        
        birdNode!.addAudioPlayer(SCNAudioPlayer(source: source!))
    }
    
    func playSound() {
        //guard birdNode!.audioPlayers.count == 0 else { return }
        //
        let playAudio = SCNAction.playAudio(source!, waitForCompletion: false)
        birdNode!.runAction(playAudio)
    }
    
    func jump(){
        
        if(birdNode!.position.x != 0){
            birdNode!.physicsBody?.applyForce(SCNVector3(x: -birdNode!.position.x, y: 1.5, z: -0.5), asImpulse: true)
            
        }
        else{
            birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 1.5, z: -0.5), asImpulse: true)
        }
        playSound()
    }
    
    func resetBird() {
        //birdNode!.removeAllAudioPlayers()
    }
    
}
