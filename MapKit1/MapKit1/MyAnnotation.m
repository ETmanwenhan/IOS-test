//
//  MyAnnotation.m
//  MapKit1
//
//  Created by qianhua on 14-8-15.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
-(CLLocationCoordinate2D) coordinate{
    CLLocationCoordinate2D center;
    center.latitude=40.029915f;
    center.longitude=116.347082f;
    return center;
}
-(NSString *)title {
    return  @"北京";
}
-(NSString *) subtitle
{
    return @"天安门";
}
@end
