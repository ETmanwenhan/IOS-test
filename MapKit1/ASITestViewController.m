//
//  ASITestViewController.m
//  MapKit1
//
//  Created by qianhua on 14-12-6.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "ASITestViewController.h"
#import "ASIHTTPRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "GlobalClass.h"

@interface ASITestViewController ()

@end

@implementation ASITestViewController

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
    self.userName.delegate=self;
    self.password.delegate=self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(UIButton *)sender {
    /***************生成hash码*************/
    NSString *str = [NSString stringWithFormat:@"%@%@qianhuabio",[self.userName.text uppercaseString],self.password.text];
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    NSString *hashcode = [hash lowercaseString];
    //请求网络
    NSString *urlstr = [NSString stringWithFormat:@"http://bestonn.cn:8080/apex/QUSER_PATIENT_LOGIN_ADHD?username=%@&hashcode=%@",
                        self.userName.text,hashcode];
    NSURL *url = [NSURL URLWithString:urlstr];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];//同步
    
    NSError *error = [request error];
    if (error) {
        NSLog(@"login error is %@",error);
//        self.HUD.labelText = @"网络错误，连接不到服务器";
//        sleep(1);
        return;
    }else{
        NSString *response = [request responseString];
        NSLog(@"longin response is %@",response);
        NSData *data=[response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [GlobalClass sharedSingleton].G_userid= [responseDic objectForKey:@"USER_ID"];
        [GlobalClass sharedSingleton].G_hashcode= hashcode;
        NSString *ACTIVATE_DATE=[responseDic objectForKey:@"ACTIVATE_DATE"];
        NSString *FIRST_CONNECT_TIME=[responseDic objectForKey:@"FIRST_CONNECT_TIME"];
        
        UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"提示" message:@"Login Success" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // called when 'return' key pressed. return NO to ignore.
    [textField resignFirstResponder];
    return YES;
}
@end
