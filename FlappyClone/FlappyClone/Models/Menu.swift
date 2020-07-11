//
//  Menu.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/11/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import SceneKit
import SpriteKit


class Menu{
    
    var cameraNode: SCNNode!
    var menuScene: SCNScene!
    var menuMaterial: SCNMaterial!
    
    var state: State!
    var menuSK: MenuSK!
    
    
    
    init() {
        menuScene = SCNScene(named: "art.scnassets/Menu.scn")
        state = State.menu
        setupMenu()
    }
    
    enum State {
        case menu
        case playing
    }
    
    func setupMenu() {
        print("to be continued")
        menuSK = MenuSK(size: CGSize(width: 300, height: 200))
    }
    
}

//Refereneces
//Build a Menu.scn

//add a backdrop and a placeholder for the Spritekit contents

//Make the spritekit content.. MenuSK.swift

//add the skScene to a SCNMaterial property variable

//set the placeholder node ->  placeholderNode.geometry?.materials = materialmade



/*
 func presentMenu() {
   let hudNode = menuScene.rootNode.childNode(withName: "hud", recursively: true)!
 
   hudNode.geometry?.materials = [helper.menuHUDMaterial]
 
   hudNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(M_PI))

   helper.state = .tapToPlay
   
   let transition = SKTransition.crossFade(withDuration: 1.0)
   scnView.present(
     menuScene,
     with: transition,
     incomingPointOfView: nil,
     completionHandler: nil
   )
 }
 
 
 
 
 var menuHUDMaterial: SCNMaterial {
   // Create a HUD label node in SpriteKit
   let sceneSize = CGSize(width: 300, height: 200)
   
   let skScene = SKScene(size: sceneSize)
   skScene.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
   
   let instructionLabel = SKLabelNode(fontNamed: "Menlo-Bold")
   instructionLabel.fontSize = 35
   instructionLabel.text = "Tap To Play"
   instructionLabel.position.x = sceneSize.width / 2
   instructionLabel.position.y = 115
   skScene.addChild(instructionLabel)
   
   menuLabelNode = SKLabelNode(fontNamed: "Menlo-Bold")
   menuLabelNode.fontSize = 24
   
   menuLabelNode.position.x = sceneSize.width / 2
   menuLabelNode.position.y = 60
   skScene.addChild(menuLabelNode)
   
   let material = SCNMaterial()
   material.lightingModel = SCNMaterial.LightingModel.constant
   material.isDoubleSided = true
   material.diffuse.contents = skScene
   
   return material
 }
 */
