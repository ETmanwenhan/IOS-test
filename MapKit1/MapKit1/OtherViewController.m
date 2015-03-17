//
//  OtherViewController.m
//  MapKit1
//
//  Created by qianhua on 14-8-16.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController
{
    UIButton *okBtn;
    UITextField *textFiel;
}
@synthesize delegate=_delegate;



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
    [self.view setBackgroundColor:[UIColor redColor]];
    NSArray *titles=[NSArray arrayWithObjects:@"title一" ,@"title二",@"title三",nil];
    for (int i=0; i<[titles count]; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(10, 60+i*40, 40, 50)];
        [self.view addSubview:btn];
    }
    
    textFiel= [[UITextField alloc]init];
    textFiel.frame=CGRectMake(10, 200, 300, 30);
    textFiel.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:textFiel];
    textFiel.delegate=self;
    textFiel.clearButtonMode=UITextFieldViewModeUnlessEditing;//设置清除模式样式
    //textFiel.text=@"传值";

    
    okBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [okBtn setTitle:@"OK" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setFrame:CGRectMake(10, 360, 300, 30)];
    okBtn.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:okBtn];
    //键盘弹出和收起的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
    
    
//    UITextField *textFiel2= [[UITextField alloc]init];
//    textFiel2.frame=CGRectMake(10, 260, 200, 30);
//    textFiel2.borderStyle=UITextBorderStyleRoundedRect;
//    [self.view addSubview:textFiel2];
//    textFiel2.delegate=self;
    

}
-(void) keyboardWillShow
{
    [UIView animateWithDuration:0.25 animations:^{
        okBtn.frame=CGRectMake(10, 240, 300, 30);
    }completion:^(BOOL finished) {
        
    }];
}

-(void) keyboardWillHide{
    [UIView animateWithDuration:0.25 animations:^{
        okBtn.frame=CGRectMake(10, 360, 300, 30);
    }completion:^(BOOL finished) {
        
    }];

}

-(void) okClick:(UIButton*) okbtn
{
    if ([textFiel.text isEqualToString:@""]) {
        NSLog(@"该值不能为空，请重新输入");
        [self showAlterView];
        return;
    }
    NSLog(@"okClick");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) titleClick:(UIButton *)btn
{
    NSLog(@"titleClick");
    NSString *title=btn.currentTitle;
    if ([_delegate respondsToSelector :@selector(sendBtnTitle:)]) {//实现类中已经实现了该代理方法
        [_delegate sendBtnTitle:title];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)showAlterView{
    
    UIAlertView *alter=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该值不能为空，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // return NO to disallow editing.
    return YES;//是否可以进入编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{// became first responder
    NSLog(@"进入编辑模式");
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    return YES;//是否可以退出编辑模式
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called;
    if ([_delegate respondsToSelector :@selector(sendBtnTitle:)]) {//实现类中已经实现了sendBtnTitle该代理方法
        [_delegate sendBtnTitle:textFiel.text];
    }
    NSLog(@"退出编辑模式");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{  // return NO to not change text
        return YES;

}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{// called when clear button pressed. return NO to ignore (no notifications)
    textField.text=@"";
    return YES;//是否可能点击清除按钮并进入编辑
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // called when 'return' key pressed. return NO to ignore.
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
