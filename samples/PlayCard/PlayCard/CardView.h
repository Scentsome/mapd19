//
//  CardView.h
//  PlayCard
//
//  Created by Michael on 11/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIImageView
@property UIImage * frontImage;
@property UIImage * backImage;
-(void) showFront;
-(void) showBack;
-(void) lock;
@end
