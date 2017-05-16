//
//  ViewController.m
//  UserNotificationDemo
//
//  Created by Michael on 16/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
@import UserNotifications;

@interface ViewController ()<UNUserNotificationCenterDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;

    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!granted) {
                                  NSLog(@"Something went wrong");
                              }
                          }];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Don't forget";
    content.body = @"Buy Nintendo Switch";
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3600];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components:NSCalendarUnitDay +
                                     NSCalendarUnitHour +
                                     NSCalendarUnitMinute +

                                     NSCalendarUnitSecond fromDate:date];
    
    
    
    UNCalendarNotificationTrigger * calTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:YES];
    NSString *identifier = @"ZenLocalNotification";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:calTrigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
    
    center.delegate = self;
    
//    [center removePendingNotificationRequestsWithIdentifiers:<#(nonnull NSArray<NSString *> *)#>];
    
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    
    NSLog(@"received notifcation");
    completionHandler();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
