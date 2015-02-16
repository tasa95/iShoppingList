//
//  AddShopController.m
//  iShoppingList
//
//  Created by Fllo on 2/15/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AddShopController.h"

@interface AddShopController ()

@end

@implementation AddShopController


//-----------


int count_items;
int rect_y_pos = 135, rect_y_height = 29;


//-----------


@synthesize shop = shop_;
@synthesize delegate = delegate_;


//-----------


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Add list";
        UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onTouchSave:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        count_items = 0;
    }
    return self;
}


//-----------


- (IBAction)onTouchSave:(id) sender
{
    // Save the shop, and pop to previous list
    Shop* newshop = [Shop new];
    newshop.titleOfShop = self.nameOfShop.text;
    if ([self.delegate respondsToSelector:@selector(addShoppingControllerDidCreateShop:)]) {
        [self.delegate addShoppingControllerDidCreateShop:newshop];
    }
}

- (IBAction)onTouchProductAdd:(id) sender
{
    if (self.productOfShop.text && self.productOfShop.text.length > 0 && ![self.productOfShop.text isEqual:@" "])
        [self addShopItem:(int) count_items];
}

- (void)checkBoxSelected:(id) sender
{
    UIButton* check = (UIButton*) sender;
    if (check.tag == 0) {
        [check setSelected:true];
        check.tag = 1;
    } else {
        [check setSelected:false];
        check.tag = 0;
    }
}


//-----------


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
    [super viewDidUnload];
}


//-----------


- (void)addShopItem:(int) i
{
    UILabel* newLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, rect_y_pos+(rect_y_height*i)+10, 242, 29)];
    newLabel.text = self.productOfShop.text;
    newLabel.font = [UIFont systemFontOfSize:14];
    newLabel.textAlignment = NSTextAlignmentLeft;
    newLabel.layer.borderColor = [UIColor grayColor].CGColor;
    newLabel.layer.borderWidth = 1.0;
    
    UIButton* checkbox = [[UIButton alloc] initWithFrame:CGRectMake(20, rect_y_pos+(rect_y_height*i)+10, 29, 29)];
    [checkbox setBackgroundImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
    [checkbox setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
    [checkbox setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
    checkbox.adjustsImageWhenHighlighted = YES;
    [checkbox addTarget:self action:@selector(checkBoxSelected:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.tag = 0;
    
    [self.view addSubview:newLabel];
    [self.view addSubview:checkbox];
    count_items++;
}

- (void)removeShopItem:(int) i
{
//    [self.view removeFromSuperview];
}

@end
