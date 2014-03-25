//
//  Agent.m
//  JugandoConSpriteKit
//
//  Created by Julio César Guzmán on 15/06/13.
//  Copyright (c) 2013 Julio César Guzmán. All rights reserved.
//

#import "Agent.h"

@implementation Agent

+(Agent *)AgentWithImageNamed:(NSString *)imageNamed
                         name:(NSString *)name
                         gene:(CGFloat)gene
                         life:(CGFloat)life
                     strength:(CGFloat)strength
                       vision:(CGFloat)vision
                    craziness:(CGFloat)craziness
                     cohesion:(CGFloat)cohesion
                 aggressivity:(CGFloat)aggressivity
                         fear:(CGFloat)fear
                 maximumSpeed:(CGFloat)maximumSpeed
                     position:(CGPoint)position
                       radius:(CGFloat)radius
{
    Agent *agent;
    agent = [Agent spriteNodeWithImageNamed:imageNamed];
    agent.name = name;
    agent.gene = gene;
    agent.life = life;
    agent.strength = strength;
    agent.vision = vision;
    agent.craziness = craziness;
    agent.cohesion = cohesion;
    agent.aggressivity = aggressivity;
    agent.fear = fear;
    agent.maximumSpeed = maximumSpeed;
    agent.position = position;
    agent.size = CGSizeMake(radius * 2, radius * 2);
    agent.physicsBody.allowsRotation = NO ;
    agent.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    agent.physicsBody.contactTestBitMask = agent.gene;
    return agent;
}

@end
