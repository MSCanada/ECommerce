//
//  DataSourceController.m
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-08.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//
#import "DataSourceController.h"
#import <libkern/OSAtomic.h>
#import "Store.h"
#import "Item.h"
#import "NSArray+StringHelper.h"

static BOOL const usePlist = YES;
static NSString *const STORES_PLIST = @"stores.plist";
static NSString *const STORE_NAMES_USED_PLIST = @"storeNamesUsed.plist";
static NSString *const ITEM_NAMES_USED_PLIST = @"itemNamesUsed.plist";
static NSString *const ITEMS_SORT_LIST_PLIST    = @"itemsSortList.plist";


@interface DataSourceController ()

@property (strong, nonatomic) NSArray *stores; // of Store
@property (strong, nonatomic) NSArray *storeNamesUsed; // of NSString
@property (strong, nonatomic) NSArray *itemNamesUsed; // of NSString

@property (strong, nonatomic) NSMutableArray *storeNames;

@end

@implementation DataSourceController

static BOOL initilizingFromSharedInstance = NO;

- (instancetype)init {
    if (!initilizingFromSharedInstance) {
        NSString *class = NSStringFromClass([self class]);
        NSString *currentSEL = NSStringFromSelector(_cmd);
        NSString *properSEL = NSStringFromSelector(@selector(sharedInstance));
        [NSException raise:NSInternalInconsistencyException
                    format:@"[%@ %@] cannot be called; use +[%@ %@] instead", class, currentSEL, class, properSEL];
    }
    
    return [super init];
}

+ (DataSourceController *)sharedInstance {
    static DataSourceController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        initilizingFromSharedInstance = YES;
        sharedInstance = [[DataSourceController alloc] init];
        initilizingFromSharedInstance = NO;
    });
    
    return sharedInstance;
}

-(NSArray *) storeAndItemNameForItemString:(NSString *)itemString{
    for(Store *store in self.stores){
        for(Item *item in store.items){
            if([itemString.lowercaseString isEqualToString:item.name.lowercaseString]){
                return @[store.name,item.name];
            }
        }
    
    }
    return nil;
}


-(NSArray *) arrayOfStoreNames{
    return self.storeNames;
}

-(void)addToStoreNamesUsed:(NSString *)storeName{
    if([storeName isEqualToString:@""] || [storeName isEqualToString:[DataSourceController stringWithNoStoreName]]  )
    {
        return;
    }
    
    if(![self.storeNamesUsed containsString:storeName caseSenstive:NO]){
        self.storeNamesUsed =[[self.storeNamesUsed arrayByAddingObject:storeName] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }

}

- (void)addToItemNamesUsed:(NSString *)itemName {
    if ([itemName isEqualToString:@""]) return;
    
    if (![self.itemNamesUsed containsString:itemName caseSenstive:NO]) {
        self.itemNamesUsed = [[self.itemNamesUsed arrayByAddingObject:itemName] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
}

- (void)removeFromStoreNamesUsed:(NSString *)storeName {
    if ([storeName isEqualToString:@""] || [storeName isEqualToString:[DataSourceController stringWithNoStoreName]]) return;
    
    if ([self.storeNamesUsed containsString:storeName caseSenstive:NO]) {
        NSMutableArray *tempArray = [self.storeNamesUsed mutableCopy];
        [tempArray removeString:storeName caseSensitive:NO];
        self.storeNamesUsed = [tempArray copy];
    }
}

- (void)removeFromItemNamesUsed:(NSString *)itemName {
    if ([itemName isEqualToString:@""]) return;
    
    if ([self.itemNamesUsed containsString:itemName caseSenstive:NO]) {
        NSMutableArray *tempArray = [self.itemNamesUsed mutableCopy];
        [tempArray removeString:itemName caseSensitive:NO];
        self.itemNamesUsed = [tempArray copy];
    }
}

- (Store *)storeWithName:(NSString *)storeName {
    for(Store *store in self.stores){
        if([store.name isEqualToString:storeName]){
            return store;
        }
    
    }
    return nil;
}

- (void) moveItemsFromStoreWithName:(NSString *)fromStoreName toStoreWithName:(NSString *)toStoreName{
    Store *fromStore = [self storeWithName:fromStoreName];
    Store *toStore = [self storeWithName:toStoreName];
    if(!toStore){
        toStore = [[Store alloc] initWithName:toStoreName items:fromStore.items];
        [self addStore:toStore];
    }
    else{
        [toStore addShoppingItems:fromStore.items];
    }
    [self removeStore:fromStore];
    [self addToStoreNamesUsed:toStore.name];
    
    
}

- (void) moveItem:(Item *)item fromStoreWithName:(NSString *)fromStoreName toStoreWithName:(NSString *)toStoreName{
    Store *fromStore = [self storeWithName:fromStoreName];
    Store *toStore = [self storeWithName:toStoreName];
    if(!toStore){
        toStore = [[Store alloc] initWithName:toStoreName items:@ [item]];
        [self addStore:toStore];
    }
    else{
        [toStore addShoppingItems:@[item]];
    }
    
    [fromStore removeShoppingItems:@[item]];
    if(fromStore.items.count ==0)[self removeStore:fromStore];
    [self addToStoreNamesUsed:toStore.name];
    
}

- (void) addStore:(Store *)store{
    self.stores = [self.stores arrayByAddingObject:store];
    [self.storeNames addObject:store.name];
}

- (void)removeStore:(Store *)store {
    NSMutableArray *tempArray = [self.stores mutableCopy];
    [tempArray removeObject:store];
    self.stores = [tempArray copy];
    [self.storeNames removeObject:store.name];
}

+ (NSString *) stringWithNoStoreName{
    return @"Miscellaneous Items";

}

+ (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}



- (void)save {
    NSString *storesPlistPath = [[DataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:STORES_PLIST];
    [NSKeyedArchiver archiveRootObject:self.stores toFile:storesPlistPath];
    
    NSString *storeNamesUsedPlistPath = [[DataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:STORE_NAMES_USED_PLIST];
    [NSKeyedArchiver archiveRootObject:self.storeNamesUsed toFile:storeNamesUsedPlistPath];
    
    NSString *itemNamesUsedPlistPath = [[DataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:ITEM_NAMES_USED_PLIST];
    [NSKeyedArchiver archiveRootObject:self.itemNamesUsed toFile:itemNamesUsedPlistPath];
    
    NSString *itemsSortListPlistPath = [[DataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:ITEMS_SORT_LIST_PLIST];
    [NSKeyedArchiver archiveRootObject:self.itemsSortList toFile:itemsSortListPlistPath];
}

- (id)objectWithClass:(Class)class fromSavedPlistString:(NSString *)savedPlistString orFromBundlePlist:(NSString *)bundlePlistString usingConstructorSelector:(SEL)selector {
    id retrievedObject;
    NSString *plistDocPath = [[DataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:savedPlistString];
    if ([DataSourceController checkForPlistFileInDocs:savedPlistString]) {
        retrievedObject = [NSKeyedUnarchiver unarchiveObjectWithFile:plistDocPath];
    } else {
        if (usePlist) {
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ShoppingList" ofType:@"plist"];
            NSDictionary *rootDictionary = [[NSDictionary alloc] initWithContentsOfFile:bundlePath];
            id subDirectory = rootDictionary[bundlePlistString];
            
            if (selector) {
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
                [invocation setSelector:selector];
                [invocation setTarget:self];
                [invocation setArgument:&(subDirectory) atIndex:2];
                
                [invocation invoke];
                void *tempResults;
                [invocation getReturnValue:&tempResults];
                retrievedObject = (__bridge id)tempResults;
            } else {
                retrievedObject = subDirectory;
            }
        } else {
            retrievedObject = [[class alloc] init];
        }
        [NSKeyedArchiver archiveRootObject:retrievedObject toFile:plistDocPath];
    }
    
    return retrievedObject;
}

+ (BOOL)checkForPlistFileInDocs:(NSString*)fileName {
    NSFileManager *myManager = [NSFileManager defaultManager];
    NSString *pathForPlistInDocs = [[DataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    
    return [myManager fileExistsAtPath:pathForPlistInDocs];
}

- (NSArray *)storesFromBundleArray:(NSDictionary *)bundleDictionary {
    NSMutableArray *stores = [NSMutableArray new];
    for (NSString *storeName in [bundleDictionary allKeys]) {
        NSMutableArray *items = [NSMutableArray new];
        
        for (NSDictionary *plistItem in bundleDictionary[storeName]) {
            Item *item = [[Item alloc] init];
            item.name = plistItem[@"Name"];
            item.amountNeeded = [plistItem[@"AmountNeeded"] intValue];
            item.temperatureType = [plistItem[@"TempAtPurchase"] intValue];
            item.notes = plistItem[@"Notes"];
            
            [items addObject:item];
        }
        Store *store = [[Store alloc] initWithName:storeName items:items];
        [stores addObject:store];
    }
    
    return [stores copy];
}

- (NSArray *)stores {
    if (!_stores) {
        _stores = [self objectWithClass:[NSArray class]
                   fromSavedPlistString:STORES_PLIST
                      orFromBundlePlist:@"SampleLists"
               usingConstructorSelector:@selector(storesFromBundleArray:)];
        
        self.storeNames = [NSMutableArray new];
        for (Store *store in _stores) {
            [self.storeNames addObject:store.name];
        }
    }
    
    return _stores;
}

- (NSArray *)storeNamesUsed {
    if (!_storeNamesUsed) {
        _storeNamesUsed = [self objectWithClass:[NSArray class]
                           fromSavedPlistString:STORE_NAMES_USED_PLIST
                              orFromBundlePlist:@"StoreNamesUsed"
                       usingConstructorSelector:nil];
    }
    
    return _storeNamesUsed;
}

- (NSArray *)itemNamesUsed {
    if (!_itemNamesUsed) {
        _itemNamesUsed = [self objectWithClass:[NSArray class]
                          fromSavedPlistString:ITEM_NAMES_USED_PLIST
                             orFromBundlePlist:@"ItemNamesUsed"
                      usingConstructorSelector:nil];
    }
    
    return _itemNamesUsed;
}

- (NSMutableArray *)itemsSortList {
    if (!_itemsSortList) {
        _itemsSortList = [[self objectWithClass:[NSMutableArray class]
                           fromSavedPlistString:ITEMS_SORT_LIST_PLIST
                              orFromBundlePlist:@"ItemsSortList"
                       usingConstructorSelector:nil]
                          mutableCopy];
    }
    
    return _itemsSortList;
}





@end
