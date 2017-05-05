//
//  ViewController.m
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UITextField *input2;
@property (weak, nonatomic) IBOutlet UITextField *input1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myButton addTarget:self action:@selector(hello:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void) hello:(UIButton * ) sender  {
    sender.enabled = NO;
    NSLog(@"%@", sender);
}
-(void) hello {
    NSLog(@"Hello button");
}
- (IBAction)changeLabel:(id)sender {
    [self.labels makeObjectsPerformSelector:@selector(setText:) withObject:@"Changed"];
    
    NSString * text1 = self.input1.text ;
    NSString * text2 = self.input2.text;
    NSInteger value1 = [text1 integerValue];
    NSInteger value2 = [text2 integerValue];
    NSString * result = [NSString stringWithFormat:@"%ld",(value1 + value2)];
    
    self.resultLabel.text = result;
    NSLog(@"%@",result);
}

- (IBAction)changeSliderValue:(UISlider *)sender {
    
    NSLog(@"%.2f",sender.value);
    
    self.resultLabel.text = [NSString stringWithFormat:@"%.2f", sender.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pickDate:(UIDatePicker *)sender {
    
    NSLog(@"%@", sender.date);
    
//    self.resultLabel.text = [NSString stringWithFormat:@"%@", sender.date];
    
//    [sender.date timeIntervalSince1970];
    
    NSDateFormatter * formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    self.resultLabel.text = [formatter stringFromDate:sender.date];
}
-(IBAction) home:(UIStoryboardSegue *)sender {
    
}

@end
