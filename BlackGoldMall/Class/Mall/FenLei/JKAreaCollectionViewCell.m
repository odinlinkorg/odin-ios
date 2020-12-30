//
//  JKAreaCollectionViewCell.m
//  CIO领域demo
//
//  Created by 王冲 on 2017/11/14.
//  Copyright © 2017年 希爱欧科技有限公司. All rights reserved.
//

#import "JKAreaCollectionViewCell.h"

@implementation JKAreaCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self layout];
    }
    
    return self;
}

-(void)layout{
    
    /*
    _bgV.backgroundColor = UIColor.whiteColor;
     *  名字的添加
     */
    int w = (int)self.frame.size.width;
    int h = (int)self.frame.size.height;
    
    
    _bgV = [[UILabel alloc]initWithFrame:CGRectMake(0,0, w, h)];
    _bgV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgV];
    
    _areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(21,15,w-45.0, w-45.0)];
    _areaImage.backgroundColor = [UIColor whiteColor];
   
//    UIImage *image = [UIImage imageNamed:@"mine_转账"];
//    _areaImage.image = image;
    _areaImage.contentMode =   UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_areaImage];
    
    
    _areaName = [[UILabel alloc]initWithFrame:CGRectMake(0,w-45 + 15,w, w -(w-45 + 15))];
//    _areaName.backgroundColor = [UIColor whiteColor];
    _areaName.font = [UIFont systemFontOfSize:14.f];
    _areaName.textColor = [UIColor colorWithRed:(51)/255.0 green:(51)/255.0 blue:(51)/255.0 alpha:1];
    _areaName.adjustsFontSizeToFitWidth = YES;
    _areaName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_areaName];
    
  
  
}

@end

