//
//  SecondViewController.m
//  MapKit1
//
//  Created by qianhua on 14-8-16.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "SecondViewController.h"
#import "OtherViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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
    
    UIButton *pushBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pushBtn.frame=CGRectMake(20, 100, 100, 30);
    [pushBtn setBackgroundImage:[UIImage imageNamed:@"customcell_bg_pressed"] forState:UIControlStateNormal];
    [pushBtn setTitle:@"push" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushOtherView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];

}

-(void)pushOtherView:(UIButton *)pushBtn
{
    NSLog(@"pushOtherView");
    NSLog(@"self.navigationController : %@",self.navigationController);
    OtherViewController *otherView=[[OtherViewController alloc]init];
    //navigationController是nil 所以没有push出新界面
    [self.navigationController pushViewController:otherView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
