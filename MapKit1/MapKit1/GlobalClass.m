//
//  GlobalClass.m
//  MapKit1
//
//  Created by qianhua on 14-12-10.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//
#import "GlobalClass.h"

@implementation GlobalClass
@synthesize G_userid;
@synthesize G_user;
@synthesize G_username;
@synthesize G_password;
@synthesize G_sex;
@synthesize G_addr;
@synthesize G_native_palce;
@synthesize G_linkman_call;
@synthesize G_email;
@synthesize G_hashcode;
@synthesize G_partyid;

@synthesize dbPath;


+(GlobalClass *)sharedSingleton
{
    static GlobalClass *sharedSingleton;
    @synchronized(self)
    {
        if (!sharedSingleton) {
            sharedSingleton = [[GlobalClass alloc]init];
            
            return sharedSingleton;
        }
    }
    return sharedSingleton;


};
@end
