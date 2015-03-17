//
//  MAPViewController.m
//  MapKit1
//
//  Created by qianhua on 14-8-15.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "MAPViewController.h"

@interface MAPViewController ()

@end

@implementation MAPViewController
@synthesize myMapKit;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*设置要显示的经纬度*/
    CLLocationCoordinate2D center;
    center.latitude=40.029915f;
    center.longitude=116.347082f;
    
    MKCoordinateSpan span;
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    MKCoordinateRegion region={center,span};
    [self.myMapKit setRegion:region];//设置当前地图位置中心
    
    MyAnnotation *ann1=[[MyAnnotation alloc]init];
    [self.myMapKit addAnnotation:ann1];
    
    
    //UIAlertView test
    UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"my title" message:@"you have a message" delegate:Nil cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
    
    [alter show];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
