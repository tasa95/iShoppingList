//
//  ShoppingList.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 10/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingList : NSObject <NSCoding>
{
    NSString* id_;
    NSString* name_;
    NSDate* created_date_;
    bool completed_;
}

@property (strong,nonatomic) NSString* id;
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSDate* created_date;
@property bool completed;

-(instancetype) initWithId:(NSString*)id andWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date andIsCompleted:(bool) completed;


-(instancetype) InitWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date andIsCompleted:(bool) completed;


-(instancetype) InitWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date;


-(instancetype) InitWithName :(NSString*) name;


@end
