//
//  GameScene.swift
//  ZombieConga
//
//  Created by Matthew J. Perkins on 10/11/17.
//  Copyright © 2017 Matthew J. Perkins. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let zombieChar = SKSpriteNode(imageNamed: "zombie1")
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        //add background
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background1")
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -1
        addChild(background)
        //add Zombie
        zombieChar.position = CGPoint(x: 400, y: 400)
        addChild(zombieChar)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else { dt = 0
        }
        lastUpdateTime = currentTime
        print("\(dt * 1000) milliseconds since last update")
     zombieChar.position = CGPoint(x: zombieChar.position.x + 8, y: zombieChar.position.y)
    }
}

