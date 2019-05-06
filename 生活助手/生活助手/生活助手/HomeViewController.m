//
//  HomeViewController.m
//  简约天气通
//
//  Created by 胡潇炜 on 16/5/29.
//  Copyright © 2016年 胡潇炜. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "WeatherData.h"
#import "NowTableViewCell.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "SendViewController.h"
#import "LifeViewController.h"
#import "CommentViewController.h"

@interface HomeViewController ()

@property(nonatomic,strong)NSMutableArray *arr;

@property(nonatomic,strong)WeatherData *data;

@property(nonatomic,strong)NSString *city;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj"]];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"Paper airplane"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"appbar.feature.search.rest (2)"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [rightButton sizeToFit];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(weatherData)];
    
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)leftButtonPressed
{
    CommentViewController *view = [[CommentViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)rightButtonPressed
{
    LifeViewController *view = [[LifeViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
/**
 *  url:https://free-api.heweather.com/s6/weather/forecast?parameters
 */



//https://free-api.heweather.com/s6/weather/forecast?location=%@&key=9ebb4f12d9164806a20f7542824acae4

-(void)weatherData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather/forecast?location=auto_ip&key=9ebb4f12d9164806a20f7542824acae4"];
    NSString* url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",url);
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
 
        NSMutableArray *arr = responseObject[@"HeWeather6"][0][@"daily_forecast"];
        self.title = responseObject[@"HeWeather6"][0][@"basic"][@"location"];
        self.arr = arr;
        [self.tableView.mj_header endRefreshing];

        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"failure");
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    NowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        NSDictionary *dic = self.arr[indexPath.row];
        
        WeatherData *data = [WeatherData accoutWithDic:dic];
        cell.condLabel.text = data.cond_txt_d;
        cell.windLabel.text = data.wind_dir;
        cell.tmpLabel.text = data.tmp_max;
        [cell.condImageView setImage:[UIImage imageNamed:data.cond_code_d]];
        
    }else{
        cell.c.hidden = YES;
        
        NSDictionary *dic = self.arr[indexPath.row-1];
        
        WeatherData *data = [WeatherData accoutWithDic:dic];
        
        cell.dateLabel.text = data.date;
        cell.smallTmpLabel.text = [NSString stringWithFormat:@"%@℃/%@℃",data.tmp_max,data.tmp_min];
        
        [cell.d_CondView setImage:[UIImage imageNamed:data.cond_code_d]];
        
        [cell.n_CondView setImage:[UIImage imageNamed:data.cond_code_n]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }else{
        return 50;
    }
    
}


@end
