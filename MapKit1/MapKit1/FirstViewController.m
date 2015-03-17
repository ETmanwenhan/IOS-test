//
//  FirstViewController.m
//  MapKit1
//
//  Created by qianhua on 14-8-16.
//  Copyright (c) 2014年 Guangzhou Qianhua Biological Science and Technology Co.Ltd. All rights reserved.
//

#import "FirstViewController.h"
#import "ASIHTTPRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "SVProgressHUD.h"
#import "HeadView.h"
#import "Detail_Plan_Cell.h"
#import "FMDatabase.h";
#import "GlobalClass.h"

@interface FirstViewController ()

@property (nonatomic) NSInteger currentSection;

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //提前加载好数据
        self.dataList = [[NSMutableArray alloc]init];//初始化
        [self loadData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"基础课程";
//    NSMutableArray *list = [NSMutableArray arrayWithObjects:@"武汉",@"上海",@"北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津", @"广东", nil];
//    self.dataList = [[NSMutableArray alloc]init];//初始化
    //初始化UITableView
    self.view.frame = CGRectMake(0, 66, self.view.frame.size.width,self.view.frame.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    
//    [self loadData];//性能不够好
    [self loadModel];
    
}
/*加载网络数据或者本地直接取出数据*/
-(void)loadData
{
    ////////////////设置数据库文件名及路径，用户名id对应数据库名///////////////////
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [GlobalClass sharedSingleton].G_userid = @"wenhan";
    NSString *name_db = [NSString stringWithFormat:@"%@.sqlite",[GlobalClass sharedSingleton].G_userid];
    NSString *db_Paths =  [documentsDirectory stringByAppendingPathComponent:name_db];
    [GlobalClass sharedSingleton].dbPath = db_Paths;
    
    FMDatabase * db = [FMDatabase databaseWithPath:[GlobalClass sharedSingleton].dbPath];
    if ([db open])
    {
        /**先判断表是否存在**/
        FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type = ? and name = ?",@"table",@"DEFAULT_TRAIN_PLAN"];
        BOOL table_exist = NO;
        while ([rs next])
        {
            NSInteger count = [rs intForColumn:@"count"];
            NSLog(@"DEFAULT_TRAIN_PLAN exist = %d", count);
            
            if (0 == count)
            {
                table_exist =  NO;
            }else{
                table_exist = YES;
            }
        }
        NSLog(@"table_exist %@",table_exist?@"YES":@"NO");
        if (table_exist){
            //表存在 则本地取数据
            NSLog(@"DEFAULT_TRAIN_PLAN exist");
            self.plan_array = nil;
            self.plan_array = [[NSMutableArray alloc]init];
            FMResultSet * rs2 = [db executeQuery:@"select * from DEFAULT_TRAIN_PLAN"];
            while ([rs2 next]){
                NSMutableDictionary *test_plan = [[NSMutableDictionary alloc] init];
                [test_plan setValue:[rs2 stringForColumn:@"TRAINING_PLAN_ID"] forKey:@"TRAINING_PLAN_ID"];
                [test_plan setValue:[rs2 stringForColumn:@"ARGUE_NAME"] forKey:@"ARGUE_NAME"];
                [test_plan setValue:[rs2 stringForColumn:@"TEMPO_INTERVAL"] forKey:@"TEMPO_INTERVAL"];
                [test_plan setValue:[rs2 stringForColumn:@"TEMPO"] forKey:@"TEMPO"];
                [test_plan setValue:[rs2 stringForColumn:@"DESCRIPTION"] forKey:@"DESCRIPTION"];
                [test_plan setValue:[rs2 stringForColumn:@"SERIAL_NUM"] forKey:@"SERIAL_NUM"];
                [test_plan setValue:[rs2 stringForColumn:@"UNUSED"] forKey:@"UNUSED"];
                [self.plan_array addObject:test_plan];
            }
            NSLog(@"base plan_array has:%d",[self.plan_array count]);
            
            //清空表 test
//            NSString * sql = @"DELETE FROM DEFAULT_TRAIN_PLAN";
//            BOOL res = [db executeUpdate:sql];
//            if (res) {
//                NSLog(@"DELETE OK");
//            }else{
//                NSLog(@"DELETE error");
//            }
            
        }
        
        if (table_exist==NO || [self.plan_array count]==0){
            //表不存在 则下载并创建
            
            [SVProgressHUD showWithStatus:@"正在加载中..."];
            /***************生成hash码*************/
            NSString *str = [NSString stringWithFormat:@"%@%@qianhuabio",@"WENHAN3",@"123456"];
            const char *original_str = [str UTF8String];
            unsigned char result[CC_MD5_DIGEST_LENGTH];
            CC_MD5(original_str, strlen(original_str), result);
            NSMutableString *hash = [NSMutableString string];
            for (int i = 0; i < 16; i++)
                [hash appendFormat:@"%02X", result[i]];
            NSString *hashcode = [hash lowercaseString];
            
            NSString *urlstr = [[NSString alloc] initWithFormat:@"http://bestonn.cn:8080/apex/QUSER_NEW_PLAN?userid=%@&partyid=&hashcode=%@",@"242",hashcode];
            NSLog(@"%@",urlstr);
            NSURL *url = [NSURL URLWithString:urlstr];
            //发送请求
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request startSynchronous];
            NSError *error = [request error];
            //判断请求是否出错
            NSString *response = nil;
            if (error) {
                
                NSLog(@"update default plan error:%@",error);
                [SVProgressHUD dismissWithError:@"加载异常"];
                return;
            }
            
            if(!error){
                
                [SVProgressHUD dismissWithSuccess:@"加载成功"];
                response = [request responseString];
                if (response.length>10) {
                    NSData *response_data = [response dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *plan_data = [NSJSONSerialization JSONObjectWithData:response_data options:NSJSONReadingMutableContainers error:&error];
                    self.plan_array = [plan_data objectForKey:@"plan"];
                    NSLog(@"base plan array %D",[self.plan_array count]);
                    
                    [self.dataList removeAllObjects];
                    for (NSMutableDictionary *data_tmp in self.plan_array) {
                        [self.dataList addObject:[data_tmp objectForKey:@"ARGUE_NAME"]];
                    }
                    /**DB**/
                    if ([db open]) {
                        NSString * sql = @"CREATE TABLE IF NOT EXISTS 'DEFAULT_TRAIN_PLAN' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'TRAINING_PLAN_ID' TEXT, 'ARGUE_NAME' TEXT, 'TEMPO_INTERVAL' TEXT, 'TEMPO' TEXT, 'DESCRIPTION' TEXT, 'SERIAL_NUM' TEXT, 'UNUSED' TEXT)";
                        BOOL res = [db executeUpdate:sql];
                        if (!res) {
                            NSLog(@"error when creating db DEFAULT_TRAIN_PLAN table");
                        } else {
                            NSLog(@"succ to creating db DEFAULT_TRAIN_PLAN table");
                        }
                    }
                    
                    /**向表中插入数据**/
                    for (NSMutableDictionary *data_tmp in self.plan_array) {
                        NSString *sql_insert = @"insert into DEFAULT_TRAIN_PLAN (TRAINING_PLAN_ID, ARGUE_NAME, TEMPO_INTERVAL, TEMPO, DESCRIPTION, SERIAL_NUM, UNUSED) values (?,?,?,?,?,?,?)";
                        BOOL res = [db executeUpdate:sql_insert,
                                    [data_tmp objectForKey:@"TRAINING_PLAN_ID"],
                                    [data_tmp objectForKey:@"ARGUE_NAME"],
                                    [data_tmp objectForKey:@"TEMPO_INTERVAL"],
                                    [data_tmp objectForKey:@"TEMPO"],
                                    [data_tmp objectForKey:@"DESCRIPTION"],
                                    [data_tmp objectForKey:@"SERIAL_NUM"],
                                    [data_tmp objectForKey:@"UNUSED"]];
                        if (!res) {
                            NSLog(@"error to insert data");
                        } else {
                            NSLog(@"succ to insert data");
                        }
                    }
                    
                }
            }
        }
        
        [db close];
    }


}


- (void)loadModel{
//    _currentRow = -1;
    self.headViewArray = [[NSMutableArray alloc]init ];
    
    self.su_train_date_str = [[[self.plan_array objectAtIndex:0] objectForKey:@"SU_TRAIN_DATE"] substringWithRange:NSMakeRange(0,10)];
    self.formatter=[[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM-dd"];
    self.su_train_date = [self.formatter dateFromString:self.su_train_date_str];
    
    NSString *current_date_str = [self.formatter stringFromDate:[NSDate date]];
    NSDate *current_date = [self.formatter dateFromString:current_date_str];
    
    for(int i = 1;i<= [self.plan_array count]/6 ;i++)
	{
		HeadView* headview = [[HeadView alloc] init];
        headview.delegate =self;
		headview.section = i;
        [headview.backBtn setTitleColor:[UIColor colorWithRed:73.0/255 green:173.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
        [headview.backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        //        NSDate *date_tmp = [NSDate dateWithTimeInterval:(i-1)*86400 sinceDate:self.create_date];
        //        NSString *date_tmp_str = [self.formatter stringFromDate:date_tmp];
        
        [headview.backBtn setTitle:[NSString stringWithFormat:@"第%d天",i] forState:UIControlStateNormal];
        [headview.backBtn setTitle:[NSString stringWithFormat:@"第%d天",i] forState:UIControlStateSelected];
        
//        NSString *FIRST_CONNECT_TIME_STR = [[GlobalClass sharedSingleton].G_data_plist objectForKey:@"FIRST_CONNECT_TIME"];
        NSString *FIRST_CONNECT_TIME_STR=@"2014-12-9 14:05";
        
        if (![FIRST_CONNECT_TIME_STR isEqualToString:@""]){
            NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSDate *FIRST_CONNECT_TIME = [dateFormatter dateFromString:FIRST_CONNECT_TIME_STR];
            NSDate *choose_date = [NSDate dateWithTimeInterval:(i-1)*86400 sinceDate:FIRST_CONNECT_TIME];
            NSInteger timeinterval_tmp = (NSInteger)[choose_date timeIntervalSinceDate:current_date];
            if ((timeinterval_tmp/86400) == 0) {
                [headview.backBtn setBackgroundImage:[UIImage imageNamed:@"customcell_bg_pressed"] forState:UIControlStateNormal];
                [headview.backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            if ((timeinterval_tmp/86400) > 0) {
                headview.backBtn.enabled = NO;
                headview.backBtn.backgroundColor = [UIColor grayColor];
            }
        }else{
            headview.backBtn.enabled = NO;
            headview.backBtn.backgroundColor = [UIColor grayColor];
            if (i == 1) {
                headview.backBtn.enabled = YES;
                [headview.backBtn setBackgroundImage:[UIImage imageNamed:@"customcell_bg_pressed"] forState:UIControlStateNormal];
                [headview.backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
        
		[self.headViewArray addObject:headview];
		
	}
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HeadView* headView = [self.headViewArray objectAtIndex:section];
    return headView.open?1:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Detail_Plan_CellIdentifier";
    Detail_Plan_Cell *cell = (Detail_Plan_Cell*)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        //将Custom.xib中的所有对象载入
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Detail_Plan_Cell" owner:nil options:nil];
        //第一个对象就是CustomCell了
        cell = [nib objectAtIndex:0];
        cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customcell_bg.png"] highlightedImage:[UIImage imageNamed:@"customcell_bg_pressed.png"]];
        //        detail_plan_cell = [[Detail_Plan_Cell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    NSUInteger row = [indexPath row];
    NSDictionary *first_plan = [self.plan_array objectAtIndex:row*3+0+(self.currentSection-1)*6];
    NSDictionary *second_plan = [self.plan_array objectAtIndex:row*3+1+(self.currentSection-1)*6];
    NSDictionary *third_plan = [self.plan_array objectAtIndex:row*3+2+(self.currentSection-1)*6];
    NSDictionary *fourth_plan = [self.plan_array objectAtIndex:row*3+3+(self.currentSection-1)*6];
    NSDictionary *fifth_plan = [self.plan_array objectAtIndex:row*3+4+(self.currentSection-1)*6];
    NSDictionary *sixth_plan = [self.plan_array objectAtIndex:row*3+5+(self.currentSection-1)*6];
    switch (row) {
        case 0:
            cell.first_train_label.text = [NSString stringWithFormat:@"听声音提示%@敲%@次",[first_plan objectForKey:@"ARGUE_NAME"],[first_plan objectForKey:@"TEMPO"]];
            cell.second_train_label.text = [NSString stringWithFormat:@"听声音提示%@敲%@次",[second_plan objectForKey:@"ARGUE_NAME"],[second_plan objectForKey:@"TEMPO"]];
            cell.third_train_label.text = [NSString stringWithFormat:@"听声音提示%@敲%@次",[third_plan objectForKey:@"ARGUE_NAME"],[third_plan objectForKey:@"TEMPO"]];
            cell.fourth_train_label.text = [NSString stringWithFormat:@"听声音提示%@敲%@次",[fourth_plan objectForKey:@"ARGUE_NAME"],[fourth_plan objectForKey:@"TEMPO"]];
            cell.fifth_train_label.text = [NSString stringWithFormat:@"听声音提示%@敲%@次",[fifth_plan objectForKey:@"ARGUE_NAME"],[fifth_plan objectForKey:@"TEMPO"]];
            cell.sixth_train_label.text = [NSString stringWithFormat:@"听声音提示%@敲%@次",[sixth_plan objectForKey:@"ARGUE_NAME"],[sixth_plan objectForKey:@"TEMPO"]];
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    _currentRow = indexPath.row;
    NSUInteger row = [indexPath row];
    NSDictionary *first_plan = [self.plan_array objectAtIndex:row*3+0+(self.currentSection-1)*6];
    NSDictionary *second_plan = [self.plan_array objectAtIndex:row*3+1+(self.currentSection-1)*6];
    NSDictionary *third_plan = [self.plan_array objectAtIndex:row*3+2+(self.currentSection-1)*6];
    NSDictionary *fourth_plan = [self.plan_array objectAtIndex:row*3+3+(self.currentSection-1)*6];
    NSDictionary *fifth_plan = [self.plan_array objectAtIndex:row*3+4+(self.currentSection-1)*6];
    NSDictionary *sixth_plan = [self.plan_array objectAtIndex:row*3+5+(self.currentSection-1)*6];
    NSLog(@"position %i",row*3+0+(self.currentSection-1)*6);
    NSLog(@"didSelectRowAtIndexPath %@",[first_plan objectForKey:@"ARGUE_NAME"]);
    NSLog(@"didSelectRowAtIndexPath %@",[second_plan objectForKey:@"ARGUE_NAME"]);
    NSLog(@"didSelectRowAtIndexPath %@",[third_plan objectForKey:@"ARGUE_NAME"]);
    NSLog(@"didSelectRowAtIndexPath %@",[fourth_plan objectForKey:@"ARGUE_NAME"]);
    NSLog(@"didSelectRowAtIndexPath %@",[first_plan objectForKey:@"ARGUE_NAME"]);
    NSLog(@"didSelectRowAtIndexPath %@",[sixth_plan objectForKey:@"ARGUE_NAME"]);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    
    return headView.open?160:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.headViewArray objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.headViewArray count];
}

#pragma mark - HeadViewDelegate

-(void)selectedWith:(HeadView *)view
{
    NSLog(@"selectedWith %d",view.section);
    _currentSection = view.section;
    
    if (view.open) {
        for(int i = 0;i<[self.headViewArray count];i++)
        {
            HeadView *head = [self.headViewArray objectAtIndex:i];
            head.open = NO;
        }
        [self.tableView reloadData];
        return;
    }

    NSString *date_tmp_str = [[self.plan_array objectAtIndex:(_currentSection-1)*6]objectForKey:@"SU_TRAIN_DATE"];
    NSDate *choose_date = [self.formatter dateFromString:date_tmp_str];
    NSString *current_date_str = [self.formatter stringFromDate:[NSDate date]];
    NSDate *current_date = [self.formatter dateFromString:current_date_str];
    NSInteger timeinterval_tmp = (NSInteger)[choose_date timeIntervalSinceDate:current_date];
    if ((timeinterval_tmp/86400)>0) {
        return;
    }
    
    [self reset];
}


//界面重置
- (void)reset
{
    for(int i = 0;i<[self.headViewArray count];i++)
    {
        HeadView *head = [self.headViewArray objectAtIndex:i];
        
        if(head.section == _currentSection)
        {
            NSString *date_tmp_str = [[self.plan_array objectAtIndex:i*6]objectForKey:@"SU_TRAIN_DATE"];
            NSDate *choose_date = [self.formatter dateFromString:date_tmp_str];
            NSString *current_date_str = [self.formatter stringFromDate:[NSDate date]];
            NSDate *current_date = [self.formatter dateFromString:current_date_str];
            NSInteger timeinterval_tmp = (NSInteger)[choose_date timeIntervalSinceDate:current_date];
            if ((timeinterval_tmp/86400)>0) {
                return;
            }
            
            head.open = YES;
        }else {
            
            head.open = NO;
        }
        
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end