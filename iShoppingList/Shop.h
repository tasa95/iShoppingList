//
//  Shop.h
//  iShoppingList
//
//  Created by Fllo on 2/14/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop: NSObject <NSCoding> {
    @private
    NSString* id_;
    NSString* name_;
    NSDate* created_date_;
    bool completed_;
}

@property (strong,nonatomic) NSString* id;
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSDate* created_date;
@property bool completed;
@property (strong, nonatomic) NSMutableArray* productList;

-(instancetype) init;

-(instancetype) initWithId:(NSString*)id andWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date andIsCompleted:(bool) completed andWithProductList:(NSMutableArray*) productList;


-(instancetype) InitWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date andIsCompleted:(bool) completed;


-(instancetype) InitWithName :(NSString*) name andWithCreatedDate:(NSDate*) created_date;


-(instancetype) InitWithName :(NSString*) name;

@end
