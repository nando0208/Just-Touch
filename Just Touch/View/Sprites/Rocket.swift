//
//  Rocket.swift
//  Just Touch
//
//  Created by Fernando Ferreira on 4/21/16.
//  Copyright © 2016 Fernando Ferreira. All rights reserved.
//

import SpriteKit

final class Rocket: SKSpriteNode {

    private var speedRocket: CGFloat = 0 {
        didSet {
            smoke.particleBirthRate = speedRocket * CGFloat(maxParticlesToEmit) / maxSpeedRocket
        }
    }

    var maxParticlesToEmit:CGFloat = 0

    var smoke = SKEmitterNode()
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        
        if let somkePath = NSBundle.mainBundle().pathForResource("SmokeRocket", ofType: "sks"),
            smokeNode = NSKeyedUnarchiver.unarchiveObjectWithFile(somkePath) as? SKEmitterNode {
            
            smokeNode.zPosition = self.zPosition - 1
            smokeNode.setScale(CGFloat(0.34)) //Scale of Rocket
            smokeNode.position = CGPoint(x: CGRectGetMidX(self.frame),
                                         y: CGRectGetMinY(self.frame))

            addChild(smokeNode)

            smoke = smokeNode
            maxParticlesToEmit = smokeNode.particleBirthRate
            smokeNode.numParticlesToEmit = 0
        }
    }
    
    convenience init() {
        
        let texture = SKTexture(imageNamed: "rocket")
        self.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSpeedRocket(newValue: CGFloat) {

        if newValue <= maxSpeedRocket {
            speedRocket = newValue
        }
    }
}



