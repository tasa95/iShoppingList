//
//  AddShopController.m
//  iShoppingList
//
//  Created by Fllo on 2/15/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AddShopController.h"
#import "Product.h"
#import "ProductCell.h"
#import "DetailProductViewController.h"
#import "RouteController.h"
#import "JSonWebService.h"
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

static NSString* const kShoppingCellId = @"ProductCell";


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andWithName:(NSString*)name andWithShop:(Shop*)shop andWithMode:(int)mode
{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Add list";
        self.shop = shop;
        self.nameOfShop.text = name;
        self.testTableView.delegate = self;
        self.testTableView.dataSource = self;
        mode_ = mode;
        
        if(mode == 0 )          //Creation
        {
        
        UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onTouchSave:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        }
        else
        {
            
            UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onTouchEdit:)];
            self.navigationItem.rightBarButtonItem = rightButton;
            
        }
        
        
        count_items = 0;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil andWithName:@"" andWithShop: [[Shop alloc] InitWithName:@""] andWithMode:0];
}


//-----------


- (IBAction)onTouchSave:(id) sender
{
    if([self.nameOfShop.text length] >0)
    {
        // Save the shop, and pop to previous list
        self.shop.name = self.nameOfShop.text;
        [self.shop setTotal_price:[self.totalPriceLabel.text doubleValue]];
        if ([self.delegate respondsToSelector:@selector(addShoppingControllerDidCreateShop:)]) {
            
            [self.delegate addShoppingControllerDidCreateShop:self.shop];
            [self.shop saveObject];
            
            
            
            
        }
    }
}


//-----------
- (IBAction)onTouchEdit:(id) sender
{
    if([self.nameOfShop.text length] >0)
    {
        // Save the shop, and pop to previous list
        self.shop.name = self.nameOfShop.text;
        [self.shop setTotal_price:[self.totalPriceLabel.text doubleValue]];
        if ([self.delegate respondsToSelector:@selector(addShoppingControllerDidEditShop:)]) {
            
            [self.delegate addShoppingControllerDidEditShop:self.shop];
            [self.shop saveObject];
        }
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
    self.nameOfShop.text = self.shop.name;
    
    //NSLog(@"%@",[self.shop.productList description]);
    [self reloadData];
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
    // UIView* newGroup = [[UIView alloc] initWithFrame:CGRectMake(20, rect_y_pos+(rect_y_height*i)+10, 280, 29)];
    
    // First child contains checkbox
    
    /*
     UIButton* checkbox = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 29, self.testScrollView.frame.size.height)];
     [checkbox setBackgroundImage:[UIImage imageNamed:@"notselectedcheckbox.png"] forState:UIControlStateNormal];
     [checkbox setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateSelected];
     [checkbox setBackgroundImage:[UIImage imageNamed:@"selectedcheckbox.png"] forState:UIControlStateHighlighted];
     checkbox.adjustsImageWhenHighlighted = YES;
     [checkbox addTarget:self action:@selector(checkBoxSelected:) forControlEvents:UIControlEventTouchUpInside];
     checkbox.tag = 0;
     
     // Second child group contains padding to the label
     UIView* newSubGroup = [[UIView alloc] initWithFrame:CGRectMake(38, 0, 242, self.testScrollView.frame.size.height)];
     newSubGroup.layer.borderColor = [UIColor grayColor].CGColor;
     newSubGroup.layer.borderWidth = 1.0;
     // Create label into second child group
     UILabel* newLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, newSubGroup.frame.size.width - 5, newSubGroup.frame.size.height)];
     newLabel.text = self.productOfShop.text;
     newLabel.font = [UIFont systemFontOfSize:14];
     newLabel.textAlignment = NSTextAlignmentLeft;
     
     [newSubGroup addSubview:newLabel];
     
     [self.testScrollView addSubview:checkbox];
     [self.testScrollView addSubview:newSubGroup];
     
     // [self.view addSubview:newGroup];
     count_items++;
     
     */
    [self.shop.productList addObject:[[Product alloc] initWithName:self.productOfShop.text andWithQuantity:0 andWithPrice:0.00]];
    
    
    
    [self reloadData];
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    ProductCell* cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:kShoppingCellId];
    if (!cell) {
        
        NSArray *nib =  [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Product *p = [self.shop.productList  objectAtIndex:indexPath.row];
    
   
    cell.name.text =  p.name;
    if(p.price !=0)
        cell.price.text = [[NSString alloc] initWithFormat:@"%.2f€",p.price];
    else
        cell.price.text = [[NSString alloc] initWithFormat:@"%.2f€",0.00];
    cell.qte.text = [[NSString alloc] initWithFormat:@"%d",p.quantity ];
    cell.imageView.image = [UIImage imageNamed:@"notselectedcheckbox.png"];
    
    if([p.id length] == 0)
    {
        cell.backgroundColor =  [[UIColor alloc] initWithRed:51 green:116 blue:171 alpha:1.0];
    }
    
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.shop.productList count];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Product *p =[self.shop.productList objectAtIndex:indexPath.row];
        
        if(p.id)
        {
            NSString *token =[[[self getUser] getToken] FormatForGet];
            NSMutableString *productString = [[NSMutableString alloc] initWithString:[p FormatForGet]];
            [productString replaceCharactersInRange : NSMakeRange(0,1) withString:@"&"];
            
            
            NSString *parameter = [[NSString alloc] initWithFormat:@"%@%@",token,productString];
            [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteRemoveProduct]  withParameter:parameter responseBlock:^(id response, NSError *error, int codeResponse)
             {
                 if(error)
                 {
                     NSLog(@"error : %@", [error description]);
                 }
                 else{
                     NSLog(@"response : %@", [response description]);
                     if([JSonWebService ManageError:response])
                     {
                         [self.shop.productList removeObjectAtIndex:indexPath.row];
                     }
                     [self reloadData];
                 }
             }];
        }
        else{
            [self.shop.productList removeObjectAtIndex:indexPath.row];
            [self reloadData];
        }
        
        
        
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailProductViewController *productView = [[DetailProductViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle] andWithProduct:[self.shop.productList objectAtIndex:indexPath.row] andWithDelegate:self andWithMode:1];
    [self.navigationController pushViewController:productView animated:YES];
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath { }

- (void)removeShopItem:(int) i
{
    [self.shop.productList removeObjectAtIndex:i];
    //    [self.view removeFromSuperview];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) DetailProductControllerModifyProduct:(Product*)p
{
   // int i =[self.shop.productList indexOfObject:p];
    
    if(p.id && [p.id length] > 0 &&  p.shopping_list_id && [p.shopping_list_id length] > 0)
    {
        NSString *token =[[self. getUser getToken] FormatForGet];
        NSMutableString *productString = [[NSMutableString alloc ] initWithString:[p FormatForGet]];
        
        [productString replaceCharactersInRange : NSMakeRange(0,1) withString:@"&"];
        NSString *parameter = [[NSString alloc] initWithFormat:@"%@%@",token,productString];
        
        [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteEditProduct]  withParameter:parameter responseBlock:^(id response, NSError *error, int codeResponse)
         {
             if(error)
             {
                 NSLog(@"error : %@", [error description]);
             }
             else{
                 NSLog(@"response : %@", [error description]);
                 [JSonWebService ManageError:response];
             }   
         }];
        
    }
    else{
        double totalPrice =  [self.totalPriceLabel.text doubleValue];
        totalPrice += p.price * p.quantity;

        self.totalPriceLabel.text = [[NSString alloc] initWithFormat :@"%.2f",totalPrice ];
        [self.testTableView reloadData];
    }
    
    
    
}

-(void) setUser:(User*) user
{
    user_ =user;
}
-(User*) getUser
{
    return user_;
}

-(void) printTotalPrice
{
    [self.shop calculateTotalPrice];
    self.totalPriceLabel.text = [[NSString alloc] initWithFormat:@"%.02f", [self.shop getTotal_price ]];
}

-(void) reloadData
{
    [self.testTableView reloadData];
    [self printTotalPrice];
}


@end
