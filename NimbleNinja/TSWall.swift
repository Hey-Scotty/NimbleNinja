//
//  TSWall.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/18/16.
//  Copyright © 2016 Tevin Scott. All rights reserved.
//

import Foundation
import SpriteKit

class TSWall: SKSpriteNode{
    let WALLWIDTH: CGFloat = 30.0;
    let WALLHEIGHT: CGFloat = 50.0
    let WALLCOLOR = UIColor.blackColor()
    let STARTINGSPEED: CGFloat = -300;
    init() {
        let size = CGSizeMake(WALLWIDTH, WALLHEIGHT)
        super.init(texture: nil,color: WALLCOLOR, size: size)
        startMoving()
        loadPhysicsBody(size)
    }
    internal func startMoving(){
        let moveLeft = SKAction.moveByX(-kDefaultXToMovePerSecond,y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    internal func stopMoving(){
        removeAllActions()
    }
    private func loadPhysicsBody(size: CGSize){
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = wallCategory
        //physicsBody?.contactTestBitMask = wallCategory// dont need for both bodies only 1
        physicsBody?.affectedByGravity = false //maybe useful when implementing jump feature
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}