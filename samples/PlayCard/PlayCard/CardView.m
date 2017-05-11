//
//  CardView.m
//  PlayCard
//
//  Created by Michael on 11/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "CardView.h"

@interface CardView()
@property BOOL isLocked;
@property BOOL isFront;
@end

@implementation CardView
-(void) unlock{
    self.isLocked = NO;
    self.layer.borderColor = [[UIColor blackColor]CGColor];
    self.layer.borderWidth = 1.0;

}
-(void) showFront{
    if(self.isLocked == YES){
        return;
    }
    self.image = self.frontImage;
    self.isFront = YES;
}
-(void) showBack{
    if(self.isLocked == YES){
        return;
    }
    self.image = self.backImage;
    self.isFront = NO;
}
-(void) lock{
    self.isLocked = YES;
    self.layer.borderColor = [[UIColor blueColor]CGColor];
    self.layer.borderWidth = 5.0;

}
-(void)changeImage{
    if(self.isFront){
        [self showBack];
    }else{
        [self showFront];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.isLocked){
        [self unlock];
    }else{
        [self lock];
    }
}
@end
