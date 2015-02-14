//
//  Shop.h
//  iShoppingList
//
//  Created by Fllo on 2/14/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop: NSObject <NSCoding> {
    @private
    NSString* titleOfShop_;
    NSInteger numberOfItems_;
}

@property (nonatomic, strong) NSString* titleOfShop;
@property (nonatomic, assign) NSInteger numberOfItems;

@end
