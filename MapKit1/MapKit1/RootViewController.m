//
//  RootViewController.m
//  MapKit1
//
//  Created by qianhua on 14-8-15.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "RootViewController.h"
#import "OtherViewController.h"
#import "SVProgressTestViewController.h"
#import "ASITestViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
	// Do any additional setup after loading the view.
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(120,90, 100, 30);
    [button setTitle:@"my button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showAlterView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview :button];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(120,120, 100, 30);
    [button2 setTitle:@"actionsheet" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(showActionView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview :button2];
    
    UIButton *pushBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pushBtn.frame=CGRectMake(120, 160, 100, 30);
//    pushBtn.backgroundColor=[UIColor grayColor];
    [pushBtn setBackgroundImage:[UIImage imageNamed:@"customcell_bg_pressed"] forState:UIControlStateNormal];
    [pushBtn setTitle:@"反向传值" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushOtherView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
    
    //进度条
    UIButton *push2Btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    push2Btn.frame=CGRectMake(120, 200 , 100, 30);
    [push2Btn setBackgroundImage:[UIImage imageNamed:@"customcell_bg_pressed"] forState:UIControlStateNormal];
    [push2Btn setTitle:@"进度条" forState:UIControlStateNormal];
    [push2Btn addTarget:self action:@selector(pushToSVProgressHUDView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push2Btn];
    
    //登录界面
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame=CGRectMake(120, 240 , 100, 30);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"customcell_bg_pressed"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录测试" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    
    
    
}

-(void)login:(UIButton *)loginBtn
{
    NSLog(@"pushToSVProgressHUDView");
    ASITestViewController *loginView=[[ASITestViewController alloc]init];
    loginView.title=@"登 录";
    [self.navigationController pushViewController:loginView animated:YES];
    
}

-(void)pushToSVProgressHUDView:(UIButton *)pushBtn
{
    NSLog(@"pushToSVProgressHUDView");
    SVProgressTestViewController *progressView=[[SVProgressTestViewController alloc]init];
    //progressView.title=@"加载进度条";
    [self.navigationController pushViewController:progressView animated:YES];
    
}

-(void)pushOtherView:(UIButton *)pushBtn
{
    NSLog(@"pushOtherView");
    OtherViewController *otherView=[[OtherViewController alloc]init];
    otherView.title=@"反向传值";//正向传值
    //    otherView.title=pushBtn.titleLabel.text;//正向传值
    otherView.delegate=self;
    [self.navigationController pushViewController:otherView animated:YES];
    
}

#pragma mark--SendValue
//OtherViewController中的协议实现方法
-(void)sendBtnTitle:(NSString *)title
{
    self.navigationItem.title=title;
}

int identifier=1;
-(void)showAlterView{
    
    UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"my title" message:@"you have a message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other1",@"other2", nil];
    alter.tag=identifier;
    [alter show];
    identifier++;
}
-(void)showActionView{
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"actionSheet"
            delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destructive" otherButtonTitles:@"other1",@"other2",@"other3",@"other4",@"other5",@"other6", nil];
    actionSheet.tag=identifier;
    [actionSheet showInView:self.view];
    
}

#pragma mark -AlterView Delegate
-(void) alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%d",buttonIndex);
    switch (buttonIndex) {
        case 0:
            NSLog(@"点击取消");
            break;
        case 1:
            NSLog(@"点击确定");
            break;
            
        default:
            break;
    }
    
}

#pragma mark -ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex:%d",buttonIndex);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
