//
//  Shop.m
//  iShoppingList
//
//  Created by Fllo on 2/14/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "Shop.h"
#import <objc/runtime.h>

@implementation Shop


@synthesize name = name_;
@synthesize created_date = created_date_;
@synthesize completed = completed_;
@synthesize id = id_;


-(instancetype) init
{
    return  [self initWithId:@"" andWithName :@"" andWithCreatedDate:[NSDate new] andIsCompleted:NO  andWithProductList:[NSMutableArray new]];
}


-(instancetype) InitWithName :(NSString*) name;
{
    return [self initWithId:@"" andWithName:name andWithCreatedDate:[[NSDate alloc] init] andIsCompleted:NO andWithProductList:[[NSMutableArray alloc] init]];
}



-(instancetype) InitWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date;
{
    
    return [self initWithId:@"" andWithName:name andWithCreatedDate:created_date andIsCompleted:NO andWithProductList:[[NSMutableArray alloc] init]];
}



-(instancetype) InitWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date andIsCompleted:(bool) completed
{
    
    return [self initWithId:@"" andWithName:name andWithCreatedDate:created_date andIsCompleted:completed andWithProductList:[[NSMutableArray alloc] init]];
}


-(instancetype) initWithId:(NSString*)id andWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date andIsCompleted:(bool) completed andWithProductList:(NSMutableArray*) productList
{
    if(self = [super init])
    {
        self.id = id;
        self.name = name;
        self.created_date = created_date;
        self.completed = completed;
        self.productList = productList;
        total_price_ = 0;
    }
    return self;
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
        [parameter appendFormat: @"%@=%@",key,[dictionary valueForKey:key]];
        count++;
        if(count < ([dictionary count] ))
        {
            [parameter appendString:@"&"];
        }
        
    }
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
        [dict setObject:[self valueForKey:key] forKey:key];
    }
    
    free(properties);
    return dict;
}



-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.created_date = [aDecoder decodeObjectForKey:@"created_date"];
        self.completed = [aDecoder decodeObjectForKey:@"completed"];
        
        
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.created_date forKey:@"created_date"];
    [aCoder encodeBool:self.completed forKey:@"completed"];
    
}

-(void) setTotal_price:(double)total_price
{
    total_price_ = total_price;
}

-(double)getTotal_price
{

    return total_price_;
}


@end
