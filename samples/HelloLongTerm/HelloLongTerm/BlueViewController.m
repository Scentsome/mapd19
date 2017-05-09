//
//  BlueViewController.m
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *upTableView;
@property NSArray * names;
@end

@implementation BlueViewController


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
