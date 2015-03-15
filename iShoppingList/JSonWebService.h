//
//  JSonWebService.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 21/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ResponseBlock)(id response,	NSError*
                             error,int codeResponse);
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

+ (void)startWebserviceWithURL:(NSURL *)url  withParameter:(NSString*)parameter  responseBlock:(ResponseBlock)responseBlock;

+ (void)startWebserviceWithURL:(NSURL*) url WithMethod:(tasMethodRequest)method withBody:(NSData*) HTTPBody Withdelegate: (id)delegate responseBlock:(ResponseBlock)responseBlock;
+(NSString*)getStringTasMethodRequest:(tasMethodRequest) methodRequest;

+(void)setHost:(NSURL*) NewHost;

+(NSURL*)getHost;
+(bool)reactionToHTTPCode:(int)codeRetour;
+(void )Alert:(NSString*) stringAlert;
+(bool)ManageError:(id)response;
@end
