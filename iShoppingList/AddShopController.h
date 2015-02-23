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
    id<AddShopControllerDelegate> delegate_;
}

@property (nonatomic, strong) Shop* shop;
@property (strong, nonatomic) id<AddShopControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField* nameOfShop;
@property (strong, nonatomic) IBOutlet UITextField* productOfShop;
- (IBAction)onTouchProductAdd:(id)sender;

@end
