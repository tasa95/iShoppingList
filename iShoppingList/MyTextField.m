//
//  MyTextField.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 24/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

@synthesize FieldState = FieldState_;

-(instancetype)init
{
    if(self = [super init])
    {
        self.FieldState = 1;
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.FieldState = 1;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.FieldState = 1;
    }
    return self;
}


-(void)changeState
{
    NSLog(@"%d",self.FieldState);
    if(self.FieldState == 1)
    {
        [self ChangeBorderOfTextFieldInRed];
        self.FieldState = 0;
    }
    else{
        [self ChangeBorderOfTextFieldInGreen];
        self.FieldState = 0;
    }
}


-(void)ChangeBorderOfTextFieldInRed
{
    [UIView transitionWithView:self
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    self.layer.borderWidth = 0.75F;
    self.layer.borderColor = [[UIColor redColor]CGColor];
    self.layer.cornerRadius = 10;
}


-(void)ChangeBorderOfTextFieldInGreen
{
    [UIView transitionWithView:self
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    
    self.layer.borderWidth = 0.75F;;
    self.layer.borderColor = [[UIColor greenColor]CGColor];
    self.layer.cornerRadius = 10;
}

-(bool)isPoorlyPrepared
{
    return  self.text.length == 0;
}

@end
