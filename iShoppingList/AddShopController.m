//
//  AddShopController.m
//  iShoppingList
//
//  Created by Fllo on 2/15/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "AddShopController.h"

@interface AddShopController ()

@end

@implementation AddShopController

int count_fields;
int rect_y_pos = 135;
int rect_y_height = 29;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Add new";
        UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onTouchSave)];
        self.navigationItem.rightBarButtonItem = rightButton;
        count_fields = 0;
    }
    return self;
}

- (IBAction)onTouchSave:(id)sender {
    // Save the shop, and pop to previous list
}

- (IBAction)onTouchProductAdd:(id)sender {
    // Add another textField in the list and change "+" to "-"
    if ([self.buttonManageProducts.titleLabel.text isEqual:@"+"]) {
        [self.buttonManageProducts setTitle:@"-" forState:UIControlStateNormal];
        
        [self addTextFields:count_fields];
    } else {
    // Remove the textField selected and up the position of the others...
        [self.buttonManageProducts setTitle:@"+" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setNameOfShop:nil];
    [self setProductOfShop:nil];
    [self setButtonManageProducts:nil];
    [super viewDidUnload];
}

- (void)addTextFields:(int) count {
    UITextField* productNewTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,rect_y_pos+(rect_y_height*count),252,29)];
    productNewTextField.borderStyle = UITextBorderStyleRoundedRect;
    productNewTextField.tag = count;
    productNewTextField.font = [UIFont systemFontOfSize:14];
    productNewTextField.placeholder = @"Product to buy";
    productNewTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    productNewTextField.keyboardType = UIKeyboardTypeDefault;
    productNewTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    productNewTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIButton* buttonNewAddProduct = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonNewAddProduct.frame = CGRectMake(259,rect_y_pos+(rect_y_height*count),41,29);
    [buttonNewAddProduct setTitle:@"+" forState:UIControlStateNormal];
    buttonNewAddProduct.titleLabel.textColor = [UIColor blueColor];
    
    [self.view addSubview:productNewTextField];
    [self.view addSubview:buttonNewAddProduct];
    
    count_fields++;
}

@end
