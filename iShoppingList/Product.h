//
//  Product.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 10/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSCoding>
{
    NSString* id_;
    NSString* name_;
    int quantity_;
    double price_;
    NSString* shopping_list_id_;
}

-(instancetype)init;

-(instancetype)initWithId :(NSString*)id andWithName:(NSString*)name andWithQuantity:(int)quantity andWithPrice:(double)price andWithShoppingListId:(NSString*)shopping_list_id;


-(instancetype)initWithName:(NSString*)name andWithQuantity:(int)quantity andWithPrice:(double)price;

@property (strong,nonatomic) NSString* id;
@property (strong,nonatomic) NSString* name;
@property (nonatomic) int quantity;
@property (nonatomic) double price;
@property (strong, nonatomic) NSString* shopping_list_id;


@end
