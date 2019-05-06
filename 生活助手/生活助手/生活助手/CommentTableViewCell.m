//
//  CommentTableViewCell.m
//  试试
//
//  Created by Turing on 18/4/15.
//  Copyright © 2018年 hxw. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel *commentLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 80)];
        commentLable.numberOfLines = 0;
        self.commentLable = commentLable;
        [self addSubview:self.commentLable];
        
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

@end
