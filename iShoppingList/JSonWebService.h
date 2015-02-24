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
static NSURL* host;

@interface JSonWebService : NSObject
{
    
    
}



+ (void)startWebserviceWithURL:(NSURL*) url WithMethod:(tasMethodRequest)method withBody:(NSData*) HTTPBody responseBlock:(ResponseBlock)responseBlock;
+(NSString*)getStringTasMethodRequest:(tasMethodRequest) methodRequest;

+(void)setHost:(NSURL*) NewHost;

+(NSURL*)getHost;


@end
