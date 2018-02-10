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
    var generationTimer: Timer?
    var defaultInterval : TimeInterval = 2 //seconds
    var intervalDivider : TimeInterval = 1;
    var newInterval : TimeInterval = 1
    var wallCounter: Int = 0
    
    @objc func startGeneratingWallEvery(){
        generationTimer = Timer.scheduledTimer(timeInterval: defaultInterval/intervalDivider, target: self, selector: #selector(TSWallGen.generateWall), userInfo: nil, repeats: true)
        
    }
    func stopGen(){
        generationTimer?.invalidate()
    }
    @objc func generateWall(){
        wallCounter += 1
        var scale: CGFloat
        let rand = arc4random_uniform(4)
        var sizing: CGFloat
        if rand == 0 {
            scale = -1.0
            sizing = 1
        }
        else if rand == 1{
            scale = 1.0
            sizing = 1
        }

        else if rand == 2{
            scale = 1.0
            sizing = 1.5
        }
        else {
            scale = -1.0
            sizing = 1.5
        }
        let wall = TSWall(sizing)
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (kTSGroundHeight/2 - wall.size.height/2)
        addChild(wall)
        if(wallCounter % 5 == 0){
            newInterval = intervalDivider + 0.2
        }
    }
}
