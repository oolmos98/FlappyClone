//
//  Pipe.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/7/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import Foundation
import SceneKit



class Pipe {
    
    var pipeNode:SCNNode?
    
    var scene:SCNScene! = SCNScene(named: "art.scnassets/Pipe.scn")!
    
    var position: SCNVector3!
    
    init(){
        pipeNode = scene.rootNode.childNode(withName: "pipe", recursively: true)!
        position = pipeNode!.position
    }
    init(x: CGFloat, y: CGFloat, z: CGFloat){
        pipeNode = scene.rootNode.childNode(withName: "pipe", recursively: true)!
        
        let pos = SCNVector3(x, y, z)
        pipeNode!.position = pos
        position = pos

    }
    
    
    //Changing radius messes with physics body center of impact
    
//    init(x: CGFloat, y: CGFloat, z: CGFloat, r: CGFloat){
//        pipeNode = scene.rootNode.childNode(withName: "pipe", recursively: true)!
//
//        let pos = SCNVector3(x, y, z)
//        pipeNode!.position = pos
//
//        (pipeNode!.geometry as! SCNCylinder).radius = r
//    }
    
}
