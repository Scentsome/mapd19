//
//  PlayCardTests.m
//  PlayCardTests
//
//  Created by Michael on 11/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CardView.h"
@interface PlayCardTests : XCTestCase

@end

@implementation PlayCardTests{
    CardView * cardView;
}

- (void)setUp {
    [super setUp];
    cardView = [CardView new];
    cardView.frontImage = [UIImage imageNamed:@"front0"];
    cardView.backImage = [UIImage imageNamed:@"back"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    cardView = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void) testShowFront{
    
    [cardView showFront];
//    if( cardView.image != cardView.frontImage){
//        NSLog(@"errror !!!!");
//    }
    
    XCTAssertEqual(cardView.image, cardView.frontImage, @"front image should be self.image");
//    XCTAssertEqualObjects(<#expression1#>, <#expression2, ...#>)
}

-(void) testShowBack{
    
    [cardView showBack];
    XCTAssertEqual(cardView.image, cardView.backImage, @"back image should be self.image");
}
-(void) testShowFrontWhenLocked {
    [cardView showBack];
    [cardView lock];
    [cardView showFront];
    
    XCTAssertEqual(cardView.image, cardView.backImage, @"back image should be self.image");
}

-(void)testShowBackWhenLocked{
    [cardView showFront];
    [cardView lock];
    [cardView showBack];
    
    XCTAssertEqual(cardView.image, cardView.frontImage, @"back image should be self.image");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
