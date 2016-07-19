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
    var isStarted = false;
    var cloudGen: TSCloudGen!
    var wallGen: TSWallGen!
    override func didMoveToView(view: SKView) {
        initGameScreen()
        
    }
    func initGameScreen(){
        /* Setup your scene here */
        backgroundColor = UIColor(red: 159/255, green: 201/255, blue: 244/255, alpha: 1)
        //cloud gen
        cloudGen = TSCloudGen(color: UIColor.clearColor(), size: view!.frame.size)
        cloudGen.position = view!.center
        addChild(cloudGen)
        cloudGen.populate(7)
        cloudGen.startGeneratingWithSpawnTime(4)
        //Add ground
        //refractor not currently working in swift 2.0 must click variable and edit scope! :D
        movingGround = TSMovingGround(size: CGSizeMake(view!.frame.width, kTSGroundHeight))
        movingGround.position = CGPointMake(0, view!.frame.size.height/2)
        addChild(movingGround)
        
        //add Ninja
        hero = TSHero();
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
        //add WallGen
        wallGen = TSWallGen(color: UIColor.clearColor(), size: view!.frame.size)
        wallGen.position = view!.center
        addChild(wallGen)
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //movingGround.start()
        if(!isStarted){
            start()
            isStarted = true;
        }
        //hero.stopBreathing()
        //hero.startRunning()
        else{
            hero.flip()
        }
    }
    func start(){
        movingGround.start()
        hero.stopBreathing()
        hero.startRunning()
        wallGen.startGeneratingWallEvery(1)
        
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
