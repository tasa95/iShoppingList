//
//  Token.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 10/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Token : NSObject <NSCoding>
{
  
    NSString* token_;
}

@property (nonatomic,strong) NSString* token;


-(instancetype)init;

-(instancetype) initWithTextToken:(NSString*) TextToken;

+(Token*)BuildToken;
+(Token*)BuildTokenWithText:(NSString*)textToken;
-(NSDictionary*)getDictionary;
-(NSData*)FormatForWebService;
-(NSString*)FormatForGet;

- (NSString*) filePath;
-(void) saveObject;


@end
