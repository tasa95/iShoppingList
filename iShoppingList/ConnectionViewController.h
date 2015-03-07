//
//  ConnexionViewController.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 21/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ConnectionViewController : UIViewController <UITextFieldDelegate>
{
    
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
-(id) init;


@property (strong, nonatomic) IBOutlet UITextField *userName;

@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;

- (IBAction)doConnexion:(id)sender;
- (IBAction)SignUp:(id)sender;

-(bool)emptyField;
-(void) setHost;

@end

