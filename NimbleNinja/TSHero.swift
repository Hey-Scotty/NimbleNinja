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
    var upOrientation = true
    var downOrientation = false
    var firstFlip = true;
    var flipTimer: TimeInterval?
    init(){
        let size = CGSize(width: 32, height: 44)
        super.init(texture:nil, color: UIColor.clear, size: size)
        
        loadAppearence()
        loadPhysicsBody(size)
    }
    fileprivate func loadAppearence(){
    body = SKSpriteNode(color: UIColor.black,size: CGSize(width: self.frame.size.width, height: 40))
    body.position = CGPoint(x: 0,y: 2)
    addChild(body)
    initFacialFeatures()
    initArm()
    initFeet()
    }
    
    //compared to java this has been extremely streamlined vs using boolean checks with rectangles and loops
    fileprivate func loadPhysicsBody(_ size: CGSize){
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = heroCategory
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.affectedByGravity = false //maybe useful when implementing jump feature
    }
    fileprivate func initFacialFeatures(){
        let face = SKSpriteNode(color: skinColor, size: CGSize(width: self.frame.size.width, height: 12))
        face.position = CGPoint(x: 0,y: 6)
        body.addChild(face)
        
        let eyeColor = UIColor.white
        let leftEye = SKSpriteNode(color:eyeColor, size: CGSize(width: 6,height: 6))
        let rightEye = leftEye.copy() as! SKSpriteNode
        let pupil = SKSpriteNode(color: UIColor.black, size: CGSize(width: 3, height: 3))
        
        pupil.position = CGPoint(x: 2, y: 0)
        leftEye.addChild(pupil)
        rightEye.addChild(pupil.copy() as! SKSpriteNode)
        
        leftEye.position = CGPoint(x: -4, y: 0)
        face.addChild(leftEye)
        rightEye.position = CGPoint(x: 14, y: 0)
        face.addChild(rightEye)
        
        let eyebrows = SKSpriteNode(color: UIColor.black, size: CGSize(width: 11, height: 1))
        eyebrows.position = CGPoint(x: -1, y: leftEye.size.height / 2)
        leftEye.addChild(eyebrows)
        rightEye.addChild(eyebrows.copy() as! SKSpriteNode)

    }
    fileprivate func initArm(){
        let armColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1.0)
        arm = SKSpriteNode(color: armColor, size: CGSize(width: 8, height: 14))
        arm.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        arm.position = CGPoint(x: -10, y: -7)
        body.addChild(arm)
        
        let hand = SKSpriteNode(color: skinColor, size: CGSize(width: arm.size.width, height: 5))
        hand.position = CGPoint(x: 0, y: -arm.size.height*0.9 + hand.size.height/2)// weird math to compensate for arm anchor offset 
        arm.addChild(hand)
        
        
    }
    fileprivate func initFeet(){
        leftFoot = SKSpriteNode(color: UIColor.black, size: CGSize(width: 9, height: 4))
        leftFoot.position = CGPoint(x: -6, y: -size.height/2 + leftFoot.size.height/2)
        addChild(leftFoot)
        
        rightFoot = leftFoot.copy() as! SKSpriteNode
        rightFoot.position.x = 8
        addChild(rightFoot)
    }
    internal func breathe(){
        let breatheOut = SKAction.moveBy(x: 0, y: -3, duration: 0.5)
        let breatheIn = SKAction.moveBy(x: 0, y: 3, duration: 0.5)
        let breatheSequence = SKAction.sequence([breatheOut, breatheIn])
        body.run(SKAction.repeatForever(breatheSequence))
    }
    internal func startRunning(){
        let rotateBack = SKAction.rotate(byAngle: CGFloat(Double.pi)/2, duration: 0.1)
        arm.run(rotateBack)
        performOneRunCycle()
        
    }
    internal func flip(){
        var scale: CGFloat!
        if(firstFlip){
            isOnTop = !isOnTop
            if !isOnTop{
                scale = -1.0
            }
            else{
                scale = 1.0
            }
            
            let translate = SKAction.moveBy(x: 0, y: (scale*(size.height + kTSGroundHeight)), duration: 0.1)
            let flip = SKAction.scaleY(to: scale, duration: 0.1)
            run(translate)
            run(flip)
            flipTimer = CACurrentMediaTime()
            firstFlip = false;
        }
        else if (CACurrentMediaTime() - flipTimer! > 0.2){
            print(CACurrentMediaTime() - flipTimer!)
            isOnTop = !isOnTop
            if !isOnTop{
                scale = -1.0
            }
            else{
                scale = 1.0
            }
            
            let translate = SKAction.moveBy(x: 0, y: (scale*(size.height + kTSGroundHeight)), duration: 0.1)
            let flip = SKAction.scaleY(to: scale, duration: 0.1)
            run(translate)
            run(flip)
            flipTimer = CACurrentMediaTime()
        }
        
        
        
    }
    
    internal func performOneRunCycle(){
        let up = SKAction.moveBy(x: 0, y: 2, duration: 0.05)
        let down = SKAction.moveBy(x: 0, y: -2, duration: 0.05)
        //block
        leftFoot.run(up, completion: { () -> Void in
            self.leftFoot.run(down)
            self.rightFoot.run(up, completion: { () -> Void in
                self.rightFoot.run(down, completion: { () -> Void in
                    self.performOneRunCycle() // eligantly recursive ;)
                })
            })
        })
    }
    func finishTrip(){
         //(scale*(size.height + kTSGroundHeight)
    }
    internal func stopBreathing(){
        body.removeAllActions()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
