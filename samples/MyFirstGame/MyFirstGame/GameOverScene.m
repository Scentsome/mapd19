//
//  GameOverScene.m
//  MyFirstGame
//
//  Created by Michael on 16/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene
//  GameOverScene.h
-(id) initWithSize:(CGSize)size win:(BOOL) winORlose{
    self = [super initWithSize:size];
    if (self != nil){
        
        self.backgroundColor = [SKColor whiteColor];
        NSString * message = winORlose ? @"You Win" : @"You Lose";
        
        SKLabelNode  * label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:label];
        
        [self runAction:[SKAction sequence:@[[SKAction waitForDuration:3.0], [SKAction runBlock:^{
            SKTransition * reveal = [SKTransition flipHorizontalWithDuration:0.5];
            GameScene * scene = [GameScene sceneWithSize:size];
            [self.view presentScene:scene transition:reveal];
            
        }]]]];
    }
    return self;
}
@end
