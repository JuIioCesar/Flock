//
//  MyScene.h
//  JugandoConSpriteKit
//

//  Copyright (c) 2013 Julio César Guzmán. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Agent.h"

@interface FlockScene : SKScene <SKPhysicsContactDelegate, UIGestureRecognizerDelegate>
-(void)setImageName:(NSString*)name;
-(void)addBird:(Agent *)agent;
@end
