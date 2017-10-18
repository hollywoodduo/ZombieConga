//
//  GameOverScene.swift
//  ZombieConga
//
//  Created by Matthew J. Perkins on 10/16/17.
//  Copyright © 2017 Matthew J. Perkins. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    let won: Bool
    
    init(size: CGSize, won: Bool) {
        self.won = won
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        var background: SKSpriteNode
        if (won) {
            background = SKSpriteNode(imageNamed: "YouWin")
            run(SKAction.playSoundFileNamed("win.wav", waitForCompletion: false))
        } else {
            background = SKSpriteNode(imageNamed: "YouLose")
            run(SKAction.playSoundFileNamed("lose.wav", waitForCompletion: false))
        }
        
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(background)
        
        let playAgainLabel = SKLabelNode(fontNamed: "ArialRounded")
        playAgainLabel.text = "Press to Play Again!"
        playAgainLabel.fontColor = SKColor.white
        playAgainLabel.fontSize = 75
        playAgainLabel.zPosition = 150
        playAgainLabel.horizontalAlignmentMode = .center
        playAgainLabel.verticalAlignmentMode = .bottom
        playAgainLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(playAgainLabel)
    }
    
    func sceneTapped() {
        let myScene = GameScene(size: self.size)
        myScene.scaleMode = self.scaleMode
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        self.view?.presentScene(myScene, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        sceneTapped()
    }

}


