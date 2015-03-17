//
//  MAPViewController.h
//  MapKit1
//
//  Created by qianhua on 14-8-15.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<MapKit/MapKit.h>
#import "MyAnnotation.h";
@interface MAPViewController : UIViewController{
    MKMapView *myMapKit;

}
@property (nonatomic,retain) IBOutlet MKMapView *myMapKit;

@end
