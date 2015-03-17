//
//  GlobalClass.h
//  MapKit1
//
//  Created by qianhua on 14-12-10.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalClass : NSObject{
    NSString *G_userid;
    NSString *G_user;
    NSString *G_username;
    NSString *G_password;
    NSString *G_sex;
    NSString *G_birth;
    NSString *G_addr;
    NSString *G_native_palce;//籍贯
    NSString *G_linkman;//联系人
    NSString *G_linkman_call;
    NSString *G_email;
    NSString *G_hashcode;//MD5码
    NSString *G_partyid;
    
    NSString *dbPath;//数据库文件及路径
}
@property(strong , nonatomic)NSString *G_userid;
@property(strong , nonatomic)NSString *G_user;
@property(strong , nonatomic)NSString *G_username;
@property(strong , nonatomic)NSString *G_password;
@property(strong , nonatomic)NSString *G_sex;
@property(strong , nonatomic)NSString *G_birth;
@property(strong , nonatomic)NSString *G_addr;
@property(strong , nonatomic)NSString *G_native_palce;
@property(strong , nonatomic)NSString *G_linkman;
@property(strong , nonatomic)NSString *G_linkman_call;
@property(strong , nonatomic)NSString *G_email;
@property(strong , nonatomic)NSString *G_hashcode;
@property(strong , nonatomic)NSString *G_partyid;

@property(strong , nonatomic) NSString *dbPath;
+(GlobalClass *)sharedSingleton;
@end
