//
//  MyTextField.h
//  iShoppingList
//
//  Created by thierry allard saint albin on 24/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolMyTextField.h"

@interface MyTextField : UITextField <ProtocolMyTextField>
{
    NSInteger FieldState_;
}

-(instancetype)init;
-(instancetype)initWithCoder:(NSCoder *)aDecoder;
-(instancetype)initWithFrame:(CGRect)frame;

@end
