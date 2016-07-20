//
//  MLCloudGen.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/15/16.
//  Copyright © 2016 Tevin Scott. All rights reserved.
//

import Foundation
import SpriteKit

class TSCloudGen: SKSpriteNode{
    let CLOUDWIDTH: CGFloat = 125.0
    let ClOUDHEIGHT: CGFloat = 55.0
    let DEFAULTSPEED: CGFloat = -8.0;
    var generationTimer: NSTimer!
    
    
    internal func populate(num: Int){
        for _ in 0...num{
            let cloud = TSCloud(size: CGSizeMake(CLOUDWIDTH, ClOUDHEIGHT), moveSpeed: DEFAULTSPEED)
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2 //random method for swift just like java Random Class library
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            cloud.position = CGPointMake(x,y)
            addChild(cloud)
        }
    }
    func startGeneratingWithSpawnTime(seconds: NSTimeInterval){
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateCloud",userInfo: nil, repeats:true)
    }
    //generates single cloud
    func generateCloud(){
        let x = size.width/2 + CLOUDWIDTH/2
        let y = CGFloat(arc4random_uniform(UInt32(size.height) )) - size.height-2;
        let cloud = TSCloud(size: CGSizeMake(CLOUDWIDTH, ClOUDHEIGHT), moveSpeed: DEFAULTSPEED);
        cloud.position = CGPointMake(x, y)
        cloud.zPosition = -1
        addChild(cloud)
    }
    func stopGenerating(){
        generationTimer.invalidate()
    }
    
}