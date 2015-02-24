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

@interface ConnexionViewController ()

@end

@implementation ConnexionViewController

-(id) init{
    if(self =[super init])
    {
        
    }
    return self;
}


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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

        [JSonWebService startWebserviceWithURL:[RouteController loginRoute] WithMethod:tasMethodRequestGet withBody:[user FormatForWebService] responseBlock:^(id response, NSError *error)
         {
             if(!error)
             {
                 NSLog(@"%@", error.description);
             }
             else
             {
                  NSLog(@"%@",  [[NSString alloc ]initWithData:response encoding:NSUTF8StringEncoding] );
                 // si le smartphone a changé
                 if([response objectForKey:@"device_user"]  != user.IdIphone)
                 {
                     [JSonWebService startWebserviceWithURL:[RouteController updateUser] WithMethod:tasMethodRequestPut withBody:[user FormatForWebService] responseBlock:^(id response, NSError *error)
                      {
                          if(!error)
                          {
                              NSLog(@"%@", error.description);
                          }
                          else
                          {
                              NSLog(@"%@",  [[NSString alloc ]initWithData:response encoding:NSUTF8StringEncoding] );
                              NSLog(@"Device mis à jour");
                          }
                      }
                      ];
                 }
                 HomeListController* homeListController = [HomeListController new];
                 homeListController.user = user;
                 [self.navigationController pushViewController:homeListController animated:YES];
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
      
            [JSonWebService startWebserviceWithURL:[RouteController signUpRoute] WithMethod:tasMethodRequestPost withBody:[user FormatForWebService]responseBlock:^(id response, NSError *error)
             {
                 if(!error)
                 {
                     NSLog(@"%@", error.description);
                 }
                 else
                 {

                     NSLog(@"%@",  [[NSString alloc ]initWithData:response encoding:NSUTF8StringEncoding] );
                     HomeListController* homeListController = [HomeListController new];
                     homeListController.user = user;
                     [self.navigationController pushViewController:homeListController animated:YES];
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




@end
