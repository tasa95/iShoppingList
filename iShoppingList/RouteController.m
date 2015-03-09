//
//  RouteController.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 23/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "RouteController.h"
#import "JSonWebService.h"

@implementation RouteController





+(NSURL*) signUpRoute
{
    NSMutableString* string = [NSMutableString new];
    [string appendFormat:@"%@/signup.php",[JSonWebService getHost]];
    return [RouteController returnNSURLFromString:string];
}



+(NSURL*) loginRoute
{
    NSMutableString* string = [NSMutableString new];
    [string appendFormat:@"%@/login",[JSonWebService getHost]];
    return [RouteController returnNSURLFromString:string];
}


+(NSURL*) updateUser
{
    NSMutableString* string = [NSMutableString new];
    [string appendFormat:@"%@/users/update_user.php",[JSonWebService getHost]];
    return [RouteController returnNSURLFromString:string];
}

+(NSURL*) returnNSURLFromString:(NSString*) string
{
    NSURL * url= [[NSURL alloc ] initWithString:string];
    return url;
}

@end
