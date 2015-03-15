//
//  ConnexionViewController.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 21/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "ConnexionViewController.h"
#import "JSonWebService.h"
#import "HomeListController.h"
#import "RouteController.h"
#import "MyTextField.h"
#import "RouteController.h"
#import "Token.h"

@interface ConnexionViewController ()

@end

@implementation ConnexionViewController

-(id) init{
    if(self =[super init])
    {}
    return self;
}


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {}
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userPassword.delegate = self;
    self.userEmail.delegate = self;
    self.userName.delegate = self;
    UITapGestureRecognizer* tapper = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(dissmissKeyboard)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
}



// Do any additional setup after loading the view from its nib.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if([textField isKindOfClass:[MyTextField class]])
    {
        
        MyTextField *myText = (MyTextField*)textField;
        
        
        if([myText isPoorlyPrepared])
        {
            if(myText.FieldState == 1)
                [myText changeState];
        }
        else
        {
            if(myText.FieldState == 0)
                [myText changeState];
        }
    }
    return NO;
}



-(bool)dismissKeyboarb{
    [self.view endEditing:YES];
    return YES;
}
- (IBAction)doConnexion:(id)sender {
    if(![self PoorlyPreparedTextFields])
    {
        User* user = [[User alloc] initWithMailUser:self.userEmail.text andPassUser:self.userPassword.text];
        
        [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteLogin]  withParameter:[user FormatForGet] responseBlock:^(id response, NSError *error, int codeResponse)
         {
             if(error != nil)
             {
                 NSLog(@" error : %@ \n", [error description]);
             }
             else
             {
                 
                 [self goToHomeListController:(id)response withUser:(User*)user];
             }
         }];
    }
    
}

- (IBAction)SignUp:(id)sender {
    
    if( !self.userName.hidden || self.userName.text.length > 0)
    {
        
        if(![self PoorlyPreparedTextFields])
        {
            User* user = [[User alloc] initWithName:self.userName.text AndMailUser:self.userEmail.text andPassUser:self.userPassword.text];

            [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteSignup]  withParameter:[user FormatForGet] responseBlock:^(id response, NSError *error, int codeResponse)
             {
                 
                     if(error != nil)
                     {
                         NSLog(@"error : %@ \n", error.description);
                     }
                     else
                     {
                        
                         [self goToHomeListController:(id)response withUser:(User*)user];

                     }
             }];
        }
        else{
            
        }
    }
    else{
        [UIView transitionWithView:self.userName
                          duration:0.7
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        self.userName.layer.hidden = NO;
    }
}


- (IBAction)dissmissKeyboard {
    
    for (UIView * txt in self.view.subviews){
        
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [self textFieldShouldReturn:(UITextField*)txt];
        }
    }
}

-(bool)PoorlyPreparedTextFields{
    
    bool emptyField = false;
    NSInteger counter = 0 ;
    UIView * txt;
    MyTextField* myTextField;
    
    while(emptyField && counter < self.view.subviews.count  )
    {
        txt= self.view.subviews[counter];
        if ([txt isKindOfClass:[MyTextField class]]) {
            myTextField = (MyTextField*)txt;
            if([myTextField isPoorlyPrepared])
            {
                emptyField = true;
            }
        }
        
    }
    return emptyField;
}

-(void)initializeHomeListController:(User*)user
{
    HomeListController* homeListController = [HomeListController new];
    homeListController.user = user;
    [self.navigationController pushViewController:homeListController animated:YES];
   
}

-(void)goToHomeListController:(id)response withUser:(User*)user
{
 
        NSLog(@"response : %@",response);
        if([JSonWebService ManageError:response])
        {
            [user setToken: [Token BuildTokenWithText: [[response objectForKey:@"result"] objectForKey :@"token" ]]];
            [user saveObject];
            [self initializeHomeListController:user];
        }
    
}



@end
