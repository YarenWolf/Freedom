//
//  ResumeDetailViewController.m
//  MyFirstAPP
//
//  Created by 薛超 on 16/9/5.
//  Copyright © 2016年 薛超. All rights reserved.
//

#import "ResumeDetailViewController.h"

@interface ResumeDetailViewController ()<UIWebViewDelegate>{
    UIWebView *webView;
}
@end
@implementation ResumeDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-TopHeight)];
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.userInfo[@"url"]]]];
    [self.view addSubview:webView];
}
@end
