//
//  MyTextFieldMail.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 24/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "MyTextFieldMail.h"

@implementation MyTextFieldMail

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(bool)isPoorlyPrepared
{

    return  ([super isPoorlyPrepared] == YES || ([self isAnEmail] == NO));
}


-(bool)isAnEmail{
    
    NSError  *error = nil;
    NSRange range = NSMakeRange(0, self.text.length);
    NSString *pattern = @"[a-zA-Z0-9_.-]+@{1}[a-zA-Z0-9_.-]{2,}\.[a-zA-Z.]{2,5}";
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray *matches = [regex matchesInString:self.text options:0 range:range];
    
    
    if(matches.count > 0)
        return YES;
    else
        return NO;
}





@end
