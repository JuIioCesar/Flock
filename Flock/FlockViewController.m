//
//  FlockViewController.m
//  Flock
//
//  Created by Julio César Guzmán on 12/19/13.
//  Copyright (c) 2013 Julio César Guzmán. All rights reserved.
//

#import "FlockViewController.h"
#import "FlockScene.h"
#import "UIColor+RandomColor.h"

@interface FlockViewController ()

@end

@implementation FlockViewController
{
    FlockScene *scene;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // SPRITE KIT
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    scene = [FlockScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
}


#pragma mark - Touch events

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    for (UITouch *touch in touches)
    {
        //Nacimiento
        CGPoint location = [touch locationInNode:scene];
        Agent *bird;
        bird = [Agent AgentWithImageNamed:@"bird"
                                     name:@"name"
                                     gene:random() % 2
                                     life:100
                                 strength:random() % 50
                                   vision:100
                                craziness:5
                                 cohesion:2
                             aggressivity:5
                                     fear:5
                             maximumSpeed:100
                                 position:location
                                   radius:3];
        bird.color = [UIColor randomColorWithOffset:0.5];
        bird.colorBlendFactor = 1.0;
        [scene addBird:bird];
    }
}


@end
