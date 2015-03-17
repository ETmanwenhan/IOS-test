//
//  OtherViewController.h
//  MapKit1
//
//  Created by qianhua on 14-8-16.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SendValue <NSObject>
-(void)sendBtnTitle:(NSString *)title;
@end

@interface OtherViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic ,assign) id <SendValue> delegate;

@end
