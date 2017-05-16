//
//  ViewController.m
//  MyChartLab
//
//  Created by Michael on 16/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
@import Charts;

@interface ViewController ()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pieChartView.delegate = self;
    self.pieChartView.noDataText = @"請加入資料";
    [self prepareData];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    NSLog(@"Did select %@",entry);
}
-(void)chartValueNothingSelected:(ChartViewBase *)chartView{
    NSLog(@"Nothing selected");
}
- (void) prepareData {
    NSDictionary * pieChartRawData = @{@"iOS 8":@84, @"iOS 7":@14, @"Earlier":@2};
    
    NSMutableArray * yValues = [NSMutableArray array];
    
    
   
    [pieChartRawData enumerateKeysAndObjectsUsingBlock:^(NSString *   key, NSNumber *   obj, BOOL *  stop) {
        PieChartDataEntry * entry = [[PieChartDataEntry alloc] initWithValue:[obj doubleValue] label:key ];
        [yValues addObject:entry];
    }];
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yValues label:@"iOS Distribution"];
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:[ChartColorTemplates joyful]];
    dataSet.colors = colors;
    
    PieChartData *pieChartData = [[PieChartData alloc] initWithDataSet:dataSet];
    
//    [pieChartData addDataSet:<#(id<IChartDataSet> _Null_unspecified)#>]
    
    self.pieChartView.data = pieChartData;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
