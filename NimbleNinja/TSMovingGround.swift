//
//  TSMovingGround.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/14/16.
//  Copyright © 2016 Tevin Scott. All rights reserved.
//

import Foundation
import SpriteKit

class TSMovingGround: SKSpriteNode{
    let NUMOFSEGMENTS = 20;
    let COLORONE = UIColor(red:88/255, green: 148/255, blue: 87/255, alpha: 1.0)// light hue of green
    let COLORTWO = UIColor(red:120/255, green: 195/255, blue: 118/255, alpha: 1.0)//dark hue of green

    
    init(size: CGSize){
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width*2, size.height))
        anchorPoint = CGPointMake(0, 0.5)//sets starting point for which the object is drawn from, default is top left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}