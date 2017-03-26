//
//  ShoppingListTableViewController.h
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-11.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Store;
@interface ShoppingListTableViewController : UITableViewController
@property (strong, nonatomic) Store *selectedStore;
@end
