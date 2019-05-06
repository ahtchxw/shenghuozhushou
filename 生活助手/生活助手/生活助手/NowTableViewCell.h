//
//  NowTableViewCell.h
//  简约天气通
//
//  Created by 胡潇炜 on 16/5/30.
//  Copyright © 2016年 胡潇炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NowTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *condImageView;

@property(nonatomic,strong)UILabel *tmpLabel;

@property(nonatomic,strong)UILabel *c;

@property(nonatomic,strong)UILabel *condLabel;

@property(nonatomic,strong)UILabel *windLabel;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UIImageView *d_CondView;

@property(nonatomic,strong)UIImageView *n_CondView;

@property(nonatomic,strong)UILabel *smallTmpLabel;

@end
