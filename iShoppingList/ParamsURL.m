//
//  ParamsURL.m
//  iShoppingList
//
//  Created by ap7 on 14/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "ParamsURL.h"
#import <objc/runtime.h>

@implementation ParamsURL

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


@end
