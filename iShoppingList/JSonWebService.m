//
//  JSonWebService.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 21/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "JSonWebService.h"




@implementation JSonWebService

+ (void)startWebserviceWithURL:(NSURL *)url WithMethod:(tasMethodRequest)method  withBody:(NSData*)HTTPBody Withdelegate:(id) delegate responseBlock:(ResponseBlock)responseBlock
{
    


    dispatch_queue_t queue = dispatch_queue_create("JsonQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSURL* URL = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        

        request.HTTPMethod = [JSonWebService getStringTasMethodRequest:method];
        
        
        
        NSData * JsonData =HTTPBody;
        request.HTTPBody = HTTPBody;
       
        [request setValue:[[NSString alloc] initWithFormat:@"%d", JsonData.length ] forHTTPHeaderField:@"Content-length"];

        NSError* error = nil;
       [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        

        NSHTTPURLResponse * theResponse = [[NSHTTPURLResponse alloc] init];
        NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&error];

   
        NSDictionary* response = nil;
        if(error)
        {
            NSLog(@"Error : %@", [error description]);
        }
        else
        {
                NSError *jsonParsingError = nil;

                response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonParsingError];
            if(jsonParsingError)
            {
                NSLog([jsonParsingError description]);
            }
            
            if( [theResponse statusCode] < 100 ||  [theResponse statusCode] >= 400)
                error = [[NSError alloc] initWithDomain:[theResponse URL] code:[theResponse statusCode] userInfo:response];
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            responseBlock(response,error);
        });

    
       
     
    });


      
}

+(NSString*)getStringTasMethodRequest:(tasMethodRequest) methodRequest
{
    
    switch(methodRequest)
    {
        case tasMethodRequestDelete: return @"DELETE";
            break;
        case tasMethodRequestGet : return @"GET";
            break;
            
        case tasMethodRequestPost : return @"POST";
            break;
            
        case tasMethodRequestPut : return @"PUT";
            break;
    }
}

+(void)setHost:(NSURL*) NewHost
{
    if(host != NewHost) {
        host = NewHost;
    }
}

+(NSURL*)getHost
{
    return host;
}




@end
