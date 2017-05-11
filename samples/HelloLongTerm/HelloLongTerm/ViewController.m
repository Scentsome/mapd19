//
//  ViewController.m
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate>
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UITextField *input2;
@property (weak, nonatomic) IBOutlet UITextField *input1;

@end

@implementation ViewController
- (IBAction)presentPop:(UIButton *)sender {
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GrayVC"];
    
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.preferredContentSize = CGSizeMake(50, 50);

    UIPopoverPresentationController * popPC = vc.popoverPresentationController;
    
    popPC.sourceRect = sender.frame;
    popPC.sourceView = self.view;
    popPC.permittedArrowDirections = UIPopoverArrowDirectionUp;
    
    
    popPC.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];

}


-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return  UIModalPresentationNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myButton addTarget:self action:@selector(hello:) forControlEvents:UIControlEventTouchUpInside];
    
    NSURLComponents * components = [[NSURLComponents alloc ] init];
    components.scheme = @"http";
    components.host = @"itunes.apple.com";
    components.path = @"/search";
    components.query = @"term=周杰倫&country=tw";
    NSString * encodedString = [components.query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@", encodedString);
    
    
    
    
    NSURLComponents * myComs = [[NSURLComponents alloc ] initWithString:@"https://github.com/dekatotoro/SlideMenuControllerSwift"];
    
    NSLog(@"%@", myComs.path);
    
    
    NSNotificationCenter * defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"did enter background in view controller");
    }];
    
    [defaultCenter addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"%@",note.userInfo);
    }];
    
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepare segure in View Controller");
}

@end
