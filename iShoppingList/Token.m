//
//  Token.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 10/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "Token.h"

@implementation Token

@synthesize token = token_;
 
    

    
    +(Token*)BuildToken
    {
        return [Token BuildTokenWithText:@""];
        
    }

+(Token*)BuildTokenWithText:(NSString*)TextToken
{
    static Token *token = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        token = [[Token alloc] initWithTextToken:TextToken];
    });
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





@end
