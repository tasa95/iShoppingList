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
    [self emptyField];
    return NO;
}



-(bool)dismissKeyboarb{
    [self.view endEditing:YES];
    return YES;
}
- (IBAction)doConnexion:(id)sender {
    if(![self emptyField])
    {
        User* user = [[User alloc] initWithMailUser:self.userEmail.text andPassUser:self.userPassword.text];

        [JSonWebService startWebserviceWithURL:[RouteController loginRoute] WithMethod:tasMethodRequestGet withBody:[user description] responseBlock:^(id response, NSError *error)
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
                     [JSonWebService startWebserviceWithURL:[RouteController updateUser] WithMethod:tasMethodRequestPut withBody:[user description] responseBlock:^(id response, NSError *error)
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
        
        if(![self emptyField])
        {
            User* user = [[User alloc] initWithName:self.userName.text AndMailUser:self.userEmail.text andPassUser:self.userPassword.text];
      
            [JSonWebService startWebserviceWithURL:[RouteController signUpRoute] WithMethod:tasMethodRequestPost withBody:[user description] responseBlock:^(id response, NSError *error)
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

-(bool)emptyField{
    
    bool emptyField = NO;
    
    if(self.userEmail.text.length > 0 && [self isAnEmail:self.userEmail.text])
    {
        [self ChangeBorderOfTextFieldInGreen:self.userEmail];
        
    }
    else
    {
        emptyField = YES;
        [self ChangeBorderOfTextFieldInRed:self.userEmail];
    }
    
    if(self.userPassword.text.length == 0)
    {
        emptyField = YES;
        [self ChangeBorderOfTextFieldInRed:self.userPassword];
    }
    else
    {

        [self ChangeBorderOfTextFieldInGreen:self.userPassword];

    }
    
    if( !(self.userName.hidden) && self.userName.text.length  > 0)
    {
        [self ChangeBorderOfTextFieldInGreen:self.userName];
      
    }
    else
    {
        emptyField = YES;
        [self ChangeBorderOfTextFieldInRed:self.userName];
    }
    return emptyField;
}




- (IBAction)dissmissKeyboard {
    
    for (UIView * txt in self.view.subviews){
   
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [self textFieldShouldReturn:txt];
        }
    }
}

-(bool)isAnEmail:(NSString*) mail{
    
    
    if(mail.length == 0)
        return NO;
    NSError  *error = nil;
    NSRange range = NSMakeRange(0, mail.length);
    NSString *pattern = @"[a-zA-Z0-9_.-]+@{1}[a-zA-Z0-9_.-]{2,}\.[a-zA-Z.]{2,5}";
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray *matches = [regex matchesInString:mail options:0 range:range];
   

    if(matches.count > 0)
        return YES;
    else
        return NO;
}

-(void)ChangeBorderOfTextFieldInRed:(UITextField*) textField
{
    [UIView transitionWithView:self.userPassword
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    

    textField.layer.borderWidth = 0.75F;
    textField.layer.borderColor = [[UIColor redColor]CGColor];
    textField.layer.cornerRadius = 10;
}

-(void)ChangeBorderOfTextFieldInGreen:(UITextField*) textField
{
    [UIView transitionWithView:self.userPassword
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    
    textField.layer.borderWidth = 0.75F;;
    textField.layer.borderColor = [[UIColor greenColor]CGColor];
    textField.layer.cornerRadius = 10;

}

@end
