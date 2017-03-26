//
//  ShoppingItem.h
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-07.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+OrShopColors.h"
@interface ShoppingItem : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic) NSUInteger amountNeeded;
@property(nonatomic,strong) NSString *preferredStore;
@property(nonatomic) NSUInteger tempAtPurchase;
@property(nonatomic,strong) UIColor *colorFromTemp;
@property(nonatomic,strong) NSString *notes;
@property(nonatomic) BOOL isChecked;
@property(nonatomic) NSUInteger checkedOrder;


-(instancetype) initGenericItemWithStoreName: (NSString *) storeName;
+(NSArray *) arrayWithOrderedTempAtPurchaseNumbers;



@end
