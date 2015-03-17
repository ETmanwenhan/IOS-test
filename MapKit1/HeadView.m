//
//  HeadView.m
//  Test04
//
//  Created by HuHongbing on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView
@synthesize section,open,backBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open = NO;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 320, 45.5);
        [btn addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"customcell_bg"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"customcell_bg_pressed"] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithRed:73.0/255 green:173.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self addSubview:btn];
        self.backBtn = btn;
        
    }
    return self;
}

-(void)doSelected{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedWith:)]){
     	[self.delegate selectedWith:self];
    }
}
@end
