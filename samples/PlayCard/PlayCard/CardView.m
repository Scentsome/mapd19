//
//  CardView.m
//  PlayCard
//
//  Created by Michael on 11/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "CardView.h"

@implementation CardView
-(void) showFront{
    self.image = self.frontImage;
}
-(void) showBack{
    self.image = self.backImage;
}
-(void) lock{
    
}
@end
