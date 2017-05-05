//
//  MyDelegate.m
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "MyDelegate.h"

@implementation MyDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"app launched");
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor blueColor];
    
    [self.window makeKeyAndVisible];
    UIStoryboard * mainStroryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController * firstVC = [mainStroryBoard instantiateInitialViewController];
    firstVC.view.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = firstVC;
    
    return YES;
}
@end
