//
//  LoginViewController.m
//  AppSearcher_with_AFNetworking
//
//  Created by Michael on 09/05/2017.
//  Copyright © 2017 com.zencher.demo. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)checkID:(id)sender {
    NSString * account = self.account.text;
    NSString * passwd = self.password.text;
    BOOL accountOK = NO;
    BOOL passwdOK = NO;
    if ([account isEqualToString:@"abc"]) {
        accountOK = YES;
    }
    if ([passwd isEqualToString:@"123"]) {
        passwdOK = YES;
    }
    if (accountOK && passwdOK) {
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
        [appDelegate login];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

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
