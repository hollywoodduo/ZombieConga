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
    let zombieMovePointPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    let playableRect: CGRect
    var lastTouchLocation: CGPoint?
    let zombieRotationRadiansPerSec: CGFloat = 4.0 * π
    
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
        debugDrawPlayableArea()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else { dt = 0
        }
        lastUpdateTime = currentTime
        print("\(dt * 1000) milliseconds since last update")
        
        if let lastTouchLocation = lastTouchLocation {
            let diff = lastTouchLocation - zombieChar.position
            if diff.length() <= zombieMovePointPerSec * CGFloat(dt) {
                zombieChar.position = lastTouchLocation
                velocity = CGPoint.zero
            } else {
                move(sprite: zombieChar, velocity: velocity)
                rotate(sprite: zombieChar, direction: velocity, rotateRadiansPerSec: zombieRotationRadiansPerSec)
              
            }
        }
         boundsCheckZombie()
    }
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = velocity * CGFloat(dt)
        print("Amount to move: \(amountToMove)")
        //sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
        sprite.position += amountToMove
    }
    
    func zombieMoveToward(location: CGPoint) {
        let offset = location - zombieChar.position
        let direction = offset.normalized()
        velocity = direction * zombieMovePointPerSec
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        lastTouchLocation = touchLocation
        zombieMoveToward(location: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    //prevent character from running off screen
    func boundsCheckZombie() {
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        if zombieChar.position.x <= bottomLeft.x {
            zombieChar.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        if zombieChar.position.x >= topRight.x {
            zombieChar.position.x = topRight.x
            velocity.x = -velocity.x
        }
        if zombieChar.position.y <= bottomLeft.y {
            zombieChar.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        if zombieChar.position.y >= topRight.y {
            zombieChar.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode(rect: playableRect)
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
    func rotate(sprite: SKSpriteNode, direction: CGPoint, rotateRadiansPerSec: CGFloat) {
        let shortest = shortestAngleBetween(angle1: sprite.zRotation, angle2: velocity.angle)
        let amountToRotate = min(rotateRadiansPerSec * CGFloat(dt), abs(shortest))
        sprite.zRotation += shortest.sign() * amountToRotate
    }
}

