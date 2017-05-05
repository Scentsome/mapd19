//
//  SecondViewController.m
//  HelloLongTerm
//
//  Created by Michael on 05/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "SecondViewController.h"
#import "BlueViewController.h"
@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SecondViewController{
//    UIView * blueView;
}
- (IBAction)moveView:(id)sender {
    
//    [UIView animateWithDuration:1.0 animations:^{
//        self.contentView.center = CGPointMake(100,100);
//        
//    
//    }];
//    
    [UIView animateWithDuration:1.0 animations:^{
        self.contentView.center = CGPointMake(100,100);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.contentView.center = CGPointMake(200,300);
        } completion:nil];
        
    }];
    
    
    
}
- (IBAction)addView:(id)sender {
    
    UIView * blueView = [UIView new];
    blueView.tag = 11;
    blueView.frame = CGRectMake(100, 100, 120, 30);
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
}
- (IBAction)removeView:(id)sender {
    UIView * blueView = [self.view viewWithTag:11];
    [blueView removeFromSuperview];
    
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

//-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"============");
//    NSLog(@"Touch Began in view controller");
//}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"segue %@",segue.identifier);
    
    if([segue.identifier isEqualToString:@"Second2Blue"]){
        BlueViewController * blueVC =  segue.destinationViewController;
        
//        blueVC.blueLabel.text = @"Hello";
        blueVC.dataString = @"Hello";
    }
}

@end
