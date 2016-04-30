//
//  Rocket.swift
//  Just Touch
//
//  Created by Fernando Ferreira on 4/21/16.
//  Copyright © 2016 Fernando Ferreira. All rights reserved.
//

import SpriteKit

final class Rocket: SKSpriteNode {

    private var speedRocket: CGFloat = 0

    var maxSpeedAlpha:CGFloat = -0.1
    var minSpeedAlpha:CGFloat = -2.0
    
    var hatch = Hatch()

    var smoke = SKEmitterNode()

    var lifes = 3
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        
        guard let somkePath = NSBundle.mainBundle().pathForResource("SmokeRocket", ofType: "sks"),
            smokeNode = NSKeyedUnarchiver.unarchiveObjectWithFile(somkePath) as? SKEmitterNode else {
                return
        }
        
        smokeNode.setScale(CGFloat(0.34)) //Scale of Rocket
        smokeNode.position = CGPoint(x: CGRectGetMidX(self.frame),
                                     y: CGRectGetMinY(self.frame))
        
        addChild(smokeNode)
        
        smoke = smokeNode
        maxSpeedAlpha = smokeNode.particleAlphaSpeed
        smokeNode.particleAlphaSpeed = minSpeedAlpha
        
        addChild(hatch)
        
        hatch.zPosition = zPosition + 30
        hatch.position = CGPoint(x: CGRectGetMidX(self.frame),
                                 y: CGRectGetHeight(self.frame)
                                    - ( CGRectGetHeight(hatch.frame) / 2 ) - CGRectGetHeight(self.frame) * 0.66 )
        
        hatch.glow.zPosition = hatch.zPosition + 1

        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.categoryBitMask = ObjectsBitMask.Rocket.rawValue
        physicsBody?.contactTestBitMask = ObjectsBitMask.Meteor.rawValue
        physicsBody?.affectedByGravity = false
    }
    
    convenience init() {
        
        let texture = SKTexture(imageNamed: "rocket")
        self.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSpeedRocket(newValue: CGFloat) {

        if newValue <= maxSpeedRocket && newValue >= minSpeedRocket {
            speedRocket = newValue
            smoke.particleAlphaSpeed = minSpeedAlpha - ((minSpeedAlpha - maxSpeedAlpha) * speedRocket / (maxSpeedRocket - 0.2))
        }
    }

    func moveY(deltaTime: NSTimeInterval, size: CGSize) {
    
        var rotation = zRotation + CGFloat(M_PI)

        let margin = size.width * 0.1

        rotation = rotation > 0 ? rotation - CGFloat(M_PI) : rotation + CGFloat(M_PI)

        var newPosition = position
        newPosition.x -= 340 * rotation * CGFloat(deltaTime)

        if margin < newPosition.x && newPosition.x < size.width - margin {
            position = newPosition
        }
    }
}



