//
//  MenuSK.swift
//  FlappyClone
//
//  Created by Omar Olmos on 7/11/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import SpriteKit

open class MenuSK : SKScene {
    
    open var scoreLabel : SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.scaleMode = .resizeFill
        
        self.scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        self.scoreLabel.name = "menu"
        self.scoreLabel.text = "Menu stuff"
        self.scoreLabel.fontColor = UIColor.white
        self.scoreLabel.position = CGPoint(x: size.width/2, y: size.height/10)
        
        self.addChild(scoreLabel)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
