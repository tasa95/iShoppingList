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
    if (self.productOfShop.text && self.productOfShop.text.length > 0 && ![self.productOfShop.text isEqual:@" "]) {
        [self addShopItem:(int) count_items];
        self.productOfShop.text = @"";
    }
}

- (void)checkBoxSelected:(id) sender
{
    UIButton* check = (UIButton*) sender;
    UIView* parentView = (UIView*) check.superview;
    UIView* childView = [parentView.subviews objectAtIndex:1];
    UILabel* childLabel = [childView.subviews objectAtIndex:0];
    
    if (check.tag == 0) {
        [check setSelected:true];
        check.tag = 1;
        
        // Get really width of label text
        CGSize stringBoundingBox = [childLabel.text sizeWithFont:[UIFont systemFontOfSize:14]];
        CGFloat strikeWidth = stringBoundingBox.width;
        
        // Add a struck-through on the label text
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, childLabel.frame.size.height/2, strikeWidth, 1)];
        lineView.backgroundColor = [UIColor blackColor];
        [childView addSubview:lineView];
    } else {
        [check setSelected:false];
        check.tag = 0;
        
        // Remove the struck-through if it exists
        if ([childView.subviews objectAtIndex:1]) {
            [[childView.subviews objectAtIndex:1] removeFromSuperview];
        }
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
    // Parent view contains checkbox and label
    UIView* newGroup = [[UIView alloc] initWithFrame:CGRectMake(20, rect_y_pos+(rect_y_height*i)+10, 280, 29)];
    
    // First child contains checkbox
    UIButton* checkbox = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 29, newGroup.frame.size.height)];
    [checkbox setBackgroundImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
    [checkbox setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
    [checkbox setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
    checkbox.adjustsImageWhenHighlighted = YES;
    [checkbox addTarget:self action:@selector(checkBoxSelected:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.tag = 0;
    
    // Second child group contains padding to the label
    UIView* newSubGroup = [[UIView alloc] initWithFrame:CGRectMake(38, 0, 242, newGroup.frame.size.height)];
    newSubGroup.layer.borderColor = [UIColor grayColor].CGColor;
    newSubGroup.layer.borderWidth = 1.0;
    // Create label into second child group
    UILabel* newLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, newSubGroup.frame.size.width - 5, newSubGroup.frame.size.height)];
    newLabel.text = self.productOfShop.text;
    newLabel.font = [UIFont systemFontOfSize:14];
    newLabel.textAlignment = NSTextAlignmentLeft;
    
    [newSubGroup addSubview:newLabel];
    
    [newGroup addSubview:checkbox];
    [newGroup addSubview:newSubGroup];
    
    [self.view addSubview:newGroup];
    count_items++;
}

- (void)removeShopItem:(int) i
{
//    [self.view removeFromSuperview];
}

@end
