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
    let WALLCOLOR = UIColor.black
    let STARTINGSPEED: CGFloat = -300;
    init(_ scale : CGFloat) {
        let size = CGSize(width: WALLWIDTH, height: (scale * WALLHEIGHT))
        super.init(texture: nil,color: WALLCOLOR, size: size)
        startMoving()
        loadPhysicsBody(size)
    }
    func startMoving(){
        let moveLeft = SKAction.moveBy(x: -kDefaultXToMovePerSecond,y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
    }
    fileprivate func loadPhysicsBody(_ size: CGSize){
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = wallCategory
        //physicsBody?.contactTestBitMask = wallCategory// dont need for both bodies only 1
        physicsBody?.affectedByGravity = false //maybe useful when implementing jump feature
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
