//
//  HomeListController.h
//  iShoppingList
//
//  Created by Fllo on 2/14/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddShopController.h"
#import "User.h"


@interface HomeListController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddShopControllerDelegate>
{
    @private
    NSMutableArray* shoplist_;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andUser:(User*) user andShoplist:(NSArray*)shoplist;
-(instancetype)init;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@property (nonatomic, strong)  NSArray* shoplist;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) User* user;


-(void)goToAddShopViewWithMode:(int)Mode andWithShop:(Shop*)s;
-(void)SaveNewProducts:(Shop*)s;
@end
