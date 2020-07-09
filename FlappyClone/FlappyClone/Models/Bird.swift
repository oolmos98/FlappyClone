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
    
    init(){
        birdNode = scene.rootNode.childNode(withName: "bird", recursively: true)!
        initLocation = birdNode?.position
    }
    
    func jump(){
        let x = birdNode!.presentation.position.x
        let y = birdNode!.presentation.position.y
        let z = birdNode!.presentation.position.z
        
        
        if(birdNode!.position.x != 0){
            birdNode!.physicsBody?.applyForce(SCNVector3(x: -birdNode!.position.x, y: 1.5, z: -0.5), asImpulse: true)
            
        }
        else{
            birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 1.5, z: -0.5), asImpulse: true)
            
        }
    }
    
}
