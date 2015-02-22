//
//  User.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 22/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>
{
@private
    NSString* UserName_;
    NSString* mailUser_;
    NSString* passUser_;
    NSString* IdIphone_;
}

-(instancetype)init;

-(instancetype)initWithName:(NSString*)UserName AndMailUser:(NSString*)mailUser andPassUser:(NSString*)passUser andIdIphone:(NSString*)idIphone;

-(instancetype)initWithName:(NSString*)UserName AndMailUser:(NSString*)mailUser andPassUser:(NSString*)passUser;

-(instancetype)initWithMailUser:(NSString*)mailUser andPassUser:(NSString*)passUser;


@property(strong, nonatomic) NSString* UserName;
@property(strong,nonatomic) NSString* mailUser;
@property(strong,nonatomic) NSString* passUser;
@property(strong,nonatomic,readonly) NSString* IdIphone;

-(NSString*)description;


@end
