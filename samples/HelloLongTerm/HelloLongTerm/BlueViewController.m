//
//  BlueViewController.m
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "BlueViewController.h"
#import "SecondInBlueViewController.h"


@interface BlueViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UITableView *upTableView;
@property NSArray * names;
@property id<BlueViewControllerDelegate> delegate;
@end

@implementation BlueViewController{
    SecondInBlueViewController * secondInBlueVC;
}
- (IBAction)sayHello:(id)sender {
    
    [self.delegate sendMessage:self.inputField.text];
}

- (IBAction)changeChild:(UISegmentedControl *)sender {
    
    switch ( sender.selectedSegmentIndex) {
        case 0:{
            [self transitionFromViewController:secondInBlueVC toViewController:self.childViewControllers[0] duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                
            } completion:^(BOOL finished) {
                [self.childViewControllers[0] didMoveToParentViewController:self];
                self.delegate = self.childViewControllers[0];
            }];
            break;
        }
        case 1:{
            [self transitionFromViewController:self.childViewControllers[0]  toViewController:secondInBlueVC duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                
            } completion:^(BOOL finished) {
                [secondInBlueVC didMoveToParentViewController:self];
                self.delegate = secondInBlueVC;
            }];
            
            break;
        }
        default:
            break;
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.upTableView){
        return self.names.count;
    }
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if(cell == nil ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    
    if(tableView == self.upTableView){
        cell.textLabel.text = self.names[indexPath.row];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    
    
    
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.blueLabel.text = self.dataString;
    self.names = @[@"Michael",@"James",@"Allen"];
    secondInBlueVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondInBlueVC"];
    [self addChildViewController:secondInBlueVC];
    NSLog(@"%@", self.childViewControllers);
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
