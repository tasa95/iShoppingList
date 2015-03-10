//
//  HomeListController.m
//  iShoppingList
//
//  Created by Fllo on 2/14/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "Shop.h"
#import "HomeListController.h"
#import "AddShopController.h"
#import "JSonWebService.h"
#import "RouteController.h"
#import "User.h"


@interface HomeListController ()

@end

@implementation HomeListController

@dynamic shoplist;



//-----------


- (NSArray *) shoplist {
    if (!shoplist_) {
        self.shoplist = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    }
    return shoplist_;
}

- (void) setShoplist:(NSArray *)shoplist {
    shoplist_ = [[NSMutableArray alloc] initWithArray:shoplist];
}




//-----------


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andUser:(User*) user  andShoplist:(NSArray*)shoplist
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Shopping List";
        self.user = user;
        self.shoplist = shoplist;
        

        
    }
    return self;
}


//-----------


- (void) onTouchAdd {
    AddShopController* addShop = [AddShopController new];
    addShop.delegate = self;
    [self.navigationController pushViewController:addShop animated:YES];
    [self.tableView reloadData];
}

- (void) onTouchEdit {
    self.tableView.editing = !self.tableView.editing;	
}


//-----------


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray* rightButtons = [NSMutableArray new];
    [rightButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onTouchAdd)]];
    [rightButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onTouchEdit)]];
    self.navigationItem.rightBarButtonItems = rightButtons;
    
    [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteGetShoppingList]  withParameter:[[self.user getToken] FormatForGet] responseBlock:^(id response, NSError *error, int codeResponse)
     {
         
         if(error)
         {
             NSLog(@"error : %@", [error description]);
         }
         else{
             NSLog(@"response : %@", [response description]);
             self.shoplist = [response objectForKey:@"result"];
             
         }
         
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSKeyedArchiver archiveRootObject:self.shoplist toFile:[self filePath]];
}


//-----------


static NSString* const kShoppingCellId = @"shoppingItemId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kShoppingCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kShoppingCellId];
    }
    
    Shop* s = [shoplist_ objectAtIndex:indexPath.row];
    cell.textLabel.text = s.titleOfShop;
    cell.textLabel.textColor = [UIColor blueColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ : %lu", @"Nb de produits", (long)indexPath.row]; //(long)s.numberOfItems];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.shoplist count];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [shoplist_ removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Click at Index Path %lu", (long)indexPath.row);
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath { }


//-----------


- (NSString*) filePath {
    NSArray* docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docPath = [docPaths objectAtIndex:0];
    NSLog(@"%@", docPath);
    return [docPath stringByAppendingPathComponent:@"shoplist.archive"];
}


//-----------


- (void) addShoppingControllerDidCreateShop:(Shop *)s {
    [shoplist_ addObject:s];
    self.shoplist = shoplist_;

    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:YES];
}





//- (void) addShoppingControllerDidEditShop:(Shop *)s {
//    NSLog(@"Methode edit called");
//    [self.tableView reloadData];
//    [self.navigationController popToViewController:self animated:YES];
//}


@end
