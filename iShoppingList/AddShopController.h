//
//  AddShopController.h
//  iShoppingList
//
//  Created by Fllo on 2/15/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddShopController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameOfShop;
@property (weak, nonatomic) IBOutlet UITextField *productOfShop;

- (IBAction)onTouchProductAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonManageProducts;

@end
