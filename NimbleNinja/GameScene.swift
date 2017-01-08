//
//  GameScene.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 7/14/16.
//  Copyright (c) 2016 Tevin Scott. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    var movingGround: TSMovingGround!
    var hero: TSHero! // make hero of type player
    var isStarted = false;
    var cloudGen: TSCloudGen!
    var wallGen: TSWallGen!
    var headsUpDisplay : HUD!
    var gameOverTriggered: Bool = false
    var intervalTime : TimeInterval? = nil
    var heroTopY: CGFloat?
    var heroBotY: CGFloat?
    var isInContact : Bool = false
    override func didMove(to view: SKView) {
        initGameScreen(view: view)
        
    }
    func initGameScreen(view : SKView){
        /* Setup your scene here */
        backgroundColor = UIColor(red: 159/255, green: 201/255, blue: 244/255, alpha: 1)
        //cloud gen
        cloudGen = TSCloudGen(color: UIColor.clear, size: view.frame.size)
        cloudGen.position = view.center
        addChild(cloudGen)
        cloudGen.populate(7)
        cloudGen.startGeneratingWithSpawnTime(4)
        //Add ground
        //refractor not currently working in swift 2.0 must click variable and edit scope! :D
        movingGround = TSMovingGround(size: CGSize(width: view.frame.width, height: kTSGroundHeight))
        movingGround.position = CGPoint(x: 0 , y: view.frame.size.height/2)
        addChild(movingGround)
        
        //add Ninja
        hero = TSHero();
        hero.position = CGPoint(x: 70, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
        //add WallGen
        wallGen = TSWallGen(color: UIColor.clear, size: view.frame.size)
        wallGen.position = view.center
        addChild(wallGen)
        //add HUD valuesc
        headsUpDisplay = HUD.init(view: view, gameScene: self)
        
        //add physics world
        physicsWorld.contactDelegate = self; //delegate: a promise that it will implement methods. Java: a abstact class & method implementation
        heroTopY = movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2
        heroBotY = movingGround.position.y - movingGround.frame.size.height/2 - hero.frame.size.height/2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //movingGround.start()
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)

        if (touchedNode.name != nil) {
            self.run(SKAction.run(self.pauseGame))
            print("paused touched")
        }

        else if(!isStarted){
            start()
            isStarted = true;
        }
        //hero.stopBreathing()
        //hero.startRunning()
        else{
            hero.flip()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    func start(){
        headsUpDisplay.gamestarted()
        movingGround.start()
        hero.stopBreathing()
        hero.startRunning()
        wallGen.startGeneratingWallEvery()
        
    }
    func pauseGame(){
        scene?.view?.isPaused = true
    }
    //MARK: SKPhysics contact Delegate
    func didBegin(_ contact: SKPhysicsContact) {
        Swift.print("contact is working\n")
        isInContact = true;
        
    }
    override func update(_ currentTime: TimeInterval) {
        if(intervalTime == nil){
            intervalTime = currentTime;
        }
        if(currentTime - intervalTime! > 0.2 ){
            intervalTime = currentTime;
        }
        if(hero.position.x < 0 && !gameOverTriggered){
            gameOverTriggered = true
            headsUpDisplay.gameOver()
            movingGround.stop()
            wallGen.stopGen()
            
        }
        if(hero.position.y != heroTopY && hero.isOnTop){
            hero.position.y = heroTopY!
            isInContact = false;
        }
        if(hero.position.y != heroBotY && !hero.isOnTop){
            hero.position.y = heroBotY!
            isInContact = false;
        }
        
        if((hero.zRotation != 0 && hero.physicsBody?.angularVelocity == 0)){
           hero.zRotation = 0
        }
        if(wallGen.intervalDivider != wallGen.newInterval){
            wallGen.stopGen()
            wallGen.intervalDivider = wallGen.newInterval
            wallGen.startGeneratingWallEvery()
        }
        
    }
}
