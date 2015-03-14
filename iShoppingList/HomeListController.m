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
#import "ShopCell.h"

@interface HomeListController ()

@end

@implementation HomeListController

@dynamic shoplist;



//-----------


- (NSArray *) shoplist {
    if (!shoplist_) {
       // self.shoplist = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
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
    ShopCell* cell = (ShopCell*)[tableView dequeueReusableCellWithIdentifier:kShoppingCellId];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShopCell" owner:self options:nil];
        cell = [ nib objectAtIndex:0];
    }
    
    Shop* s = [shoplist_ objectAtIndex:indexPath.row];
    cell.NameShopLabel.text = s.name;
    cell.textLabel.textColor = [UIColor blueColor];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE dd MMMMM yyyy 'à' HH:mm"];
    
    cell.TotalPriceOfShop.text = [[NSString alloc] initWithFormat:@"%.02f€",[s getTotal_price]];
    cell.DateCreationLabel.text = [NSString stringWithFormat:@"%@ ", [dateFormatter stringFromDate:s.created_date]];
    
    
    /*
     
     
     ProductCell* cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:kShoppingCellId];
     if (!cell) {
     
     NSArray *nib =  [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
     cell = [nib objectAtIndex:0];
     }
     
     Product *p = [self.shop.productList  objectAtIndex:indexPath.row];
     
     TotalPrice_ += p.price * p.quantity;
     cell.name.text =  p.name;
     cell.price.text = [[NSString alloc] initWithFormat:@"%.02f€",p.price];
     cell.qte.text = [[NSString alloc] initWithFormat:@"%d",p.quantity ];
     cell.imageView.image = [UIImage imageNamed:@"notselectedcheckbox.png"];
     self.totalPriceLabel.text = [[NSString alloc] initWithFormat:@"%.02f", TotalPrice_ ];

     
     
     */
    
    
    
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
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  
        Shop *shop =[self.shoplist objectAtIndex:indexPath.row];
          AddShopController* shopController =[[AddShopController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]  andWithName:shop.name andWithShop:shop];
    
        [self.navigationController pushViewController:shopController animated:YES];
    
    
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
