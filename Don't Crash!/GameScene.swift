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
    let player = SKSpriteNode(imageNamed: "player")
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    let gameArea: CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 2.16
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        //deals with the background
        let background = SKSpriteNode(imageNamed: "earth.jpg")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        //deals with the player
        player.setScale(0.7)
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 5)
        player.zPosition = 1
        self.addChild(player)
        
        
        startNewLevel()
        
    }
    
    func startNewLevel() {
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: 1)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointofTouch = touch.location(in: self)
            let previousTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointofTouch.x - previousTouch.x
            
            player.position.x += amountDragged
            
            //keeps the player from going too far to the right
            if (player.position.x > gameArea.maxX - (player.size.width / 2)) {
                player.position.x = gameArea.maxX - (player.size.width / 2)
            }
            
            //keeps the player from going too far to the left
            if (player.position.x < gameArea.minX + (player.size.width / 2)) {
                player.position.x = gameArea.minX + (player.size.width / 2)
            }
        }
    }
    
    func spawnEnemy() {
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "enemy")
        enemy.setScale(3)
        enemy.position = startPoint
        enemy.zPosition = 2
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 2)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        enemy.run(enemySequence)
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy, dx)
        
        enemy.zRotation = amountToRotate
    }
}
