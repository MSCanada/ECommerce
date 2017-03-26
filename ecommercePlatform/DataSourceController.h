//
//  DataSourceController.h
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-08.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Store;
@class Item;

@interface DataSourceController : NSObject

+(DataSourceController *) sharedInstance;
@property (nonatomic, readonly) NSArray *stores; // of Store
@property (nonatomic, readonly) NSArray *storeNamesUsed; // of NSString
@property (nonatomic, readonly) NSArray *itemNamesUsed; // of NSString
@property (nonatomic, strong) NSMutableArray *itemsSortList; // of NSString

- (NSArray *)storeAndItemNameForItemString:(NSString *)itemString; // [0] = StoreName, [1] = ItemName
- (NSArray *)arrayOfStoreNames;

- (void)addToStoreNamesUsed:(NSString *)storeName;
- (void)addToItemNamesUsed:(NSString *)storeName;
- (void)removeFromItemNamesUsed:(NSString *)itemName;

- (Store *)storeWithName:(NSString *)storeName;
- (void)moveItemsFromStoreWithName:(NSString *)fromStoreName toStoreWithName:(NSString *)toStoreName;
- (void)moveItem:(Item *)item fromStoreWithName:(NSString *)fromStoreName toStoreWithName:(NSString *)toStoreName;
- (void)addStore:(Store *)store;
- (void)removeStore:(Store *)store;

- (void)save;

+ (NSString *)stringWithNoStoreName;


@end
