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
    
    func populate(num: Int){
        for _ in 0...num{
            let cloud = TSCloud(size: CGSizeMake(CLOUDWIDTH, ClOUDHEIGHT))
            let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2 //random method for swift just like java Random Class library
            let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
            cloud.position = CGPointMake(x,y)
            addChild(cloud)
        }
    }
    
}