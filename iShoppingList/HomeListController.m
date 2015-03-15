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
        shoplist_ = [[NSMutableArray alloc] initWithArray:shoplist];
        
        
    }
    return self;
}

-(instancetype)init
{
    return [self initWithNibName:nil bundle:[NSBundle mainBundle] andUser:[User new] andShoplist:[NSArray new]];
}



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil andUser:[User new] andShoplist:[NSArray new]];
}

//-----------


- (void) onTouchAdd {
    [self goToAddShopViewWithMode:1 andWithShop:[[Shop alloc] init]];
}

- (void) onTouchEdit {
    if(self.tableView.editing)
        [self.tableView setEditing:NO animated:YES];
    else
        [self.tableView setEditing:YES animated:YES];
}


//-----------


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData:nil];
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
             NSArray* array=[response objectForKey:@"result"];
             if([JSonWebService ManageError:response])
             {
                 
                 for(int i = 0 ; i < [array count] ; i++)
                 {
                     
                     NSDictionary* tempDictionary = [array objectAtIndex:i];
                     
                     NSString* name = [tempDictionary objectForKey:@"name"];
                     NSString* newId = [tempDictionary objectForKey:@"id"];
                     NSString *date = [tempDictionary objectForKey:@"created_date"];
                     
                     
                     NSDateFormatter *df = [[NSDateFormatter alloc] init];
                     [df setDateFormat:@"yyyy-MM-dd HH:mm:ss "];
                     
                     
                     bool completed = [[tempDictionary  objectForKey:@"completed"] integerValue];
                     Shop *s = [[Shop alloc] initWithId:newId andWithName:name andWithCreatedDate:[df dateFromString: date] andIsCompleted:completed andWithProductList:[NSMutableArray new]];
                     
       
                     
                     

                     //NSLog(NSStringFromClass([shoplist_ class]));
                     [shoplist_ addObject:s];
                     
                     NSString *token =[[self.user getToken] FormatForGet];
                     // NSMutableString *shopString = [s FormatForGet];
                     
                     
                     
                     //[shopString replaceCharactersInRange : NSMakeRange(0,1) withString:@"&"];
                     NSString *parameter = [[NSString alloc] initWithFormat:@"%@&shopping_list_id=%@",token,s.id];
                     
                     
                     
                     [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteListProduct]  withParameter:parameter responseBlock:^(id response, NSError *error, int codeResponse)
                      {
                          if(error)
                          {
                              NSLog(@"error : %@", [error description]);
                          }
                          else{
                              if([JSonWebService ManageError:response])
                              {
                                  NSLog(@"response : %@", [response description]);
                                  NSArray* array=[response objectForKey:@"result"];
                                  
                                  for(int i = 0 ; i < [array count] ; i++)
                                  {
                                      
                                      
                                      NSDictionary* tempDictionary = [array objectAtIndex:i];
                                      NSString* name = [tempDictionary objectForKey:@"name"];
                                      NSString* newId = [tempDictionary objectForKey:@"id"];
                                      int quantity = [[tempDictionary objectForKey:@"quantity"] intValue];
                                      double price = [[tempDictionary objectForKey:@"price"] doubleValue];
                                      NSString* shopping_list_id = [tempDictionary objectForKey:@"shopping_list_id"];
                                      Product *product = [[Product alloc] initWithId:newId andWithName:name andWithQuantity:quantity andWithPrice:price andWithShoppingListId:shopping_list_id];
                                      [s.productList addObject:product];
                                      [s calculateTotalPrice];
                                  }
                                  
                                  [self reloadData:s];
                              }
                          }
                      }];
                     
                 }
                 
                 
                 
             }
             
             [self.tableView reloadData];
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.user saveObject];
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
    
    if(s)
    {
        
        cell.NameShopLabel.text = s.name;
        cell.textLabel.textColor = [UIColor blueColor];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE dd MMMM yyyy 'à' HH:mm"];
        
        cell.TotalPriceOfShop.text = [[NSString alloc] initWithFormat:@"%.02f€",[s getTotal_price]];
        cell.DateCreationLabel.text = [NSString stringWithFormat:@"%@ ", [dateFormatter stringFromDate:s.created_date]];
    }
    
    
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
        
        
        Shop *s = [shoplist_ objectAtIndex:indexPath.row ];
        
        if(s.id || [s.id length] > 0 )
        {
            for(int i = 0 ; i < [s.productList count] ; i++)
            {
                Product *p = s.productList[i];
                
                NSString *token =[[self.user getToken] FormatForGet];
                NSMutableString *productString = [[NSMutableString alloc] initWithString:[p FormatForGet]];
                
                
                [productString replaceCharactersInRange : NSMakeRange(0,1) withString:@"&"];
                NSString *parameter = [[NSString alloc] initWithFormat:@"%@%@",token,productString];
                
                
                [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteRemoveProduct]  withParameter:parameter responseBlock:^(id response, NSError *error, int codeResponse)
                 {
                     if(error)
                     {
                         NSLog(@"error : %@", [error description]);
                     }
                     else{
                         NSLog(@"response : %@", [response description]);
                         if([JSonWebService ManageError:response])
                         {
                             NSLog(@"error : ");
                         }
                     }
                 }];
            }
            
            NSString *token =[[self.user getToken] FormatForGet];
            NSMutableString *shopString = [[NSMutableString alloc] initWithString:[s FormatForGet]];
            
            
            [shopString replaceCharactersInRange : NSMakeRange(0,1) withString:@"&"];
            NSString *parameter = [[NSString alloc] initWithFormat:@"%@%@",token,shopString];
            
            
            [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteRemoveShoppingList]  withParameter:parameter responseBlock:^(id response, NSError *error, int codeResponse)
             {
                 if(error)
                 {
                     NSLog(@"error : %@", [error description]);
                 }
                 else{
                     NSLog(@"response : %@", [response description]);
                     
                     if([JSonWebService ManageError:response])
                     {
                         [shoplist_ removeObjectAtIndex:indexPath.row];
                         [self reloadData:s];
                     }
                 }
             }];
        }
        else{
            [shoplist_ removeObjectAtIndex:indexPath.row];
            [self reloadData:s];
        }
        
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self goToAddShopViewWithMode:1 andWithShop:[self.shoplist objectAtIndex:indexPath.row]];
}







//-----------





//-----------


- (void) addShoppingControllerDidCreateShop:(Shop *)s {
    
    
    [shoplist_ addObject:s];
    self.shoplist = shoplist_;
    
    
    
    NSString *token =[[self.user getToken] FormatForGet];
    NSMutableString *shopString = [s FormatForGet];
    
    
    [shopString replaceCharactersInRange : NSMakeRange(0,1) withString:@"&"];
    NSString *parameter = [[NSString alloc] initWithFormat:@"%@%@",token,shopString];
    
    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:YES];
    
    ///SAUVEGARDE ShopList sur le webService
    
    [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteCreateShoppingList]  withParameter:parameter responseBlock:^(id response, NSError *error, int codeResponse)
     {
         if(error)
         {
             NSLog(@"error : %@", [error description]);
         }
         else{
             NSLog(@"response : %@", [response description]);
             //int codeRetour =  [[response objectForKey :@"code" ] intValue];
             if([JSonWebService ManageError:response])
             {
                 s.id = [ [response objectForKey:@"result"] objectForKey:@"id" ];
                 [self SaveNewProducts:s];
             }
         }
     }];
    
    
}




// Drag'n'Drop des items de la liste
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    // On enlève l'item déplacé et remet à sa nouvelle position
    id obj = [shoplist_ objectAtIndex:sourceIndexPath.row];
    [shoplist_ removeObjectAtIndex:sourceIndexPath.row];
    [shoplist_ insertObject:obj atIndex:destinationIndexPath.row];
}

- (void) addShoppingControllerDidEditShop:(Shop *)s {
    /* int i = [shoplist_ indexOfObjectIdenticalTo:s];
     if(i >= 0)
     {
     [shoplist_ removeObjectAtIndex:i];
     [shoplist_ insertObject:s atIndex:i];
     }
     */
    
    
    NSString *token =[[self.user getToken] FormatForGet];
    NSMutableString *shopString = [s FormatForGet];
    
    
    [shopString replaceCharactersInRange : NSMakeRange(0,1) withString:@"&"];
    NSString *parameter = [[NSString alloc] initWithFormat:@"%@%@",token,shopString];
    
    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:YES];
    [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteEditShoppingList]  withParameter:parameter responseBlock:^(id response, NSError *error, int codeResponse)
     {
         
         if(error)
         {
             NSLog(@"error : %@", [error description]);
         }
         else{
             NSLog(@"response : %@", [response description]);
             if([JSonWebService ManageError:response])
                 [self SaveNewProducts:s];
             [self reloadData:s];
             
             [self.navigationController popToViewController:self animated:YES];
         }
         
     }];
}

-(void)goToAddShopViewWithMode:(int)Mode andWithShop:(Shop*)s;
{
    
    AddShopController* shopController =[[AddShopController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]  andWithName:s.name andWithShop:s andWithMode:Mode];
    shopController.delegate = self;
    [shopController setUser:self.user];
    [self.navigationController pushViewController:shopController animated:YES];
}

-(void)SaveNewProducts:(Shop*)s
{
    
    for(int i = 0; i < [s.productList count] ; i++)
    {
        
        //sauvegarde shopListe
        if( (![s.productList[i] id]) || ([[s.productList[i] id]  length] == 0) ||  (![s.productList[i]shopping_list_id]) || ([[s.productList[i] shopping_list_id]  length] == 0))
        {
            Product* p = s.productList[i];
            
            p.shopping_list_id = s.id;
            NSString *token =[[self.user getToken] FormatForGet];
            NSMutableString *productString = [[NSMutableString alloc] initWithString:[p FormatForGet]];
            
            
            
            
            [productString replaceCharactersInRange : NSMakeRange(0,1) withString:@"&"];
            
            NSString *parameter = [[NSString alloc] initWithFormat:@"%@%@",token,productString];
            
            //Sauvegarde Product sur le webService
            
            [JSonWebService startWebserviceWithURL:[RouteController getRoute:RouteCreateProduct]  withParameter:parameter responseBlock:^(id response, NSError *error, int codeResponse)
             {
                 if(error)
                 {
                     NSLog(@"error : %@", [error description]);
                 }
                 else{
                     NSLog(@"response : %@", [response description]);
                     [JSonWebService ManageError:response];
                     p.id = [[response objectForKey:@"result"] objectForKey:@"id"];
                     p.name = [[response objectForKey:@"result"] objectForKey:@"name"];
                 }
             }];
        }
    }
}
-(void) reloadData:(Shop*) s
{
    if(s)
        [s calculateTotalPrice];
    [self.tableView reloadData];
}



@end
