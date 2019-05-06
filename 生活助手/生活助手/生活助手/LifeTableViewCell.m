//
//  LifeTableViewCell.m
//  生活助手
//
//  Created by Turing on 18/4/14.
//  Copyright © 2018年 hxw. All rights reserved.
//

#import "LifeTableViewCell.h"

@implementation LifeTableViewCell

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
        
        
        UILabel *type = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
        self.type = type;
        [self addSubview:self.type];
        
        UILabel *brf = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 30)];
        self.brf = brf;
        [self addSubview:self.brf];
        
        UILabel *txt = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 300, 80)];
        txt.numberOfLines = 0;
        self.txt = txt;
        [self addSubview:self.txt];
        
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

@end
