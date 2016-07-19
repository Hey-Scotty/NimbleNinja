//
//  TSWallGen.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/18/16.
//  Copyright © 2016 Tevin Scott. All rights reserved.
//

import Foundation
import SpriteKit

class TSWallGen: SKSpriteNode{
    var generationTimer: NSTimer?
    
    func startGeneratingWallEvery(seconds: NSTimeInterval){
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
        
    }
    func generateWall(){
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        if rand == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        let wall = TSWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (kTSGroundHeight/2 - wall.size.height/2)
        addChild(wall)
    }
}