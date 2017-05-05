//
//  BlueViewController.m
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blueLabel.text = self.dataString;
}
- (IBAction)showSecond:(id)sender {
    UIStoryboard * secondStory = [UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil];
    
    UIViewController * firstVC = [secondStory instantiateInitialViewController];
    
    [self presentViewController:firstVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
