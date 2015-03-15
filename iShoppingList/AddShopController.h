//
//  AddShopController.h
//  iShoppingList
//
//  Created by Fllo on 2/15/15.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "Product.h"
#import "DetailProductViewController.h"
#import "User.h"


@protocol AddShopControllerDelegate <NSObject, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@optional
- (void) addShoppingControllerDidCreateShop:(Shop*)s;
- (void) addShoppingControllerDidEditShop:(Shop *)s;
@end

@interface AddShopController : UIViewController <DetailProductViewDelegate>
{
    @private
    Shop* shop_;
    id<AddShopControllerDelegate> delegate_;
    double TotalPrice_;
    int mode_ ;
    User* user_ ;
                //0 creation
                //1 edition
    
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andWithName:(NSString*)name andWithShop:(Shop*)shop andWithMode:(int)mode;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (nonatomic, strong) Shop* shop;
@property (strong, nonatomic) id<AddShopControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField* nameOfShop;
@property (strong, nonatomic) IBOutlet UITextField* productOfShop;
@property (strong, nonatomic) IBOutlet UITableView *testTableView;

- (IBAction)onTouchProductAdd:(id)sender;
- (IBAction)onTouchSave:(id) sender;
- (bool)dissmissKeyboard;


-(void) setUser:(User*) user;
-(User*) getUser;

@end
