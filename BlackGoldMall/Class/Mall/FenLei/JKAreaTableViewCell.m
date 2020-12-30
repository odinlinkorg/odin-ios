//
//  JKAreaTableViewCell.m
//  CIO领域demo
//
//  Created by 王冲 on 2017/11/14.
//  Copyright © 2017年 希爱欧科技有限公司. All rights reserved.
//

#import "JKAreaTableViewCell.h"

@implementation JKAreaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithRed:(245)/255.0 green:(245)/255.0 blue:(245)/255.0 alpha:1];
        /*
         *  标题的添加
         */
        _nameText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 57.0)];
        _nameText.backgroundColor = [UIColor whiteColor];
        _nameText.textColor = [UIColor colorWithRed:(51)/255.0 green:(51)/255.0 blue:(51)/255.0 alpha:1];
        _nameText.textAlignment = NSTextAlignmentCenter;
        _nameText.font = [UIFont systemFontOfSize:14.f];
        [self.contentView addSubview:_nameText];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
