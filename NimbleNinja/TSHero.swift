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
    let skinColor = UIColor(red: 207/255, green: 193/255, blue: 168/255, alpha: 1.0)
    var isOnTop = true
    
    init(){
        let size = CGSizeMake(32, 44)
        super.init(texture:nil, color: UIColor.clearColor(), size: size)
        
        loadAppearence()
        loadPhysicsBody(size)
    }
    private func loadAppearence(){
    body = SKSpriteNode(color: UIColor.blackColor(),size: CGSizeMake(self.frame.size.width, 40))
    body.position = CGPointMake(0,2)
    addChild(body)
    initFacialFeatures()
    initArm()
    initFeet()
    }
    
    //compared to java this has been extremely streamlined vs using boolean checks with rectangles and loops
    private func loadPhysicsBody(size: CGSize){
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = heroCategory
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.affectedByGravity = false //maybe useful when implementing jump feature
    }
    private func initFacialFeatures(){
        let face = SKSpriteNode(color: skinColor, size: CGSizeMake(self.frame.size.width, 12))
        face.position = CGPointMake(0,6)
        body.addChild(face)
        
        let eyeColor = UIColor.whiteColor()
        let leftEye = SKSpriteNode(color:eyeColor, size: CGSizeMake(6,6))
        let rightEye = leftEye.copy() as! SKSpriteNode
        let pupil = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(3, 3))
        
        pupil.position = CGPointMake(2, 0)
        leftEye.addChild(pupil)
        rightEye.addChild(pupil.copy() as! SKSpriteNode)
        
        leftEye.position = CGPointMake(-4, 0)
        face.addChild(leftEye)
        rightEye.position = CGPointMake(14, 0)
        face.addChild(rightEye)
        
        let eyebrows = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(11, 1))
        eyebrows.position = CGPointMake(-1, leftEye.size.height / 2)
        leftEye.addChild(eyebrows)
        rightEye.addChild(eyebrows.copy() as! SKSpriteNode)

    }
    private func initArm(){
        let armColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1.0)
        arm = SKSpriteNode(color: armColor, size: CGSizeMake(8, 14))
        arm.anchorPoint = CGPointMake(0.5, 0.9)
        arm.position = CGPointMake(-10, -7)
        body.addChild(arm)
        
        let hand = SKSpriteNode(color: skinColor, size: CGSizeMake(arm.size.width, 5))
        hand.position = CGPointMake(0, -arm.size.height*0.9 + hand.size.height/2)// weird math to compensate for arm anchor offset 
        arm.addChild(hand)
        
        
    }
    private func initFeet(){
        leftFoot = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(9, 4))
        leftFoot.position = CGPointMake(-6, -size.height/2 + leftFoot.size.height/2)
        addChild(leftFoot)
        
        rightFoot = leftFoot.copy() as! SKSpriteNode
        rightFoot.position.x = 8
        addChild(rightFoot)
    }
    internal func breathe(){
        let breatheOut = SKAction.moveByX(0, y: -3, duration: 0.5)
        let breatheIn = SKAction.moveByX(0, y: 3, duration: 0.5)
        let breatheSequence = SKAction.sequence([breatheOut, breatheIn])
        body.runAction(SKAction.repeatActionForever(breatheSequence))
    }
    internal func startRunning(){
        let rotateBack = SKAction.rotateByAngle(CGFloat(-M_PI)/2, duration: 0.1)
        arm.runAction(rotateBack)
        performOneRunCycle()
        
    }
    internal func flip(){
        isOnTop = !isOnTop
        var scale: CGFloat!
        if !isOnTop{
            scale = -1.0
        }
        else{
            scale = 1.0
        }
        let translate = SKAction.moveByX(0, y: (scale*(size.height + kTSGroundHeight)), duration: 0.1)
        let flip = SKAction.scaleYTo(scale, duration: 0.1)
        runAction(translate)
        runAction(flip)
    }
    internal func performOneRunCycle(){
        let up = SKAction.moveByX(0, y: 2, duration: 0.05)
        let down = SKAction.moveByX(0, y: -2, duration: 0.05)
        //block
        leftFoot.runAction(up, completion: { () -> Void in
            self.leftFoot.runAction(down)
            self.rightFoot.runAction(up, completion: { () -> Void in
                self.rightFoot.runAction(down, completion: { () -> Void in
                    self.performOneRunCycle() // eligantly recursive ;)
                })
            })
        })
    }
    internal func stopBreathing(){
        body.removeAllActions()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}