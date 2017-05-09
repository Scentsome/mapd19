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
        NSLog(@"presenting %@", self.presentingViewController);
        NSLog(@"presented %@", self.presentedViewController);
        
        UITabBarController * tabBarVC = (UITabBarController * )self.presentingViewController;
         [self dismissViewControllerAnimated:YES completion:^{
             tabBarVC.selectedIndex = 1;
             ((UITabBarController * )self.presentingViewController).selectedIndex = 1;
         }];
    }else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Wrong A or P" message:@"Please check your account or password" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
   

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
- (IBAction)cancel:(id)sender {
    
    NSLog(@"presenting %@", self.presentingViewController);
    NSLog(@"presented %@", self.presentedViewController);
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"presenting %@", self.presentingViewController);
        NSLog(@"presented %@", self.presentedViewController);
    }];
}

@end
