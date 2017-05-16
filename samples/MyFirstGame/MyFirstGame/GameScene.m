//
//  GameScene.m
//  MyFirstGame
//
//  Created by Michael on 16/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//
#define none            0
#define allObject       UINT32_MAX
#define theMonster      0b1
#define theProjectile   0b10
#import "GameScene.h"
#import "GameOverScene.h"

#import <AVFoundation/AVFoundation.h>

@interface GameScene()<SKPhysicsContactDelegate>
@property (nonatomic) SKSpriteNode * player;
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;

@end
@implementation GameScene {
    NSInteger monsterDestoryed;
}
//  GameScene.m
-(void) playBackgroundMusic:(NSString *) theFilename{
    NSURL * url = [[NSBundle mainBundle] URLForResource:theFilename withExtension:nil];
    if (url == nil) {
        NSLog(@"Couldn't find file: %@", theFilename);
        return ;
    }
    NSError * error ;
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (self.backgroundMusicPlayer == nil) {
        NSLog(@"Could not create audio player: %@", error);
        return;
    }
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
}
//  GameScene.m
-(CGPoint) addFromLeft:(CGPoint)left andRight:(CGPoint) right{
    return CGPointMake((left.x + right.x), (left.y + right.y));
}

-(CGPoint) minusFromLeft:(CGPoint)left andRight:(CGPoint) right{
    return CGPointMake((left.x - right.x), (left.y - right.y));
}

-(CGPoint) timeFromPoint:(CGPoint)point withScalar:(CGFloat) scalar{
    return CGPointMake((point.x * scalar), (point.y *scalar));
}

-(CGPoint) divideFromPoint:(CGPoint)point withScalar:(CGFloat) scalar{
    return CGPointMake((point.x / scalar), (point.y / scalar));
}

//  GameScene.m
-(CGFloat) sqrt:(CGFloat) a{
    return (CGFloat) sqrtf((float) a);
}

-(CGFloat) length:(CGPoint) point{
    return sqrt(point.x * point.x + point.y * point.y);
}

-(CGPoint) normalized:(CGPoint) point{
    CGFloat pointLength = [self length:point];
    CGPoint newPoint = CGPointMake(point.x/pointLength, point.y/pointLength);
    return newPoint;
}

-(CGFloat) random{
    CGFloat randomFloat =((float)arc4random())/0xFFFFFFFF;
    return randomFloat;
}


-(CGFloat) random:(CGFloat)theMin toMax:(CGFloat)theMax{
    
    return [self random]* (theMax - theMin) + theMin;
}

//  GameScene.m
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = (UITouch*)[touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    SKSpriteNode * projectile = [[SKSpriteNode alloc] initWithImageNamed:@"projectile"];
    projectile.position = self.player.position;
    
    projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width/2];
    projectile.physicsBody.dynamic = YES;
    projectile.physicsBody.categoryBitMask = theProjectile;
    projectile.physicsBody.contactTestBitMask = theMonster;
    projectile.physicsBody.collisionBitMask = none;
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
    
    CGPoint offset = CGPointMake(touchLocation.x - projectile.position.x, touchLocation.y - projectile.position.y);
    
    if (offset.x < 0) {
        return ;
    }
    
    [self addChild:projectile];
    
    CGPoint direction = [self normalized:offset];
    CGPoint shootAmount = CGPointMake(direction.x * 1000, direction.y *1000);
    CGPoint realDest = CGPointMake(shootAmount.x + projectile.position.x, shootAmount.y + projectile.position.y);
    
    SKAction * actionMove = [SKAction moveTo:realDest duration:2.0];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    
    [projectile runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}
//  GameScene.m
-(void) addMonster{
    // Create sprite
    SKSpriteNode * monster = [[SKSpriteNode alloc] initWithImageNamed:@"monster"];
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: monster.size];
    monster.physicsBody.dynamic = YES;
    monster.physicsBody.categoryBitMask = theMonster;
    monster.physicsBody.contactTestBitMask = theProjectile;
    monster.physicsBody.collisionBitMask = none;
    // Determine where to spawn the monster along the Y axis
    CGFloat actualY = [self random:monster.size.height/2 toMax:(self.size.height-monster.size.height/2)];
    
    // Position the monster slightly off-screen along the right edge
    // and along a random position along the Y axis as calculated above
    monster.position = CGPointMake(self.size.width + monster.size.width/2, actualY);
    
    // Add the monster to the scene
    [self addChild:monster];
    
    CGPoint moveTo = CGPointMake(-(monster.size.width/2), actualY);
    
    // Determine speed of the monster
    CGFloat actualDuration = [self random:(CGFloat)2.0 toMax:(CGFloat)4.0];
    
    SKAction * actionMove = [SKAction moveTo:moveTo duration:(NSTimeInterval) actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    
    SKAction * loseAction = [SKAction runBlock:^{
        SKTransition * reveal = [SKTransition flipHorizontalWithDuration:0.5];
        
        GameOverScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size win:false];
        [self.view presentScene:gameOverScene transition:reveal];
    }];

    
    [monster runAction:[SKAction sequence:@[actionMove,loseAction,actionMoveDone]]];
}

- (void)didMoveToView:(SKView *)view {
    [self playBackgroundMusic:@"background-music-aac.caf"];

//    self.physicsWorld.gravity = CGVectorMake(0, -9);
    self.backgroundColor = [SKColor whiteColor];
    
    self.player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
    
    self.player.position = CGPointMake(50, self.size.height/2);
    [self addChild:self.player];
    
//    self.player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:3.0];
    
    [self.player runAction:[SKAction repeatActionForever:[SKAction sequence:@[ [SKAction runBlock:^{
        [self addMonster];
    }],[SKAction waitForDuration:1.0]]]]];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;

//    SKAction * moveAction = [SKAction moveTo:CGPointMake(100, 100) duration:2.0];
//    
//    [self.player runAction:moveAction];
}

-(void) projectileDidCollideWithMonster:(SKSpriteNode*) projectile toMonster:(SKSpriteNode*) monster{
    
    // remove the projectile and monster from the scene when they
    // collide
    NSLog(@"Hit");
    
    monsterDestoryed ++;
    
    if (monsterDestoryed > 3) { // kill over 30 monster get win
        SKTransition * reveal = [SKTransition flipHorizontalWithDuration:0.5];
        GameOverScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size win:true];
        [self.view presentScene:gameOverScene transition:reveal];
    }

    [projectile removeFromParent];
    [monster removeFromParent];
}
// GameScene.m
// contact delegate method
-(void) didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody * firstBody;
    SKPhysicsBody * secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (((firstBody.categoryBitMask & theMonster) != 0) && ((secondBody.categoryBitMask & theProjectile) != 0)) {
        [self projectileDidCollideWithMonster:(SKSpriteNode *) firstBody.node toMonster:(SKSpriteNode*) secondBody.node];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Run 'Pulse' action from 'Actions.sks'
    [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:false]];

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    }

- (void)touchesCancelled:(NSSet *)touches{
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
