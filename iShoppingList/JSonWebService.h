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
static  NSMutableData *responseData_;

@interface JSonWebService : NSObject <NSURLConnectionDelegate>
{
    
    
}



+ (void)startWebserviceWithURL:(NSURL*) url WithMethod:(tasMethodRequest)method withBody:(NSData*) HTTPBody Withdelegate: (id)delegate responseBlock:(ResponseBlock)responseBlock;
+(NSString*)getStringTasMethodRequest:(tasMethodRequest) methodRequest;

+(void)setHost:(NSURL*) NewHost;

+(NSURL*)getHost;


@end
