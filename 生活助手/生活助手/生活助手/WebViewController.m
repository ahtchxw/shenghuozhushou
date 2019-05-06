//
//  WebViewController.m
//  生活助手
//
//  Created by Turing on 18/4/8.
//  Copyright © 2018年 hxw. All rights reserved.
//

#import "WebViewController.h"
#import "Masonry.h"

@interface WebViewController ()

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect bouds = [[UIScreen mainScreen]applicationFrame];
    UIWebView* webView = [[UIWebView alloc]initWithFrame:bouds];
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.aihyf.cn/supload/"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    
    NSLog(@"%@",request);
    [webView loadRequest:request];//加载
    
    self.webView = webView;
    
   [self.view addSubview:self.webView];
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    chooseBtn.frame = CGRectMake(110, 400, 100, 40);
    
    [chooseBtn addTarget:self action:@selector(back)forControlEvents:UIControlEventTouchUpInside];
    
    [chooseBtn setBackgroundColor:[UIColor brownColor]];
    
    [chooseBtn setTitle:@"返回"forState:UIControlStateNormal];
    
    [self.view addSubview:chooseBtn];
    

}


-(void)back
{
    [self.webView goBack];
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
