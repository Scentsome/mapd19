//
//  ViewController.h
//  FetchModeDemo
//
//  Created by chronoer on 13/10/11.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (void)populateDataWithCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler;
@end
