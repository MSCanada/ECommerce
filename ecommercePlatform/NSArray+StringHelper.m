//
//  NSArray+StringHelper.m
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-08.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//

#import "NSArray+StringHelper.h"
@implementation NSArray(StringHelper)

-(BOOL)containsString:(NSString *)string caseSenstive:(BOOL)caseSensitive{
    if(caseSensitive){
    return [self containsObject:string];
    }
    for(NSString *arrayString in self){
    if([arrayString isKindOfClass:[NSString class]])
    {
        if([arrayString.lowercaseString isEqualToString:string.lowercaseString]){
            return YES;
        }
    }
    
    }
    return NO;
}

-(NSUInteger) indexOfString:(NSString *) string caseSensitive:(BOOL)caseSensitive {
    if(caseSensitive){
    return [self indexOfObject:string];
    }
    
    for(NSUInteger index=0; index < self.count; index++){
        NSString *arrayString = self[index];
        if([arrayString isKindOfClass:[NSString class]]){
            if([arrayString.lowercaseString isEqualToString:string.lowercaseString]){
                return index;
            }
        }
        
    }
    return NSNotFound;
}



@end

@implementation NSMutableArray (StringHelper)

-(void) removeString:(NSString *)string caseSensitive:(BOOL) caseSensitive{
    if(caseSensitive){
        [self removeObject:string];
        return;
    }
    
    NSString *arrayString;
    for(NSInteger index=0; index<self.count; index++){
        arrayString =self[index];
        if([arrayString.lowercaseString isEqualToString:string.lowercaseString]){
            [self removeObject:arrayString];
            index--;
        }
    
    }
    
    
}

@end
