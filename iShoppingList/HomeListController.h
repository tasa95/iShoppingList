//
//  HomeListController.h
//  iShoppingList
//
//  Created by Fllo on 2/14/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeListController : UIViewController
{
    @private
    NSMutableArray* shoplist_;
}

@property (nonatomic, strong)  NSArray* shoplist;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
