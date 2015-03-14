//
//  ShopCell.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 14/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *NameShopLabel;
@property (strong, nonatomic) IBOutlet UILabel *DateCreationLabel;
@property (strong, nonatomic) IBOutlet UILabel *TotalPriceOfShop;

@end
