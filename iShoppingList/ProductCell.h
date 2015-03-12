//
//  ProductCellTableViewCell.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 12/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *price;
@property (nonatomic, strong) IBOutlet UILabel *qte;

@property bool check;

- (IBAction)checkBoxSelected:(id) sender;
-(instancetype)init;
@property (strong, nonatomic) IBOutlet UIButton *button;

@end
