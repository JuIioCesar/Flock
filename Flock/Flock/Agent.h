//
//  Agent.h
//  JugandoConSpriteKit
//
//  Created by Julio César Guzmán on 15/06/13.
//  Copyright (c) 2013 Julio César Guzmán. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Agent : SKSpriteNode

@property(nonatomic) CGFloat gene;
@property(nonatomic) CGFloat life;
@property(nonatomic) CGFloat strength;
@property(nonatomic) CGFloat vision;
@property(nonatomic) CGFloat craziness;
@property(nonatomic) CGFloat cohesion;
@property(nonatomic) CGFloat aggressivity;
@property(nonatomic) CGFloat fear;
@property(nonatomic) CGFloat maximumSpeed;

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
                       radius:(CGFloat)radius;

@end
