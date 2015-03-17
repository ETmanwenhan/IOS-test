//
//  CustomCell.m
//  payou
//
//  Created by chqb89 on 13-7-17.
//  Copyright (c) 2013年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customcell_bg.png"] highlightedImage:[UIImage imageNamed:@"customcell_bg_pressed.png"]];
        //        self.backgroundColor = [UIColor colorWithRed:255.0/255 green:251.0/255 blue:244.0/255 alpha:1];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor colorWithRed:123.0/255 green:116.0/255 blue:103.0/255 alpha:1];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.textColor = [UIColor colorWithRed:123.0/255 green:116.0/255 blue:103.0/255 alpha:1];
        self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
        //        self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customcell_bg_pressed.png"]];
        //        self.accessoryView.backgroundColor = [UIColor colorWithRed:79.0/255 green:179.0/255 blue:171.0/255 alpha:1];
        //        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_accessory.png"] highlightedImage:[UIImage imageNamed:@"cell_accessory_pressed.png"]];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    //    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"customcell_bg_pressed.png"]];
    // Configure the view for the selected state
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
        //        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_accessory_pressed.png"]];
        //        self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customcell_bg_pressed.png"]];
        //        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"customcell_bg_pressed.png"]];
    }
}

@end
