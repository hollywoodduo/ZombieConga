//
//  MainMenuScene.swift
//  ZombieConga
//
//  Created by Matthew J. Perkins on 10/16/17.
//  Copyright © 2017 Matthew J. Perkins. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "MainMenu")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(background)
        
        let startLabel = SKLabelNode(fontNamed: "ArialRounded")
        startLabel.text = "Press to Start!"
        startLabel.fontColor = SKColor.white
        startLabel.fontSize = 75
        startLabel.zPosition = 150
        startLabel.horizontalAlignmentMode = .center
        startLabel.verticalAlignmentMode = .bottom
        startLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(startLabel)
    }
    
    func sceneTapped() {
        let myScene = GameScene(size: size)
        myScene.scaleMode = scaleMode
        let reveal = SKTransition.doorway(withDuration: 1.5)
        view?.presentScene(myScene, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        sceneTapped()
    }
    
}
