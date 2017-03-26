//
//  UIColor+OrShopColors.m
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-07.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//

#import "UIColor+OrShopColors.h"

@implementation UIColor(eCommerce)
+ (UIColor *) frozenColor {
    return [UIColor colorWithRed:0.35 green:0.67 blue:0.89 alpha:1];
}

+ (UIColor *)coldColor {
    return [UIColor colorWithRed:0.54 green:0.76 blue:0.95 alpha:0.45]; // Jordy Blue
}

+ (UIColor *)ambientColor {
    return [UIColor whiteColor];
}

+ (UIColor *)warmColor {
    return [UIColor colorWithRed:0.94 green:0.28 blue:0.21 alpha:0.3]; // Flamingo
}

+ (UIColor *)hotColor {
    return [UIColor colorWithRed:0.94 green:0.28 blue:0.21 alpha:0.75]; // Flamingo
}

+ (UIColor *)highlightedCellColor {
    CGFloat floatNumber = 0.85f;
    return [UIColor colorWithRed:floatNumber green:floatNumber blue:floatNumber alpha:1.0f];
}







@end
