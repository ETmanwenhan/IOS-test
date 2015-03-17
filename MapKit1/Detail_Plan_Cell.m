//
//  Detail_Plan_Cell.m
//  payou
//
//  Created by chqb89 on 13-8-26.
//  Copyright (c) 2013年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "Detail_Plan_Cell.h"

@implementation Detail_Plan_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customcell_bg.png"] highlightedImage:[UIImage imageNamed:@"customcell_bg_pressed.png"]];
        self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
        
        for (UIView *v in self.subviews){
            if ([v isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)v;
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor colorWithRed:123.0/255 green:116.0/255 blue:103.0/255 alpha:1];
                label.textAlignment = NSTextAlignmentCenter;
            }
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
