//
//  InBlueViewController.m
//  HelloLongTerm
//
//  Created by Michael on 11/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "InBlueViewController.h"

@interface InBlueViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *inbluelabel;
@property NSArray * names ;
@property NSMutableArray<NSNumber *> * checked ;
@end

@implementation InBlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    self.checked = [@[@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO,@NO] mutableCopy];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendMessage:(NSString *)blueMessage{
    self.inbluelabel.text = blueMessage;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.names.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.names[indexPath.row];
    [self configureCell:cell withIndexPath:indexPath ];
    return cell;
}
-(void) configureCell:(UITableViewCell *) theCell withIndexPath:(NSIndexPath *) theIndexPath{
    if(self.checked[theIndexPath.row].boolValue){
        theCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        theCell.accessoryType = UITableViewCellAccessoryNone;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if(self.checked[indexPath.row].boolValue){
        selectedCell.accessoryType = UITableViewCellAccessoryNone;
        self.checked[indexPath.row] = @NO;
    }else{
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.checked[indexPath.row] = @YES;
    }
    
    
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
