//
//  Bird.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/6/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import Foundation
import SceneKit


class BirdNode: SCNNode {

    
    override init() {
        super.init()

        let geo = SCNSphere(radius: 2.0)
        geo.firstMaterial?.diffuse.contents = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1 )
        
        
        //self.geometry becasue this class conforms to SCNNode
        self.geometry = geo
        
        //let geoNode = SCNNode(geometry: geometry)
        self.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
       // scnScene.rootNode.addChildNode(geoNode)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
