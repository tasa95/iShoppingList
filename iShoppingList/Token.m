//
//  Token.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 10/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "Token.h"

@implementation Token
static Token *token = nil;
@synthesize token = token_;
 
    

    
    +(Token*)BuildToken
    {
        return [Token BuildTokenWithText:@""];
        
    }

+(Token*)BuildTokenWithText:(NSString*)TextToken
{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        token = [[Token alloc] initWithTextToken:TextToken];
    });
    return token;
}

+(Token*) getToken
{
    return token;
}


-(instancetype)init
{
    return [self initWithTextToken:@""];

}

-(instancetype) initWithTextToken:(NSString*) textToken
{
    
    if(self = [super init])
    {
        self.token = textToken;
    }
    return self;
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

-(NSData*)FormatForWebService
{
    NSError *error;
    NSMutableDictionary *dictionaire = [[NSMutableDictionary alloc] init];
    
    [dictionaire setValue:[self getDictionary] forKey:@"request_datas"];
    return [NSJSONSerialization dataWithJSONObject:dictionaire options:0 error:&error];
    
    
    //mettre dictionnaire
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



    
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    
    if(self = [super init])
    {
        token_ = [aDecoder decodeObjectForKey:@"token_"];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:token_ forKey:@"token_"];
}







@end
