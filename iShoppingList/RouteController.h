//
//  RouteController.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 23/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RouteWebService ){
    
    RouteSignup,
    RouteLogin,
    RouteCreateShoppingList,
    RouteGetShoppingList,
    RouteEditShoppingList,
    RouteRemoveShoppingList,
    RouteCreateProduct,
    RouteListProduct,
    RouteEditProduct,
    RouteRemoveProduct,
};


@interface RouteController : NSObject

+(NSURL*) signUpRoute;
+(NSURL*) loginRoute;
+(NSURL*) updateUser;
+(NSURL*) returnNSURLFromString:(NSString*) string;
+(NSURL*) getRoute:(RouteWebService)route;

@end
