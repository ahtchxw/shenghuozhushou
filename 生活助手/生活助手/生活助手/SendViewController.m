//
//  SendViewController.m
//  生活助手
//
//  Created by Turing on 18/4/15.
//  Copyright © 2018年 hxw. All rights reserved.
//

#import "SendViewController.h"
#import "AFNetworking.h"
@interface SendViewController ()

@property(nonatomic,strong)UITextField *textFeild;

@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发送评论";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj"]];

    
    UITextField *textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 80, 300, 100)];
    
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"此处输入评论。。。";
    
    textField.adjustsFontSizeToFitWidth = YES;
    
    self.textFeild = textField;
    
    [self.view addSubview:self.textFeild];
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    chooseBtn.frame = CGRectMake(85, 450, 150, 40);
    
    [chooseBtn addTarget:self action:@selector(sendComment)forControlEvents:UIControlEventTouchUpInside];
    
    [chooseBtn setBackgroundColor:[UIColor brownColor]];
    
    [chooseBtn setTitle:@"发送评论"forState:UIControlStateNormal];
    
    [self.view addSubview:chooseBtn];
    
    
}

-(void)sendComment
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"]=@"4229028850388094";
    params[@"access_token"] = @"2.00Y7JQkFcAhipCb164624fd9sozrLB";
//    NSString* text = [self.textFeild.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    params[@"comment"]= self.textFeild.text;
    
    NSLog(@"%@",self.textFeild.text);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/2/comments/create.json"];
    NSString* url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",url);
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
