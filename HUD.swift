//
//  HUD.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 1/1/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//
/*
 * This Class contains all the overlayed text labels and
 * icons among the values
 */
import SpriteKit

class HUD {
    
    let viewRef : SKView
    let gameSceneRef : GameScene
    var startLabel = SKLabelNode(text: "Tap To Start!")

    var paused: Bool = false;
    var pauseLabel = SKLabelNode(text: "paused")
    var pauseButton = SKSpriteNode(imageNamed: "pause")
    
    var gameOverLabel = SKLabelNode(text: "GG M8")
    var score: Int = 0;
    
    init(view: SKView, gameScene: GameScene){
        viewRef = view
        gameSceneRef = gameScene
        addStartLabel()
        pauseSetup()
    }
    /*
     * adds all text necessary at start of game
     */
    private func addStartLabel(){
        startLabel.position.x = viewRef.center.x
        startLabel.position.y = viewRef.center.y + 50
        startLabel.fontName = "Helvetica"
        startLabel.fontColor = UIColor.white
        gameSceneRef.addChild(startLabel)
    }
    /*
     * toggles the paused text and button icon
     */
    func togglePause(){
        if(paused){
            gameSceneRef.addChild(pauseLabel)
        }
        else if(!paused){
            pauseLabel.removeFromParent()
        }
    }
    /*
     * alters the hud features for when the game has began
     */
    func gamestarted(){
        startLabel.removeFromParent()
        gameSceneRef.addChild(pauseButton)
    }
    
    /*
     * sets up all ui elements' values protaining to the pause functionality
     */
    private func pauseSetup(){
        pauseLabel.position.x = viewRef.center.x
        pauseLabel.position.y = viewRef.center.y + 50
        pauseLabel.fontName = "Helvetica"
        pauseLabel.fontColor = UIColor.white
        
        pauseButton.name = "pause button"
        pauseButton.zPosition = 10
        pauseButton.position.x = viewRef.frame.size.width - 40
        pauseButton.position.y = viewRef.frame.size.height - 40
        pauseButton.isUserInteractionEnabled = false
        print("location of pause button == \(pauseButton.position)")
    }
    func gameOver(){
        gameOverLabel.position.x = viewRef.center.x
        gameOverLabel.position.y = viewRef.center.y + 50
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.fontColor = UIColor.white
        gameSceneRef.addChild(gameOverLabel)
    }
}
