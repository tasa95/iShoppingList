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



+(NSURL*) getRoute:(RouteWebService)route
{
    NSMutableString* string = [NSMutableString new];
    switch(route)
    {
        case RouteSignup: [string appendFormat:@"%@/account/subscribe.php",[JSonWebService getHost]];
            break;
        case RouteLogin: [string appendFormat:@"%@/account/login.php",[JSonWebService getHost]];
            break;
        case RouteCreateShoppingList: [string appendFormat:@"%@/shopping_list/create.php",[JSonWebService getHost]];
            break;
        case RouteGetShoppingList: [string appendFormat:@"%@/shopping_list/list.php",[JSonWebService getHost]];
            break;
        case RouteEditShoppingList: [string appendFormat:@"%@/shopping_list/edit.php",[JSonWebService getHost]];
            break;
            
        case RouteRemoveShoppingList: [string appendFormat:@"%@/shopping_list/remove.php",[JSonWebService getHost]];
            break;
        case RouteCreateProduct: [string appendFormat:@"%@/product/create.php",[JSonWebService getHost]];
            break;
        case RouteListProduct: [string appendFormat:@"%@/product/list.php",[JSonWebService getHost]];
            break;
        case RouteEditProduct: [string appendFormat:@"%@/product/edit.php",[JSonWebService getHost]];
            break;
        case RouteRemoveProduct: [string appendFormat:@"%@/product/remove.php",[JSonWebService getHost]];
            break;
            
    }
    
    return [RouteController returnNSURLFromString:string];
    
}






+(NSURL*) returnNSURLFromString:(NSString*) string
{
    NSURL * url= [[NSURL alloc ] initWithString:string];
    return url;
}

@end
