//
//  GameScene.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/14/16.
//  Copyright (c) 2016 Tevin Scott. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var movingGround: TSMovingGround!
    var hero: TSHero!
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor(red: 159/255, green: 201/255, blue: 244/255, alpha: 1)
        //refractor not currently working in swift 2.0 must click variable and edit scope! :D
        movingGround = TSMovingGround(size: CGSizeMake(view.frame.width, 20))
        movingGround.position = CGPointMake(0, view.frame.size.height/2)
        addChild(movingGround)
        hero = TSHero();
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       movingGround.start()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
