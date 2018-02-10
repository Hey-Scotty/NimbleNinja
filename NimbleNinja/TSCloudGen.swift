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
    var generationTimer: Timer!
    
    
    internal func populate(_ num: Int){
        for _ in 0...num{
            let cloud = TSCloud(size: CGSize(width: CLOUDWIDTH, height: ClOUDHEIGHT), moveSpeed: DEFAULTSPEED)
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2 //random method for swift just like java Random Class library
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            cloud.position = CGPoint(x: x,y: y)
            addChild(cloud)
        }
    }
    func startGeneratingWithSpawnTime(_ seconds: TimeInterval){
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(TSCloudGen.generateCloud),userInfo: nil, repeats:true)
    }
    //generates single cloud
    @objc func generateCloud(){
        let x = size.width/2 + CLOUDWIDTH/2
        let y = CGFloat(arc4random_uniform(UInt32(size.height) )) - size.height-2;
        let cloud = TSCloud(size: CGSize(width: CLOUDWIDTH, height: ClOUDHEIGHT), moveSpeed: DEFAULTSPEED);
        cloud.position = CGPoint(x: x, y: y)
        cloud.zPosition = -1
        addChild(cloud)
    }
    
}
