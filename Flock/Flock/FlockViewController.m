//
//  FlockViewController.m
//  Flock
//
//  Created by Julio César Guzmán on 12/19/13.
//  Copyright (c) 2013 Julio César Guzmán. All rights reserved.
//

#import "FlockViewController.h"
#import "FlockScene.h"

@interface FlockViewController ()
@end

@implementation FlockViewController
{
    FlockScene *flockScene;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)configureView
{
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    flockScene = [FlockScene sceneWithSize:skView.bounds.size];
    flockScene.scaleMode = SKSceneScaleModeAspectFill;
    [flockScene set:self.imageName];
    [skView presentScene:flockScene];
    [self.view.gestureRecognizers.firstObject setDelegate:flockScene];
}

@end
