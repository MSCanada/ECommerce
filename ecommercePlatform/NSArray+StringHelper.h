//
//  NSArray+StringHelper.h
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-08.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSArray(StringHelper)
-(BOOL) containsString: (NSString *) string caseSenstive:(BOOL) caseSensitive;
@end

@interface NSMutableArray(StringHelper)
-(void) removeString:(NSString *) string caseSensitive:(BOOL)caseSensitive;
@end
