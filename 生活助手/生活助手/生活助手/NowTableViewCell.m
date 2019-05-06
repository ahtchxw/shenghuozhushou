//
//  NowTableViewCell.m
//  简约天气通
//
//  Created by 胡潇炜 on 16/5/30.
//  Copyright © 2016年 胡潇炜. All rights reserved.
//

#import "NowTableViewCell.h"

@implementation NowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *condImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 130, 130)];
        self.condImageView = condImageView;
        [self addSubview:self.condImageView];
        
        
        UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 50, 60, 60)];
        tmpLabel.font = [UIFont fontWithName:@"DB LCD Temp" size:40];
        self.tmpLabel = tmpLabel;
        [self addSubview:self.tmpLabel];
        
        UILabel *c = [[UILabel alloc] initWithFrame:CGRectMake(270, 70, 30, 30)];
        c.text = @"℃";
        self.c = c;
        [self addSubview:self.c];
        
        UILabel *condLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 100, 100, 20)];
        self.condLabel = condLabel;
        [self addSubview:self.condLabel];
        
        UILabel *windLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 120, 100, 20)];
        self.windLabel = windLabel;
        [self addSubview:self.windLabel];
        
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel = dateLabel;
        [self addSubview:self.dateLabel];
        
        UIImageView *d_CondView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 10, 40, 40)];
        self.d_CondView = d_CondView;
        [self addSubview:self.d_CondView];
        
        UIImageView *n_CondView = [[UIImageView alloc]initWithFrame:CGRectMake(170, 10, 40, 40)];
        self.n_CondView = n_CondView;
        [self addSubview:self.n_CondView];
        
        UILabel *smallTmpLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 10, 100, 30)];
        smallTmpLabel.textAlignment = NSTextAlignmentCenter;
        self.smallTmpLabel = smallTmpLabel;
        [self addSubview:self.smallTmpLabel];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

@end
