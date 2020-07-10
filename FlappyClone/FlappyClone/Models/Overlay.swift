//
//  Overlay.swift
//  FlappyClone
//
//  Created by Jefferson Santiago on 7/8/20.
//  Copyright © 2020 Omar Olmos. All rights reserved.
//

//import Foundation
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
        self.scaleMode = .resizeFill
        
        self.scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        self.scoreLabel.name = "score"
        self.scoreLabel.text = "Score: \(score)"
        self.scoreLabel.fontColor = UIColor.white
        self.scoreLabel.position = CGPoint(x: size.width/2, y: size.height/10)
        //self.scoreLabel.fontSize = CGFloat(50)
        
        self.addChild(scoreLabel)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
