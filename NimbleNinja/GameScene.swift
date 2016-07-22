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
    var hero: TSHero!
    var isStarted = false
    var isGameOver = false
    var cloudGen: TSCloudGen!
    var wallGen: TSWallGen!
    override func didMoveToView(view: SKView) {
        initGameScreen()
        
    }
    func initGameScreen(){
        addBackground()
        addCloudGen()
        addGround()
        addNinja()
        hero.breathe()
        addWallGen()
        addStartLabel()
        addPhysics()
        
    }
    private func addBackground(){
        /* Setup your scene here */
        backgroundColor = UIColor(red: 159/255, green: 201/255, blue: 244/255, alpha: 1)
    }
    private func addCloudGen(){
        //cloud gen
        cloudGen = TSCloudGen(color: UIColor.clearColor(), size: view!.frame.size)
        cloudGen.position = view!.center
        addChild(cloudGen)
        cloudGen.populate(7)
        cloudGen.startGeneratingWithSpawnTime(4)
    }
    private func addGround(){
        //Add ground
        //refractor not currently working in swift 2.0 must click variable and edit scope! :D
        movingGround = TSMovingGround(size: CGSizeMake(view!.frame.width, kTSGroundHeight))
        movingGround.position = CGPointMake(0, view!.frame.size.height/2)
        addChild(movingGround)
    }
    private func addNinja(){
        //add Ninja
        hero = TSHero();
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
    }
    private func addWallGen(){
        //add WallGen
        wallGen = TSWallGen(color: UIColor.clearColor(), size: view!.frame.size)
        wallGen.position = view!.center
        addChild(wallGen)

    }
    private func addStartLabel(){
        //add start label
        let tapToStartLabel = SKLabelNode(text: "Tap To Start!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position.x = view!.center.x
        tapToStartLabel.position.y = view!.center.y + 50
        tapToStartLabel.fontName = "Helvetica"
        tapToStartLabel.fontColor = UIColor.blackColor()
        tapToStartLabel.removeFromParent()
        addChild(tapToStartLabel)
    }
    private func addPhysics(){
        //add physics world
        physicsWorld.contactDelegate = self; //delegate: a promise that it will implement methods. Java: a abstact class & method implementation
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isGameOver {
            restart()
        }
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
    func restart(){
        cloudGen.stopGenerating()
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        view!.presentScene(newScene)
    }
    //MARK: Game life cycle
    func start(){
        let tapToStartLabel = childNodeWithName("tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        movingGround.start()
        hero.stopBreathing()
        hero.startRunning()
        wallGen.startGeneratingWallEvery(1)
        
    }
    func gameOver(){
        isGameOver = true;
        
        //stopEverything
        hero.physicsBody = nil;
        wallGen.stopWalls()
        movingGround.stop()
        //create GameOver label
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontColor = UIColor.blackColor()
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.position.x = view!.center.x
        gameOverLabel.position.y = view!.center.y + 40
        gameOverLabel.fontSize = 22;
        gameOverLabel.removeFromParent()
        addChild(gameOverLabel)
    }
    //MARK: SKPhysics contact Delegate
    func didBeginContact(contact: SKPhysicsContact) {
        gameOver()
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
