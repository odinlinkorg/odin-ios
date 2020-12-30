//
//  JKReusableView.m
//  CIO领域demo
//
//  Created by 王冲 on 2017/11/14.
//  Copyright © 2017年 希爱欧科技有限公司. All rights reserved.
//

#import "JKReusableView.h"

@implementation JKReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width-69-9, 1)];
        _lineView.backgroundColor = [UIColor colorWithRed:(245)/255.0 green:(245)/255.0 blue:(245)/255.0 alpha:1];
        [self addSubview:_lineView];
        
        /*
         *  图片的添加
         */
        _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(16, 11, 18, 18)];
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        _iconImage.layer.cornerRadius = 4;
        _iconImage.clipsToBounds = YES;
        _iconImage.alpha = 1;
        [self addSubview:_iconImage];
        
//        _headText = [[UILabel alloc]initWithFrame:CGRectMake(42, 0, self.frame.size.width-42, 40)];
        _headText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-42, 40)];
        //_headText.backgroundColor = JKRandomColor;
        _headText.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_headText];
        
    }
    return self;
}


@end

