//
//  Product.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 10/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "Product.h"

@implementation Product



-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
  
    if(self = [super init])
    {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.quantity = [aDecoder decodeIntegerForKey:@"quantity"];
        self.price = [aDecoder decodeDoubleForKey:@"price"];
        self.shopping_list_id = [aDecoder decodeObjectForKey:@"shopping_list_id"];
    
        
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.quantity forKey:@"password"];
    
    [aCoder encodeInt:self.price forKey:@"price"];
    [aCoder encodeObject:self.shopping_list_id forKey:@"shopping_list_id"];

}




@end
