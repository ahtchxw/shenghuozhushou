//
//  LifeStyleTableViewController.m
//  生活助手
//
//  Created by Turing on 18/4/14.
//  Copyright © 2018年 hxw. All rights reserved.
//

#import "LifeStyleTableViewController.h"
#import "AFNetworking.h"
#import "LifeTableViewCell.h"
#import "NowTableViewCell.h"
#import "MJChiBaoZiHeader.h"

@interface LifeStyleTableViewController ()

@property(nonatomic,strong)NSMutableArray *arr;

@end

@implementation LifeStyleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"生活指数";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj"]];
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(weatherData)];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)weatherData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather/lifestyle?location=auto_ip&key=9ebb4f12d9164806a20f7542824acae4"];
    NSString* url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",url);
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        
        NSMutableArray *arr = responseObject[@"HeWeather6"][0][@"lifestyle"];
        self.arr = arr;
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"failure");
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    LifeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LifeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        /**
         *
         comf：舒适度指数、cw：洗车指数、drsg：穿衣指数、flu：感冒指数、sport：运动指数、trav：旅游指数、uv：紫外线指数、air：空气污染扩散条件指数、ac：空调开启指数、ag：过敏指数、gl：太阳镜指数、mu：化妆指数、airc：晾晒指数、ptfc：交通指数、fsh：钓鱼指数、spi：防晒指数
         type	"comf"
         
         type	"drsg"
         
         type	"flu"
         
         type	"sport"
         
         type	"trav"
         
         type	"uv"
         
         type	"cw"
         
         type	"air"
         */
        cell.type.text = @"舒适指数";
        cell.brf.text = self.arr[indexPath.row][@"brf"];
        cell.txt.text = self.arr[indexPath.row][@"txt"];
        
    }
    else if (indexPath.row == 1) {

        cell.type.text = @"穿衣指数";
        cell.brf.text = self.arr[indexPath.row][@"brf"];
        cell.txt.text = self.arr[indexPath.row][@"txt"];
        
    }
    else if (indexPath.row == 2) {
        
        cell.type.text = @"感冒指数";
        cell.brf.text = self.arr[indexPath.row][@"brf"];
        cell.txt.text = self.arr[indexPath.row][@"txt"];
        
    }
    else if (indexPath.row == 3) {
        
        cell.type.text = @"运动指数";
        cell.brf.text = self.arr[indexPath.row][@"brf"];
        cell.txt.text = self.arr[indexPath.row][@"txt"];
        
    }
    else if (indexPath.row == 4) {
        
        cell.type.text = @"旅游指数";
        cell.brf.text = self.arr[indexPath.row][@"brf"];
        cell.txt.text = self.arr[indexPath.row][@"txt"];
        
    }
    else if (indexPath.row == 5) {
        
        cell.type.text = @"紫外线指数";
        cell.brf.text = self.arr[indexPath.row][@"brf"];
        cell.txt.text = self.arr[indexPath.row][@"txt"];
        
    }
    else if (indexPath.row == 6) {
        
        cell.type.text = @"洗车指数";
        cell.brf.text = self.arr[indexPath.row][@"brf"];
        cell.txt.text = self.arr[indexPath.row][@"txt"];
        
    }
    else if (indexPath.row == 7) {
        
        cell.type.text = @"空气污染扩散指数";
        cell.brf.text = self.arr[indexPath.row][@"brf"];
        cell.txt.text = self.arr[indexPath.row][@"txt"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
