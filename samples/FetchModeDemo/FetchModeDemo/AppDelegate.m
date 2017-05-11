//
//  AppDelegate.m
//  FetchModeDemo
//
//  Created by chronoer on 13/10/11.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIApplication*    app = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier bgTask ;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
        
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        while (YES) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"Time remaining: %f",[app backgroundTimeRemaining]);
        }
        
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
        
    });
}
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:
(void (^)(UIBackgroundFetchResult result)) completionHandler {
    ViewController * vc = (ViewController *)self.window.rootViewController;
    
    [vc populateDataWithCompletionHandler:completionHandler];
}

-(void) application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler{
    NSLog(@"handle event");
    NSDictionary* userInfo = @{@"completionHandler" : completionHandler,
                               @"sessionIdentifier" : identifier};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackgroundTransferNotification" object:nil userInfo:userInfo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
