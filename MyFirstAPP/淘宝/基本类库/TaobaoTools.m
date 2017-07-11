//
//  TaobaoTools.m
//  MyFirstAPP
//
//  Created by 薛超 on 16/8/25.
//  Copyright © 2016年 薛超. All rights reserved.
//

#import "TaobaoTools.h"

@implementation TaobaoTools
+ (NSDate *)strToDate:(NSString *)str {
    NSAssert(str.length >0, @"str date error");
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:str];
    return inputDate;
}

+ (NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time {
    
    int minute = (int)time / 60;
    int second = (int)time % 60;
    
    if (second > 9) { //2:10
        return [NSString stringWithFormat:@"%d:%d",minute,second];
    }
    
    //2:09
    return [NSString stringWithFormat:@"%d:0%d",minute,second];
}

+ (UIImage *)imageWithOriginalName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithStretchableName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (BOOL)isChinese:(NSString *)str {
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

+ (void)show:(nullable NSString *)msg {
    UILabel *_msgLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, 64)];
    _msgLab.backgroundColor = RGBACOLOR(0, 0, 0, 0.6);
    _msgLab.text = msg;
    _msgLab.textColor = [UIColor whiteColor];
    _msgLab.font = [UIFont boldSystemFontOfSize:18];
    _msgLab.textAlignment = NSTextAlignmentCenter;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_msgLab];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = _msgLab.frame;
        frame.origin.y = 0;
        _msgLab.frame = frame;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_msgLab removeFromSuperview];
    });
}

@end
