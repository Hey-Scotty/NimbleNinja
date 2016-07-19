//
//  TSCloud.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/15/16.
//  Copyright © 2016 Tevin Scott. All rights reserved.
//

import Foundation
import SpriteKit
    class TSCloud: SKShapeNode{
        var isPlayerRunning: Bool;
        let CLOUDSPEED: CGFloat;
        var speedMultiplier: CGFloat! // increases cloud movement speed when player starts running
        var moveLeft: SKAction!;
        
        init(size: CGSize, moveSpeed: CGFloat){
            isPlayerRunning = false;
            CLOUDSPEED = moveSpeed
            super.init()
            let path = CGPathCreateWithEllipseInRect(CGRect(x: 0,y: 0, width: size.width, height: size.height), nil)
            self.path = path
            fillColor = UIColor.whiteColor()
            
            startMoving(CLOUDSPEED)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func startMoving(speed: CGFloat){
            moveLeft = SKAction.moveByX(speed, y: 0, duration: 1)
            runAction(SKAction.repeatActionForever(moveLeft))
        }
        func playerIsRunning(){
            isPlayerRunning = true;
            if(isPlayerRunning){
                self.removeAllActions()
                startMoving(CLOUDSPEED * speedMultiplier);
            }
        }
        
}