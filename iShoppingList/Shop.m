//
//  Shop.m
//  iShoppingList
//
//  Created by Fllo on 2/14/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "Shop.h"

@implementation Shop

@synthesize titleOfShop = titleOfShop_;
@synthesize numberOfItems = numberOfItems_;

- (id) initWithCoder:(NSCoder *)aDecoder {
    if ( (self = [super init]) ) {
        self.titleOfShop = [aDecoder decodeObjectForKey:@"titleOfShop"];
        self.numberOfItems = [aDecoder decodeIntegerForKey:@"numberOfItems"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.titleOfShop forKey:@"titleOfShop"];
    [aCoder encodeInteger:self.numberOfItems forKey:@"numberOfItems"];
}

@end
