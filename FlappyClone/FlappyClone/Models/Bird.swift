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
    
    var scene:SCNScene! = SCNScene(named: "art.scnassets/Ball.scn")!
    
    init(){
        
        birdNode = scene.rootNode.childNode(withName: "ball", recursively: true)!
    }
    
}
