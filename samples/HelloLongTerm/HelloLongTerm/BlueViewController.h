//
//  BlueViewController.h
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BlueViewControllerDelegate <NSObject>

-(void) sendMessage:(NSString *) blueMessage;

@end
@interface BlueViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
@property NSString * dataString;
@end
