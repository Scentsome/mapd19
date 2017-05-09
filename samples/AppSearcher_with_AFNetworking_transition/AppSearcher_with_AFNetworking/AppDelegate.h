//
//  AppDelegate.h
//  AppSearcher_with_AFNetworking
//
//  Created by roger on 2014/11/21.
//  Copyright (c) 2014年 com.zencher.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(BOOL) isLogined;
-(void) login;
-(void) logout;

@end

