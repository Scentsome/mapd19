//
//  ViewController.m
//  PlayCard
//
//  Created by Michael on 11/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "CardView.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *cards;

@end

@implementation ViewController

- (void)prepareData {
    
    [self.cards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CardView * cardImage = obj;
        cardImage.frontImage = [UIImage imageNamed:[NSString stringWithFormat:@"front%lu.png",(unsigned long)idx]];
    }];
    [self.cards makeObjectsPerformSelector:@selector(setBackImage:) withObject:[UIImage imageNamed:@"back"]];
    [self.cards makeObjectsPerformSelector:@selector(showFront)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
//    cards[0].backImage = [UIImage imageNamed:@"back"] ;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)change:(id)sender {
    [self.cards makeObjectsPerformSelector:@selector(changeImage)];
}


@end
