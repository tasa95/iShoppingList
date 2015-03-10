//
//  User.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 22/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

@interface User : NSObject <NSCoding>
{
@private
    NSString* firstname_;
    NSString* email_;
    NSString* password_;
    NSString* IdIphone_;
    NSString* token_;
    NSString* lastName_;
    
}

-(instancetype)init;

-(instancetype)initWithName:(NSString*)firstname  andLastName :(NSString*)lastName AndMailUser:(NSString*)email andPassUser:(NSString*)password andIdIphone:(NSString*)idIphone;

-(instancetype)initWithName:(NSString*)firstname AndMailUser:(NSString*)email andPassUser:(NSString*)password;

-(instancetype)initWithMailUser:(NSString*)email andPassUser:(NSString*)password;

@property(strong,nonatomic) NSString* lastName;
@property(strong, nonatomic) NSString* firstname;
@property(strong,nonatomic) NSString* email;
@property(strong,nonatomic,setter=setPassword:) NSString* password;
@property(strong,nonatomic,readonly) NSString* IdIphone;

-(NSString*)description;
-(NSData*)FormatForWebService;
-(NSString*)FormatForGet;
-(void)setPassword: (NSString*) password;
-(NSString*)getSha1:(NSString*) word;
@end
