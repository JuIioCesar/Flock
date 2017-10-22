//
//  MyScene.h
//  JugandoConSpriteKit
//

//  Copyright (c) 2013 Julio César Guzmán. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Agent.h"

@interface FlockScene : SKScene <SKPhysicsContactDelegate, UIGestureRecognizerDelegate>
-(void)set:(NSString*)name;
-(void)add:(Agent *)agent;
@end
