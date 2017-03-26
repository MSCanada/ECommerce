//
//  ShoppingItemCell.m
//  ecommercePlatform
//
//  Created by Muhammad Suhail on 2017-03-12.
//  Copyright © 2017 Muhammad Suhail. All rights reserved.
//

#import "ShoppingItemCell.h"

@implementation ShoppingItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

