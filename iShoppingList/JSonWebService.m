//
//  JSonWebService.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 21/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "JSonWebService.h"




@implementation JSonWebService

+ (void)startWebserviceWithURL:(NSURL *)url WithMethod:(tasMethodRequest)method  withBody:(NSData*)HTTPBody responseBlock:(ResponseBlock)responseBlock
{
    
    dispatch_queue_t queue = dispatch_queue_create("JsonQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSURL* URL = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        

        request.HTTPMethod = [JSonWebService getStringTasMethodRequest:method];
        
        
        
        NSData * JsonData =HTTPBody;
        request.HTTPBody = HTTPBody;
       
        [request setValue:[[NSString alloc] initWithFormat:@"%d", JsonData.length ] forHTTPHeaderField:@"Content-length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError* error = nil;
        [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        
  
        NSLog(@"request : %@\n", request);
        NSLog(@"Method : %@\n", request.HTTPMethod);
        NSLog(@"url : %@\n", request.URL);
        NSLog(@"Body data : %@\n", request.HTTPBody);
        NSLog(@"Body inclear : %@\n", [[NSString alloc ]initWithData:JsonData encoding:NSUTF8StringEncoding]);
        NSLog(@"httpHeaderFields : %@\n", request.allHTTPHeaderFields);
        
        NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSDictionary* response = nil;
        if(!error)
        {
            response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
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
