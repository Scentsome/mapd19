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
@end

@implementation CardView
-(void) unlock{
    self.isLocked = NO;
    self.layer.borderColor = [[UIColor blackColor]CGColor];
    self.layer.borderWidth = 5.0;

}
-(void) showFront{
    if(self.isLocked == YES){
        return;
    }
    self.image = self.frontImage;
}
-(void) showBack{
    if(self.isLocked == YES){
        return;
    }
    self.image = self.backImage;
}
-(void) lock{
    self.isLocked = YES;
    self.layer.borderColor = [[UIColor blueColor]CGColor];
    self.layer.borderWidth = 5.0;

}
@end
