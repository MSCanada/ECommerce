//
//  Store.h
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-05.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//
#import <Foundation/Foundation.h>
@class Item;
@interface  Store : NSObject
@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSArray *items;

- (instancetype) initWithName:(NSString *)name items:(NSArray *)items;
-(void) addShoppingItems: (NSArray *) items;
-(void) removeShoppingItems: (NSArray *) items;
-(void) replaceAllShoppingItems: (NSArray *) items;


@end
