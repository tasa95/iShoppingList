//
//  JSonWebService.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 21/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "JSonWebService.h"




@implementation JSonWebService

+ (void)startWebserviceWithURL:(NSURL *)url WithMethod:(tasMethodRequest)method  withBody:(NSString*)HTTPBody responseBlock:(ResponseBlock)responseBlock
{
    
    dispatch_queue_t queue = dispatch_queue_create("JsonQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSURL* URL = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        NSData *postData =[HTTPBody dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = postData;
        NSLog(@"Url : %@", url);
        NSLog(@"Envoit : %@", HTTPBody);

        request.HTTPMethod = [JSonWebService getStringTasMethodRequest:method];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:[[NSString alloc] initWithFormat:@"%d", postData.length ] forHTTPHeaderField:@"Content-Length"];
        
         NSLog(@"Requete : %@", request);
        
        NSError* error = nil;
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
