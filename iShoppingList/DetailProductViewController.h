//
//  DetailProductViewController.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 14/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"


@protocol DetailProductViewDelegate <NSObject, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@optional
- (void) DetailProductControllerModifyProduct:(Product*)p;



@end

@interface DetailProductViewController : UIViewController <UITextViewDelegate>
{
    @private
    id<DetailProductViewDelegate> delegate_;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andWithProduct:(Product*)produit andWithDelegate:(id)delegate andWithMode:(int)mode;

@property (strong, nonatomic) IBOutlet UITextField *LabelPrix;
@property (strong, nonatomic) IBOutlet UITextField *LabelQte;
@property (strong , nonatomic) Product* product;

- (IBAction)tapOnView:(id)sender;
- (IBAction)Modify:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *NomProduit;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
