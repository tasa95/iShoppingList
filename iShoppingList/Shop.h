//
//  Shop.h
//  iShoppingList
//
//  Created by Fllo on 2/14/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParamsURL.h"

@interface Shop: ParamsURL{
    @private
    NSString* id_;
    NSString* name_;
    NSDate* created_date_;
    bool completed_;
    double total_price_ ;
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

-(void) setTotal_price:(double)total_price;

-(double)getTotal_price;

- (NSString*) filePath ;

-(void) saveObject;
-(NSString*)FormatForGet;
-(NSData*)FormatForWebService;
-(NSDictionary*)getDictionary;

-(void) calculateTotalPrice;

@end
