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


@end
