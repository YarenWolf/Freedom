//
//  XFComposeToolbar.h
//  Weibo
//
//  Created by Fay on 15/10/14.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    XFComposeToolbarButtonTypeCamera, // 拍照
    XFComposeToolbarButtonTypePicture, // 相册
    XFComposeToolbarButtonTypeMention, // @
    XFComposeToolbarButtonTypeTrend, // #
    XFComposeToolbarButtonTypeEmotion // 表情
} XFComposeToolbarButtonType;


@class XFComposeToolbar;
@protocol XFComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(XFComposeToolbar *)toolbar didClickButton:(XFComposeToolbarButtonType)buttonType;

@end

@interface XFComposeToolbar : UIView
@property (nonatomic,weak) id<XFComposeToolbarDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com