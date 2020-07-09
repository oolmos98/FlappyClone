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
    
    init(){
        birdNode = scene.rootNode.childNode(withName: "ball", recursively: true)!
    }
    
    func jump(){
        if(birdNode!.position.x != 0){
            birdNode!.physicsBody?.applyForce(SCNVector3(x: -birdNode!.position.x, y: 1.5, z: -0.5), asImpulse: true)
        }
        else{
            birdNode!.physicsBody?.applyForce(SCNVector3(x: 0, y: 1.5, z: -0.5), asImpulse: true)
        }
    }
    
}
