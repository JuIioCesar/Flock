//
//  MyScene.m
//  JugandoConSpriteKit
//
//  Created by Julio César Guzmán on 6/12/13.
//  Copyright (c) 2013 Julio César Guzmán. All rights reserved.
//

#import "FlockScene.h"
#import "Agent.h"
#import "UIColor+RandomColor.h"

#define AGENT_ANGLE M_PI/4

@interface FlockScene()

@end

@implementation FlockScene
{
    SKNode *world;
    SKSpriteNode *backgroundNode;
    SKSpriteNode *agentNode;
}

-(id)initWithSize:(CGSize)size
{
 
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        [self setupPhysicsWorld];
        [self setupNodeTree];
    }
        
    return self;
    
}

#pragma mark - Setup

-(void)setupPhysicsWorld
{
    //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    self.physicsWorld.contactDelegate = self;
}

-(void)setupNodeTree
{
    //Make world and add it to the Scene
    world = [SKSpriteNode node];
    [self addChild:world];
    
    //Make background node and add it to the world
    backgroundNode = [SKSpriteNode node];
    backgroundNode.anchorPoint = CGPointMake(0.0, 0.0);
    backgroundNode.position = self.position;
    backgroundNode.size = self.frame.size;
    [world addChild:backgroundNode];

    //Make agent node and add it to the world
    agentNode = [SKSpriteNode node];
    agentNode.position = self.position;
    [world addChild:agentNode];
}

#pragma mark - Add Bird.

-(void)addBird:(Agent *)agent
{
    [agentNode addChild:agent];
}

#pragma mark - Sprite Kit Cycle & Flock Physics

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    //Flock physics
    for(Agent *child in agentNode.children)
    {
        //Angulo aleatorio.
        CGFloat _theta =  ( random() % 360 ) * M_PI / 180;
        
        //Craziness - Movimiento Aleatorio.
        [child.physicsBody applyForce:CGVectorMake( child.craziness * cosf(_theta), child.craziness * sinf(_theta))];
        
        for (Agent *otherChild in agentNode.children)
        {
            if (child == otherChild) break;
            float dx = otherChild.position.x - child.position.x;
            float dy = otherChild.position.y - child.position.y;
            float distance = sqrt(dx * dx + dy * dy);
            float beta = atan2f(dy, dx);
            
            //Visión
            if (distance <= child.vision)
            {
                if (child.gene == otherChild.gene)
                {
                    //Cohesión
                    [child.physicsBody applyForce:CGVectorMake( child.cohesion * cosf(beta) , child.cohesion * sinf(beta) )];
                }
                //Ataque y repulsión.
                if (child.gene != otherChild.gene)
                {
                    //Criterios de fuerza
                    if (child.strength > otherChild.strength)
                    {
                        //Aggressivity
                        [child.physicsBody applyForce:CGVectorMake( child.aggressivity * cosf(beta) , child.aggressivity * sinf(beta) )];
                        //Fear
                        [otherChild.physicsBody applyForce:CGVectorMake( otherChild.fear * cosf(beta) , otherChild.fear * sinf(beta) )];
                    }
                    if (child.strength == otherChild.strength)
                    {
                        [child.physicsBody applyForce:CGVectorMake( cosf(beta + M_PI) , sinf(beta + M_PI) )];        //Repulsion a la pelea. ??? WAR COEFFICIENT/KAMIKASE
                        [otherChild.physicsBody applyForce:CGVectorMake( cosf(beta) , sinf(beta ) )];                 //Repulsion a la pelea. ???
                    }
                }                
            }
        
        }
        
        //Cambia ubicación del pajaro. Posición modular.
        if(child.position.x < 0)
        {
            child.position = CGPointMake(self.view.frame.size.width, child.position.y);
        }
        if (child.position.x > self.view.frame.size.width)
        {
            child.position = CGPointMake(0, child.position.y);
        }
        if(child.position.y < 0)
        {
            child.position = CGPointMake(child.position.x, self.view.frame.size.height);
        }
        if (child.position.y > self.view.frame.size.height)
        {
            child.position = CGPointMake(child.position.x, 0);
        }
        
        
        //Maxima velocidad
        float maximumSpeed = child.maximumSpeed;
        float vx = child.physicsBody.velocity.dx;
        float vy = child.physicsBody.velocity.dy;
        float velocity = sqrt(vx*vx + vy*vy);
        if (velocity > maximumSpeed)
        {
            [child.physicsBody setVelocity:CGVectorMake(child.physicsBody.velocity.dx / velocity * maximumSpeed,
                                                        child.physicsBody.velocity.dy / velocity * maximumSpeed)];
        }
        
        //Remueve a los muertos
        if (child.life <= 0)
        {
            if ([child actionForKey:@"Die"] == nil)
            {
                SKAction *scale = [SKAction scaleTo:0.0 duration:0.5];
                SKAction *fade = [SKAction fadeAlphaTo:0.0 duration:0.5];
                SKAction *remove = [SKAction removeFromParent];
                SKAction *scalePhysicsBody = [SKAction runBlock:^(void)
                {
                    float mass = child.physicsBody.mass;
                    int contactTestBitMask = child.physicsBody.contactTestBitMask;
                    child.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:0.1];
                    child.physicsBody.mass = mass;
                    child.physicsBody.contactTestBitMask = contactTestBitMask;
                }];
                SKAction *group = [SKAction group:@[scalePhysicsBody, scale, fade]];
                SKAction *sequence = [SKAction sequence:@[group, remove]];
                [child runAction:sequence withKey:@"Die"];
            }
        }
    }
    
    //Frequency of nodes
    //cambios en fenotipo en funcion de los parametros.
    /*
    for(Agent *child in self.agentNode.children)
    {
        child.color = [UIColor colorWithRed:1.0
                                      green:1.0 * (child.life)/100
                                       blue:1.0 * (child.life)/100
                                      alpha:1];
        child.colorBlendFactor = 1.0;
    }
    */
    
}

-(void)didSimulatePhysics
{
    for (Agent *child in agentNode.children)
    {
        //Angulo del pajaro.
        float a = atan2f(child.physicsBody.velocity.dy,child.physicsBody.velocity.dx);
        [child runAction:[SKAction rotateToAngle: a - AGENT_ANGLE duration:0.0]];
    }
}

#pragma mark - SKPhysics Contact Delegate

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    //Contacto entre agentes.
    if ([contact.bodyA.node isKindOfClass:[Agent class]] &&
        [contact.bodyB.node isKindOfClass:[Agent class]])
    {
        
        Agent *agentA = (Agent *)contact.bodyA.node;
        Agent *agentB = (Agent *)contact.bodyB.node;
        
        //Si estan vivos y tienen diferente mascara aplicar daños.
        if (agentA.physicsBody.contactTestBitMask != agentB.physicsBody.contactTestBitMask &&
            agentA.life > 0 &&
            agentB.life > 0)
        {
            agentA.life = agentA.life - agentB.strength;
            agentB.life = agentB.life - agentA.strength;
        }
        
    }
}

-(void)didEndContact:(SKPhysicsContact *)contact
{
    
}

#pragma mark - Touch Events

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        //Nacimiento
        CGPoint location = [touch locationInNode:self];
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
        [self addBird:bird];
    }
}

#pragma mark - Other Gesture Stuff

-(Agent *)nearestAgentToLocation:(CGPoint)location
{
    CGFloat minimumDistance = INFINITY;
    Agent *nearestAgent;
    for (Agent *child in agentNode.children)
    {
        CGFloat currentDistanceToChild = [self distanceBetweenPointA:location andPointB:child.position];
        minimumDistance = fmin(currentDistanceToChild, minimumDistance);
        if (currentDistanceToChild == minimumDistance)
        {
            nearestAgent = child;
        }
    }
    return nearestAgent;
}

-(CGFloat)distanceBetweenPointA:(CGPoint)PointA andPointB:(CGPoint)PointB
{
    return sqrtf((PointA.x-PointB.x)*(PointA.x-PointB.x) + (PointA.y-PointB.y)*(PointA.y-PointB.y));
}

@end
