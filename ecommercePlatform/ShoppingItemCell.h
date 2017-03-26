//
//  ShoppingItemCell.h
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-12.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingItemCell : UITableViewCell
@property (strong, nonatomic) NSString *pass;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxImage;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemNotesLabel;

@end
