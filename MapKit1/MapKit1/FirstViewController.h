//
//  FirstViewController.h
//  MapKit1
//
//  Created by qianhua on 14-8-16.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataList;
@property (strong, nonatomic) NSMutableArray *plan_array;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *headViewArray;
@property (strong, nonatomic) NSString *su_train_date_str;
@property (strong, nonatomic) NSDateFormatter *formatter;
@property (strong, nonatomic) NSDate *su_train_date;

@end
