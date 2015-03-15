//
//  DetailProductViewController.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 14/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "DetailProductViewController.h"

@interface DetailProductViewController ()

@end

@implementation DetailProductViewController



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andWithProduct:(Product*)produit andWithDelegate:(id)delegate andWithMode:(int)mode
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.product = produit;
        self.LabelPrix.delegate = self;
        self.LabelQte.delegate = self;
        delegate_ = delegate;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.LabelPrix.text = [[NSString alloc ] initWithFormat:@"%f",self.product.price ];
    self.LabelQte.text = [[NSString alloc ] initWithFormat:@"%d",self.product.quantity ];
    self.NomProduit.text = self.product.name;
    
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(bool)dismissKeyboarb{


    [self.view endEditing:YES];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)tapOnView:(id)sender {
    
    for (UIView * txt in self.view.subviews){
        
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [self textFieldShouldReturn:(UITextField*)txt];
        }
    }
}

- (IBAction)Modify:(id)sender {
   
    
    
    if([self.LabelPrix.text length] >0 && [self.LabelQte.text length] > 0)
    {
        // Save the shop, and pop to previous list
        if ([delegate_ respondsToSelector:@selector(DetailProductControllerModifyProduct:)]) {
            
            
            self.product.price = [self.LabelPrix.text floatValue];
            self.product.quantity = [self.LabelQte.text integerValue];
            
            
            [delegate_ DetailProductControllerModifyProduct:self.product];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



@end
