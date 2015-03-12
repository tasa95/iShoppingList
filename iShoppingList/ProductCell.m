//
//  ProductCellTableViewCell.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 12/03/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    // Initialization code
    self.check = false;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (void)checkBoxSelected:(id) sender
{
    
    
    if(self.check == false)
    {
        
        NSLog(@"supprimé");
   
        
        [UIView animateWithDuration:1.5 animations:^{


             self.backgroundColor =[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1.0];
                     }];
               self.check = true;
    }
    else
    {
        
        NSLog(@"remettre");

        [UIView animateWithDuration:1.5 animations:^{

      
        
            self.backgroundColor = [[UIColor alloc] initWithRed:151 green:116 blue:171 alpha:1.0];

        }];
        self.check = false;
    }
}


@end
