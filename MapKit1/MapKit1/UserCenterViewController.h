//
//  UserCenterViewController.h
//  MapKit1
//
//  Created by qianhua on 14-12-11.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
