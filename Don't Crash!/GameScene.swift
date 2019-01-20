//
//  GameScene.swift
//  Don't Crash!
//
//  Created by Jonathan Ross on 1/20/19.
//  Copyright © 2019 Jonathan Ross. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let player = SKSpriteNode(imageNamed: "yeet")
    let enemy = SKSpriteNode(imageNamed: "spleet")
    
    override func didMove(to view: SKView) {
        //deals with the background
        let background = SKSpriteNode(imageNamed: "earth.jpg")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        //deals with the player
        player.setScale(0.3)
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 5)
        player.zPosition = 1
        self.addChild(player)
        
        //deals with oncoming traffic
        enemy.setScale(0.3)
        enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.7)
        enemy.zPosition = 2
        self.addChild(enemy)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointofTouch = touch.location(in: self)
            let previousTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointofTouch.x - previousTouch.x
            
            player.position.x += amountDragged
        }
    }
}
