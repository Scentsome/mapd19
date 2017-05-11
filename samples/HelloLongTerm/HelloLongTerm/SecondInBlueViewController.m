//
//  SecondInBlueViewController.m
//  HelloLongTerm
//
//  Created by Michael on 11/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "SecondInBlueViewController.h"

@interface SecondInBlueViewController ()
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@end

@implementation SecondInBlueViewController

-(void)sendMessage:(NSString *)blueMessage{
    self.secondLabel.text = blueMessage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
