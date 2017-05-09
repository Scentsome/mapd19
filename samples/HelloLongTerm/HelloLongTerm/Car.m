//
//  Car.m
//  HelloLongTerm
//
//  Created by Michael on 03/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "Car.h"

@implementation Car
{
    int price;
    int _price;
}
////{
////    int _price;
////}
-(void) setPrice:(int) aPrice{
    NSLog(@"Hello set price");
}
////-(int) price{
////    return _price;
////}
//
//-(void) printPrice {
//    NSLog(@"price right now %d", _price);
//}
-(void) printPrice{
    NSLog(@"price is %d", price);
}
@end
