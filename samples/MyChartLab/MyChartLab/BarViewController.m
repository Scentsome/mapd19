//
//  BarViewController.m
//  MyChartLab
//
//  Created by Michael on 16/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "BarViewController.h"
@import Charts;
@interface BarViewController ()
@property (weak, nonatomic) IBOutlet BarChartView *barChartView;

@end

@implementation BarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarData];
    // Do any additional setup after loading the view.
}

-(void) setupBarData {
    NSArray * values = @[@20.0, @4.0, @6.0, @3.0, @12.0, @16.0, @4.0, @18.0, @2.0, @4.0, @5.0, @4.0];
    
    NSMutableArray * dataEntries = [NSMutableArray array];
    
    [values enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        BarChartDataEntry * dataEntry = [[BarChartDataEntry alloc] initWithX:idx y:obj.doubleValue ];
        [dataEntries addObject:dataEntry];
    }];
    
    BarChartDataSet * dataSet = [[BarChartDataSet alloc] initWithValues:dataEntries label:@"Units Sold"];
    BarChartData * barChartData = [[BarChartData alloc] initWithDataSets:@[dataSet]];
    self.barChartView.data = barChartData;
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
