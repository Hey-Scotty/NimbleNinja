//
//  GameScene.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/14/16.
//  Copyright (c) 2016 Tevin Scott. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor(red: 159/255, green: 201/255, blue: 244/255, alpha: 1)
        
        let ground = TSMovingGround(size: CGSizeMake(view.frame.width, 20))
        ground.position = view.center
        addChild(ground)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
