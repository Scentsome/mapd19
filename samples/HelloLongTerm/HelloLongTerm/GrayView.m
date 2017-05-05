//
//  GrayView.m
//  HelloLongTerm
//
//  Created by Michael on 05/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "GrayView.h"

@implementation GrayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"============");
//    NSLog(@"Touch Began");
//}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Moved");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Ended");
    NSLog(@"============");
}

@end
