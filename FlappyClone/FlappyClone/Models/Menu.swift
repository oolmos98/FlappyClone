//
//  Menu.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/11/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import SceneKit
import SpriteKit


class Menu {
    
    var cameraNode: SCNNode!
    var menuScene: SCNScene!
    var menuMaterial: SCNMaterial!
    
    var backgroundSource: SCNAudioSource!

    
    var state: State!
    
    
    
    init() {
        menuScene = SCNScene(named: "art.scnassets/Menu.scn")
        state = State.menu
        setupMenu()
        playBackgroundSound()
    }
    
    enum State {
        case menu
        case playing
    }
    
    func setupMenu() {
        backgroundSource = SCNAudioSource(fileNamed: "Sounds/background.mp3")
        backgroundSource!.loops = false
        backgroundSource!.load()
        backgroundSource.loops = true
        menuScene!.rootNode.addAudioPlayer(SCNAudioPlayer(source: backgroundSource!))
        
    }
    
    func playBackgroundSound() {
        let playAudio = SCNAction.playAudio(backgroundSource!, waitForCompletion: false)
        menuScene!.rootNode.runAction(playAudio)
    }
    
}
