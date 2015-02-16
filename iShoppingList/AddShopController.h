//
//  AddShopController.h
//  iShoppingList
//
//  Created by Fllo on 2/15/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"


@protocol AddShopControllerDelegate <NSObject>
@optional
- (void) addShoppingControllerDidCreateShop:(Shop*)s;
- (void) addShoppingControllerDidEditShop:(Shop *)s;
@end

@interface AddShopController : UIViewController {
    @private
    Shop* shop_;
    __weak id<AddShopControllerDelegate> delegate_;
}

@property (nonatomic, strong) Shop* shop;
@property (weak, nonatomic) id<AddShopControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField* nameOfShop;
@property (weak, nonatomic) IBOutlet UITextField* productOfShop;

@end
