//
//  UserCenterViewController.m
//  MapKit1
//
//  Created by qianhua on 14-12-11.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "UserCenterViewController.h"
#import "CustomCell.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"个人中心";
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (!cell) {
        cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
//    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customcell_bg.png"] highlightedImage:[UIImage imageNamed:@"customcell_bg_pressed.png"]];
    NSUInteger row = [indexPath row];
    switch ([indexPath section]) {
        case 0:
            switch (row) {
                case 0:
                    cell.textLabel.text = @"个人资料";
                    break;
                case 1:
                    cell.textLabel.text = @"专家信息";
                    break;
                case 2:
                    cell.textLabel.text = @"修改密码";
                    break;
                default:
                    break;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_accessory.png"] highlightedImage:[UIImage imageNamed:@"cell_accessory_pressed.png"]];
            break;
        case 1:
            switch (row) {
                case 0:
                    cell.textLabel.text = @"帮助信息";
                    break;
                case 1:
                    cell.textLabel.text = @"关于Bestonn";
                    break;
                case 2:
                    cell.textLabel.text = @"软件更新";
                    break;
                default:
                    break;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_accessory.png"] highlightedImage:[UIImage imageNamed:@"cell_accessory_pressed.png"]];
            break;
        case 2:
            cell.textLabel.text = @"退出登录";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        default:
            break;
    }
    
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;

}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didDeselectRowAtIndexPath");

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
