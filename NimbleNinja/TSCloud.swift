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
            let path = CGPath(ellipseIn: CGRect(x: 0,y: 0, width: size.width, height: size.height), transform: nil)
            self.path = path
            fillColor = UIColor.white
            
            startMoving(CLOUDSPEED)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func startMoving(_ speed: CGFloat){
            moveLeft = SKAction.moveBy(x: speed, y: 0, duration: 1)
            run(SKAction.repeatForever(moveLeft))
        }
        func playerIsRunning(){
            isPlayerRunning = true;
            if(isPlayerRunning){
                self.removeAllActions()
                startMoving(CLOUDSPEED * speedMultiplier);
            }
        }
        
}
