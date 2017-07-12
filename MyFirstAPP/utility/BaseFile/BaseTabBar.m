//
//  BaseTabBar.m
//  MyFirstAPP
//
//  Created by 薛超 on 16/9/20.
//  Copyright © 2016年 薛超. All rights reserved.
//

#import "BaseTabBar.h"
@interface BaseTabBar()
@property(nonatomic,weak)UIButton *centerButton;
@end
@implementation BaseTabBar
//告知系统动态处理delegate
@dynamic delegate;
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        UIButton *centerbutton=[[UIButton alloc]init];
        [centerbutton setImage:[UIImage imageNamed:@"sports.png"] forState:UIControlStateNormal];
        centerbutton.frame=CGRectMake(0, 0, centerbutton.currentImage.size.width, centerbutton.currentImage.size.height);
        [self addSubview:centerbutton];
        self.centerButton=centerbutton;
        //为centerButton添加时间
        [centerbutton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }return self;
}
-(void)centerButtonClick{
    if([self.delegate respondsToSelector:@selector(MyTabBarDidClickCenterButton:)]){
        [self.delegate MyTabBarDidClickCenterButton:self];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.设置中间按钮的位置
    self.centerButton.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5-12);
    
    //计算每个UITabBarButton的宽
    CGFloat tabbarButtonW = self.bounds.size.width/5;
    CGFloat buttonIndex = 0;
    
    //2.设置系统根据子vc创建的4个UITabBarButton的位置
    for (UIView *child in self.subviews) {
        //根据字符串做类名，找到该类型的类型信息
        Class class = NSClassFromString(@"UITabBarButton");
        //判断当前遍历到的子视图是否是class类型
        if ([child isKindOfClass:class]) {
            //先拿出button原有的frame
            CGRect frame = child.frame;
            //改子视图的宽
            frame.size.width = tabbarButtonW;
            //改子视图的x
            frame.origin.x = buttonIndex*tabbarButtonW;
            //再把改完的frame赋会给button
            child.frame = frame;
            buttonIndex++;
            if (buttonIndex==2) {
                buttonIndex++;
            }
        }
    }
}

@end
