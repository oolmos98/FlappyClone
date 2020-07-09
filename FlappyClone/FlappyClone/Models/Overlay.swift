//
//  Overlay.swift
//  FlappyClone
//
//  Created by Jefferson Santiago on 7/8/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

import Foundation
import SpriteKit

open class Overlay : SKScene {
    open var scoreLabel : SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        scaleMode = .resizeFill
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontColor = UIColor.black
        scoreLabel?.position = CGPoint(x: 0, y: 0)
        self.addChild(scoreLabel!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
