//
//  JSonWebService.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 21/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ResponseBlock)(id response,	NSError*
                             error);
typedef NS_ENUM(NSInteger, tasMethodRequest ){
    
    tasMethodRequestPost,
    tasMethodRequestPut,
    tasMethodRequestDelete,
    tasMethodRequestGet
};


@interface JSonWebService : NSObject
{
    
    
}

+ (NSURL*) host;

+ (void)startWebserviceWithURL:(NSURL*) url WithMethod:(tasMethodRequest)method withBody:(NSString*)HTTPBody responseBlock:(ResponseBlock)responseBlock;
+(NSString*)getStringTasMethodRequest:(tasMethodRequest) methodRequest;

+(void)setHost:(NSURL*) host;


@end
