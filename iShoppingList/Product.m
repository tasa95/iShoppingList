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


-(NSString*)FormatForGet
{
    
    int count = 0;
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[self getDictionary]];
    NSMutableString * parameter = [[NSMutableString alloc] init];
    
    for( NSString * key in dictionary)
    {
        if(count == 0)
        {
            [parameter appendString:@"?"];
        }
        if (![dictionary valueForKey:key]) {
            [parameter appendFormat: @"%@=%@",key,@"''"];
        }
        else{
            if( !([[dictionary valueForKey:key] isKindOfClass:[NSArray class]]) || ([[dictionary valueForKey:key] isKindOfClass:[NSDictionary class]]))
            {
                if([[dictionary valueForKey:key] isKindOfClass:[NSDate class]])
                {
                    [parameter appendFormat: @"%@=%@",key,[dictionary valueForKey:key]];
                    [parameter appendString:@" "];
                    
                }
                else{
                    if([[dictionary valueForKey:key] isKindOfClass:[NSString class]])
                    {
                        NSString *string = [dictionary valueForKey:key];
                        [parameter appendFormat: @"%@=%@",key,[[ string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];
                        
                    }
                    else
                    {
                        [parameter appendFormat: @"%@=%@",key,[dictionary valueForKey:key]];
                        
                    }

                    
                    
                    
                    
                }
                
                
                
            }
            else{
                [parameter appendFormat: @"%@=''",key];
            }
        }
        
        
        
        count++;
        if(count < ([dictionary count] ))
        {
            [parameter appendString:@"&"];
        }
        
    }
    
    parameter = [parameter stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return parameter;
}


-(NSData*)FormatForWebService
{
    NSError *error;
    NSMutableDictionary *dictionaire = [[NSMutableDictionary alloc] init];
    
    [dictionaire setValue:[self getDictionary] forKey:@"request_datas"];
    return [NSJSONSerialization dataWithJSONObject:dictionaire options:0 error:&error];
    
    
    //mettre dictionnaire
}


-(NSDictionary*)getDictionary
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class ], &count);
    
    for (int i = 0; i < count; i++) {
        
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if([self valueForKey:key])
        {
            [dict setObject:[self valueForKey:key] forKey:key];
        }
    }
    
    free(properties);
    return dict;
}





@end
