//
//  DetailProductViewController.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 14/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface DetailProductViewController : UIViewController <UITextViewDelegate>

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andWithProduct:(Product*)produit;

@property (strong, nonatomic) IBOutlet UITextField *LabelPrix;
@property (strong, nonatomic) IBOutlet UITextField *LabelQte;
@property (strong , nonatomic) Product* product;

- (IBAction)tapOnView:(id)sender;
- (IBAction)Modify:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *NomProduit;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
