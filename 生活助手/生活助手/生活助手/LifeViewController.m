//
//  LifeViewController.m
//  生活助手
//
//  Created by Turing on 18/4/14.
//  Copyright © 2018年 hxw. All rights reserved.
//

#import "LifeViewController.h"
#import "ZXView.h"
#import "AFNetworking.h"
#import "LifeStyleTableViewController.h"
@interface LifeViewController ()

@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"空气质量折线图";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj"]];
    ZXView * zx = [[ZXView alloc]initWithFrame:CGRectMake(10, 150, [UIScreen mainScreen].bounds.size.width - 20, 250)];
    [self.view addSubview:zx];
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    chooseBtn.frame = CGRectMake(85, 450, 150, 40);
    
    [chooseBtn addTarget:self action:@selector(seeOther)forControlEvents:UIControlEventTouchUpInside];
    
    [chooseBtn setBackgroundColor:[UIColor brownColor]];
    
    [chooseBtn setTitle:@"查看详细生活指数"forState:UIControlStateNormal];
    
    [self.view addSubview:chooseBtn];
    

}

-(void)seeOther
{
    LifeStyleTableViewController *view = [[LifeStyleTableViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
