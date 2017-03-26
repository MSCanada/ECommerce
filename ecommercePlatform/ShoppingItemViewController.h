//
//  ShoppingItemViewController.h
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-11.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface ShoppingItemViewController : UIViewController

@property (strong, nonatomic) NSString *storeName;
@property (strong, nonatomic) Item *item;
@property (weak, nonatomic) NSString *segueIdentifier;

@end
