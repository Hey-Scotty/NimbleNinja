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
    
        init(size: CGSize){
            super.init()
            let path = CGPathCreateWithEllipseInRect(CGRect(x: 0,y: 0, width: size.width, height: size.height), nil)
            self.path = path
            fillColor = UIColor.whiteColor()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}