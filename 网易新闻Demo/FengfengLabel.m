//  FengfengLabel.m
//  网易新闻Demo
//  Created by bailing on 2018/4/4.
//  Copyright © 2018年 zhufeng. All rights reserved.
//
#import "FengfengLabel.h"
#import "FengfengConst.h"
@implementation FengfengLabel
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorWithRed:XMGRed green:XMGGreen blue:XMGBlue alpha:XMGAlpha];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)setScale:(CGFloat)scale{
    _scale = scale;
    //  R G B
    // 默认：0.4 0.6 0.7
    // 红色：1   0   0
    CGFloat red = XMGRed + (1 - XMGRed) * scale;
    CGFloat green = XMGGreen + (0 - XMGGreen) * scale;
    CGFloat blue = XMGBlue + (0 - XMGBlue) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.3; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}
@end
