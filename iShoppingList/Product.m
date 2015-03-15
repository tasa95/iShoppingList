//
//  Product.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 10/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "Product.h"
#import <objc/runtime.h>

@implementation Product

@synthesize name = name_;
@synthesize id = id_;
@synthesize quantity = quantity_;
@synthesize price = price_;
@synthesize shopping_list_id = shopping_list_id_;


-(instancetype)init
{
    return [self initWithId:@"" andWithName:@"" andWithQuantity:0 andWithPrice:0 andWithShoppingListId:@""];
}

-(instancetype)initWithId :(NSString*)id andWithName:(NSString*)name andWithQuantity:(int)quantity andWithPrice:(double)price andWithShoppingListId:(NSString*)shopping_list_id
{
    if(self = [super init])
    {
        self.id = id;
        self.name = name;
        self.quantity = quantity;
        self.price = price;
        self.shopping_list_id = shopping_list_id;
    }
    return self;
}




-(instancetype)initWithName:(NSString*)name andWithQuantity:(int)quantity andWithPrice:(double)price
{
    return [self initWithId:@"" andWithName:name andWithQuantity:quantity andWithPrice:price andWithShoppingListId:@""];
}

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

- (NSString*) filePath {
    NSArray* docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docPath = [docPaths objectAtIndex:0];
    NSLog(@"%@", docPath);
    return [docPath stringByAppendingPathComponent:@"product.archive"];
}

-(void) saveObject {
    [NSKeyedArchiver archiveRootObject:self toFile:[self filePath]];
}






@end
