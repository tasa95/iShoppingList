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
        if(error != nil)
        {
            NSLog(@"Error : %@", [error description]);
        }
        else
        {
                NSError *jsonParsingError = nil;

                response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonParsingError];
            if(jsonParsingError)
            {
                NSLog(@"ErrorJsonParsing : %@" ,[jsonParsingError description]);
            }
            
            if( [theResponse statusCode] < 100 ||  [theResponse statusCode]> 399 )
                error = [[NSError alloc] initWithDomain:[[theResponse URL] absoluteString] code:[theResponse statusCode] userInfo:response];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            responseBlock(response,error , (int)[theResponse statusCode]);
        });

    
       
     
    });
}



+ (void)startWebserviceWithURL:(NSURL *)url  withParameter:(NSString*)parameter  responseBlock:(ResponseBlock)responseBlock
{
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("JsonQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        
        
        NSMutableString *myUrl = [[NSMutableString alloc] initWithFormat: @"%@", [url absoluteString]];
        [myUrl appendFormat:parameter];
        NSURL* URL = [[NSURL alloc] initWithString:myUrl];
        
        
        
        NSLog(@"URL : %@" , URL);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
    
        request.HTTPMethod = [JSonWebService getStringTasMethodRequest:tasMethodRequestGet];
        
       
    
        
        NSError* error = nil;


        NSHTTPURLResponse * theResponse = [[NSHTTPURLResponse alloc] init];
        NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&error];
        
        
        NSDictionary* response = nil;
        if(error != nil)
        {
            NSLog(@"Error : %@", [error description]);
        }
        else
        {
            NSError *jsonParsingError = nil;
            
            response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonParsingError];
            if(jsonParsingError)
            {
                NSLog(@"ErrorJsonParsing : %@" ,[jsonParsingError description]);

            }
            
            if( [theResponse statusCode] < 100 ||  [theResponse statusCode]> 399 )
                error = [[NSError alloc] initWithDomain:[[theResponse URL] absoluteString] code:[theResponse statusCode] userInfo:response];
            
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            responseBlock(response,error , (int)[theResponse statusCode]);
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


+(bool)reactionToHTTPCode:(int)codeRetour
{
    bool DoSomething = false;

    NSString * alert ;
    switch(codeRetour)
    {
        case 0: DoSomething = true;
            break;
        case 1 : alert = [[NSString alloc] initWithFormat:@"un paramètre est manquant. \nCode :%d",codeRetour ];
            break;
        case 2:  alert = [[NSString alloc] initWithFormat:@"Compte déja existant code :%d",codeRetour ];
            
            break;
        case 3 : alert = [[NSString alloc] initWithFormat:@"connection échoué vérifiez vos identifiants code : %d",codeRetour ];
            break;
        case 4 :   alert = [[NSString alloc] initWithFormat:@"Erreur de connexion  code : %d",codeRetour ];
            break;
        case 5 : alert = [[NSString alloc] initWithFormat:@"un probleme est survenue sur nos serveurs \nVeuillez réessayer dans un moment code : %d",codeRetour ];
            break;
        case 6 :   [[NSString alloc] initWithFormat:@"un probleme est survenue sur nos serveurs \nVeuillez réessayer dans un moment code : %d",codeRetour ];
            break;
    }
    
    if(DoSomething == false)
    {
        [JSonWebService Alert:alert];
    }
    
    
    return DoSomething;

    
}



+(void )Alert:(NSString*) stringAlert
{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Erreur"
                                                     message:stringAlert
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];

    [alert show];
}


@end
