
//
//  XFIconView.m
//  Weibo
//
//  Created by Fay on 15/10/4.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "XFIconView.h"
#import "XFUser.h"
#import "UIImageView+WebCache.h"

@interface XFIconView ()
@property (nonatomic,weak)UIImageView *verifiedView;
@end
@implementation XFIconView

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    
    return self;
}

-(UIImageView *)verifiedView {
    
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc]init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    
    return _verifiedView;
    
}

-(void)setUser:(XFUser *)user {
    
    _user = user;
    
    // 1.下载图片
   [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 2.设置加V图片
    
    switch (user.verified_type) {
        case XFUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case XFUserVerifiedOrgEnterprice:
        case XFUserVerifiedOrgMedia:
        case XFUserVerifiedOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case XFUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES; // 当做没有任何认证
            break;
    
    }
    
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.verifiedView.frameSize = self.verifiedView.image.size;
    
    self.verifiedView.frameX = self.frameWidth - self.verifiedView.frameWidth * 0.6;
    self.verifiedView.frameY = self.frameHeight - self.verifiedView.frameHeight * 0.6;
    
    
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com