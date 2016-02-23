//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Mengying Feng on 5/01/2016.
//  Copyright (c) 2016 Mengying Feng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var bird = SKSpriteNode() //a sprite for a bird
    
    var bg = SKSpriteNode()//a sprite for background
    
    var pipe1 = SKSpriteNode()
    var pipe2 = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        //equivalent to viewDidLoad
        
        
        
        
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
//        bg = SKSpriteNode(texture: bgTexture)
//        //position
//        bg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
//        //size
//        bg.size.height = self.frame.height
        
        //move the background to the left (-10: ten degrees to the left)
        let movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)//in seconds, only happens once
        
        //move background from left to right
        let replacebg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)//happens instantly
        
        let movebgForever = SKAction.repeatActionForever(SKAction.sequence([movebg, replacebg]))//move forever
        
        
        for var i:CGFloat=0; i<3; i++ {
            bg = SKSpriteNode(texture: bgTexture)
            //position
            bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
            //size
            bg.size.height = self.frame.height
            
            bg.zPosition = 0 //the less the lower on the screen
            
            bg.runAction(movebgForever)
            
            self.addChild(bg)
        }
        
        
        
        
      
        
        
        //
        //bird wing's up
        let birdTexture = SKTexture(imageNamed: "flappy1.png") //this is an image
        //bird wing's down
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")

        //1.animation between 2 birds (only happens once)
        let animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)//in second
        
        //2.action to repeat the above animation
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        
        //image
        bird = SKSpriteNode(texture: birdTexture)
        
        //location
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        //add animation to bird
        bird.runAction(makeBirdFlap)
        
        bird.zPosition = 2 //the bigger the higher on the screen
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/2)
        
        bird.physicsBody?.dynamic = true //apply gravity to the bird
        
        
        
        //add to the screen
        self.addChild(bird)

        
        //ground ( user can see it but exists)
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false//don't want gravity
        
        self.addChild(ground)
        //IF THERE ARE 2 PHYSICS BODIES, THEY WILL NOT CROSS OVER, WILL ONLY BE NEXT TO EACH OTHER
        
        
        
        
        //PIPES
        
        
        let gapHeight = birdTexture.size().height * 4
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height/4
        
        
        var pipeTexture = SKTexture(imageNamed: "pipe1.png")
        var pipe1 = SKSpriteNode(texture: pipeTexture)
        pipe1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + pipeTexture.size().height/2 + gapHeight/2 + pipeOffset)
        pipe1.zPosition = 1
        self.addChild(pipe1)
        
        var pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        var pipe2 = SKSpriteNode(texture: pipe2Texture)
        pipe2.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - pipe2Texture.size().height/2 - gapHeight/2 + pipeOffset)
        pipe2.zPosition = 1.1
        self.addChild(pipe2)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))

       
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        
        
    }
}
