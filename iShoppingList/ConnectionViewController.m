//
//  ConnexionViewController.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 21/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ConnectionViewController.h"
#import "JSonWebService.h"
#import "HomeListController.h"

@interface ConnectionViewController ()

@end

@implementation ConnectionViewController

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
    // Do any additional setup after loading the view from its nib.
}

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
    return NO;
}


- (IBAction)doConnexion:(id)sender {
    if(![self emptyField])
    {
        User* user = [[User alloc] initWithMailUser:self.userEmail.text andPassUser:self.userPassword.text];
        [self setHost];
        [JSonWebService startWebserviceWithURL:[JSonWebService getHost] WithMethod:tasMethodRequestGet withBody:[user FormatForWebService] Withdelegate:self responseBlock:^(id response, NSError *error)
         {
             if(!error)
             {
                 NSLog(@"%@", error.description);
             }
             else
             {
                 // si le smartphone a changé
                 if([response objectForKey:@"device_user"]  != user.IdIphone)
                 {
                     [JSonWebService startWebserviceWithURL:[JSonWebService getHost] WithMethod:tasMethodRequestPut withBody:[user FormatForWebService] Withdelegate:self responseBlock:^(id response, NSError *error)
                      {
                          if(!error)
                          {
                              NSLog(@"%@", error.description);
                          }
                          else
                          {
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
    
    if(self.userName.hidden || self.userName.text.length ==0)
    {
        if(![self emptyField])
        {
            User* user = [[User alloc] initWithName:self.userName.text AndMailUser:self.userEmail.text andPassUser:self.userPassword.text];
            [self setHost];
            [JSonWebService startWebserviceWithURL:[JSonWebService getHost] WithMethod:tasMethodRequestPost withBody:[user FormatForWebService] Withdelegate:self responseBlock:^(id response, NSError *error)
             {
                

                 if(error != nil)
                 {
                     NSLog(@"Error : %@", error.description);
                 }
                 else
                 {
                     if([response isKindOfClass:[NSDictionary class]])
                         NSLog(@"ID = %@ ",[response objectForKey:@"_id"]);
                     HomeListController* homeListController = [HomeListController new];
                     homeListController.user = user;
                     [self.navigationController pushViewController:homeListController animated:YES];
                 }
             }];
        }
    }
    else{
        NSLog(@"apparition");
        
        self.userName.layer.hidden = NO;
        
    }
}

-(bool)emptyField{
    
    bool emptyField = NO;
    
    if(self.userEmail.text.length == 0)
    {
        emptyField = YES;
        self.userEmail.layer.borderWidth = 0.75F;
        self.userEmail.layer.borderColor = [[UIColor redColor]CGColor];
        self.userEmail.layer.cornerRadius = 10;
    }
    
    if(self.userEmail.text.length == 0)
    {
        emptyField = YES;
        self.userPassword.layer.borderWidth = 0.75F;
        self.userPassword.layer.borderColor = [[UIColor redColor]CGColor];
        self.userPassword.layer.cornerRadius = 10;
    }
    return emptyField;
}


-(void) setHost
{
    if([[JSonWebService getHost] relativeString].length == 0)
    {
        NSString* urlServer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"URL Server"];
        NSURL* url = [[NSURL alloc] initWithString:urlServer];
        JSonWebService.host = url;
    }
}



@end
