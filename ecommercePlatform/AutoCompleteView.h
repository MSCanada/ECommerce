//
//  AutoCompleteView.h
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-13.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol AutoCompleteViewDelegate <NSObject>

- (void)autoCompleteCellClickedWithTitleString:(NSString *)string;

@end

@interface AutoCompleteView  : UIView
@property (nonatomic, unsafe_unretained) id <AutoCompleteViewDelegate> delegate;

- (instancetype)initWithTextField:(UITextField *)textField;
- (void)setHeight;
- (void)reloadDataSourceUsingArray:(NSArray *)array andString:(NSString *)string;
@end
