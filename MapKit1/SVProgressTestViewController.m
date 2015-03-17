//
//  SVProgressTestViewController.m
//  MapKit1
//
//  Created by qianhua on 14-12-6.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "SVProgressTestViewController.h"
#import "SVProgressHUD.h"

@interface SVProgressTestViewController ()

@end

@implementation SVProgressTestViewController

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
    self.title=@"进度条";
    //重新定义Back按钮
    UIBarButtonItem *leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    //隐藏返回按钮
//  [self.navigationItem setHidesBackButton:YES animated:YES];
    
}

-(void)back:(UIBarButtonItem *)barButtonItem{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(UIButton *)sender {
    [SVProgressHUD show];
}

- (IBAction)showWithStatus:(UIButton *)sender {
    [SVProgressHUD showWithStatus:@"正在努力加载中..." maskType:SVProgressHUDMaskTypeNone];
}

- (IBAction)dismiss:(UIButton *)sender {
    [SVProgressHUD dismiss];
}

- (IBAction)dismissWithSuccess:(UIButton *)sender {
    [SVProgressHUD dismissWithSuccess:@"成功加载"];
}

- (IBAction)dismissWithError:(UIButton *)sender {
    [SVProgressHUD dismissWithError:@"加载异常"];
}

@end
