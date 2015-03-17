//
//  ASITestViewController.h
//  MapKit1
//
//  Created by qianhua on 14-12-6.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASITestViewController : UIViewController< UITextFieldDelegate >

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(UIButton *)sender;
@end
