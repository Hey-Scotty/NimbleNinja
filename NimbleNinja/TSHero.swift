//
//  TSHero.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/14/16.
//  Copyright © 2016 Tevin Scott. All rights reserved.
//

import Foundation
import SpriteKit

class TSHero: SKSpriteNode{
    var body: SKSpriteNode!
    var arm: SKSpriteNode!
    var leftFoot:SKSpriteNode!
    var rightFoot:SKSpriteNode!
    init(){
        super.init(texture:nil, color: UIColor.blackColor(), size: CGSizeMake(32, 44))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}