//
//  RouteController.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 23/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteController : NSObject

+(NSURL*) signUpRoute;
+(NSURL*) loginRoute;
+(NSURL*) updateUser;
+(NSURL*) returnNSURLFromString:(NSString*) string;

@end
