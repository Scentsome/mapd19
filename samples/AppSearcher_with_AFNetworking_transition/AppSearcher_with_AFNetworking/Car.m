//
//  Car.m
//  AppSearcher_with_AFNetworking
//
//  Created by Michael on 09/05/2017.
//  Copyright © 2017 com.zencher.demo. All rights reserved.
//

#import "Car.h"

@implementation Car

-(BOOL) isEqual:(Car *)object{
    if([self.vendor isEqualToString:object.vendor] && self.price == object.price){
        return YES;
    }
    return NO;
}
-(NSUInteger)hash{
    return self.price;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"vendor %@: price %d ;", self.vendor, self.price];
}
@end
