//
//  AppDelegate.m
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "AppDelegate.h"
#import "Car.h"
#import "Rectangle.h"
#import "Engine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    Rectangle * rect = [[Rectangle alloc] init];
//    Rectangle * rect2 = rect;
    Car * car = [Car new];
    
    [car printPrice];
    [car setValue:@500 forKey:@"price"];
    NSNumber * value = [car valueForKey:@"price"];
    
    [car printPrice];
    
    Engine * en1 = [Engine new];
    [en1 setValue:@100 forKey:@"price"];
    Engine * en2 = [Engine new];
    [en2 setValue:@200 forKey:@"price"];
    Engine * en3 = [Engine new];
    [en3 setValue:@600 forKey:@"price"];
    NSArray * engines = [NSArray arrayWithObjects:en1,en2,en3, nil];
    
    NSNumber * avgValue = [engines valueForKeyPath:@"@avg.price"];
    NSLog(@"%@",avgValue);
    
    
    NSPredicate * less300 = [NSPredicate predicateWithFormat:@" price < 300"];
    less300 = [NSPredicate predicateWithBlock:^BOOL(Engine *  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSNumber * price = [evaluatedObject valueForKey:@"price"];
        if(price.integerValue < 300) {
            return  YES;
        }
        
        return NO;
    }];
    
    NSArray * result = [engines filteredArrayUsingPredicate:less300];
    NSLog(@"%@",result);
    
    NSMutableArray * mArray = [NSMutableArray new];
    
//    [mArray filterUsingPredicate:<#(nonnull NSPredicate *)#>]
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"enter back ground");
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


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"============");
    NSLog(@"Touch Began in app delegate");
}


@end
