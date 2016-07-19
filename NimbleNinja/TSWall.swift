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
        super.init(texture: nil,color: WALLCOLOR, size: CGSizeMake(WALLWIDTH, WALLHEIGHT))
        startMoving()
    }
    func startMoving(){
        let moveLeft = SKAction.moveByX(STARTINGSPEED,y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}