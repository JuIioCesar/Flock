//
//  FlockViewController.m
//  Flock
//
//  Created by Julio César Guzmán on 12/19/13.
//  Copyright (c) 2013 Julio César Guzmán. All rights reserved.
//

#import "FlockViewController.h"
#import "FlockScene.h"
#import "Scene.h"

@interface FlockViewController ()

@end

@implementation FlockViewController
{
    FlockScene *flockScene;
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
    flockScene = [FlockScene sceneWithSize:skView.bounds.size];
    flockScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:flockScene];
    
    // A scene
    Scene *scene = [Scene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
    
    
}


@end
