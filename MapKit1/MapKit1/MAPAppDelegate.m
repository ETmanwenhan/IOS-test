//
//  MAPAppDelegate.m
//  MapKit1
//
//  Created by qianhua on 14-8-15.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "MAPAppDelegate.h"
#import "MAPViewController.h"
#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UserCenterViewController.h"
//#import <UIKit/UIKit.h>

@implementation MAPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    RootViewController *rootVC=[[RootViewController alloc]init];
    self.nav=[[UINavigationController alloc]initWithRootViewController:rootVC];
    self.nav.title=@"主页";
    self.nav.tabBarItem.image=[UIImage imageNamed:@"30x-Key.png"];
    
    MAPViewController *mapVC=[[MAPViewController alloc]init];//自定义视图控制器
    mapVC.title=@"地图";
    mapVC.tabBarItem.image=[UIImage imageNamed:@"30x-Stop-Light.png"];
    
    FirstViewController *firstVC= [[FirstViewController alloc]init];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:firstVC];
    nav3.title=@"课程";
    nav3.tabBarItem.image=[UIImage imageNamed:@"30x-Picture.png"];
    
    SecondViewController *SecondVC= [[SecondViewController alloc]init];
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:SecondVC];
    nav4.title=@"收藏";
    nav4.tabBarItem.image=[UIImage imageNamed:@"30x-Link.png"];
    
    UserCenterViewController *userCenterVC=[[UserCenterViewController alloc]init];
    UINavigationController *nav5=[[UINavigationController alloc]initWithRootViewController:userCenterVC];
    nav5.title=@"个人中心";
    nav5.tabBarItem.image=[UIImage imageNamed:@"30x-Tools.png"];
    nav5.tabBarItem.badgeValue=@"new";
//    UIViewController *vc3= [[UIViewController alloc]init];
//    vc3.title=@"个人中心";
//    vc3.tabBarItem.image=[UIImage imageNamed:@"30x-Tools.png"];
//    vc3.tabBarItem.badgeValue=@"微标";
    NSArray *controllers=[NSArray arrayWithObjects:self.nav,mapVC,nav3,nav4,nav5,nil ];
    
    UITabBarController *tabController=[[UITabBarController alloc]init];
    tabController.delegate=self;
    tabController.viewControllers=controllers;
//    tabController.selectedViewController=mapVC;
    self.window.rootViewController=tabController;
    
    NSString *viewControllerTitle=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectkey"];
    if (viewControllerTitle) {
        for (UIViewController *vc in controllers) {
            if ([vc.title isEqualToString:viewControllerTitle]) {
                tabController.selectedViewController=vc;
            }
        }
    }

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -UITabBarControllerDelegate
-(BOOL) tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

/*每次点击时触发此方法*/
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"selected title:%@",viewController.title);
    
    NSUserDefaults *defatults=[NSUserDefaults standardUserDefaults];
    if (viewController.title) {
        [defatults setObject:viewController.title forKey:@"selectkey"];
        [defatults synchronize];
    }
    if ([viewController.title isEqualToString:@"收藏"]) {

    }
    
}


@end
