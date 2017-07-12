//  Created by 薛超 on 16/8/18.
//  Copyright © 2016年 薛超. All rights reserved.
#import "ToutiaoViewController.h"
#import "ToutiaoHomeSampleViewController.h"
static CGFloat const titleHeight = 40;
@interface ToutiaoViewController()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * titleScrollView;//标题ScrollView
@property (nonatomic,strong) UIScrollView * contentScrollView;//内容scrollView
@property (nonatomic,weak) UIButton * selTitlebutton;//标题中的按钮
@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,strong) NSMutableArray *titles;
@end
@implementation ToutiaoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ToutiaoBackBar"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles =[NSMutableArray arrayWithArray:@[@"这个",@"那个",@"好样的",@"么呢",@"打开",@"这个",@"那个",@"好样的",@"么呢"]];
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, titleHeight)];    //设置头标题栏
    [self.view addSubview: self.titleScrollView];
    [self.navigationController.navigationBar addSubview:self.titleScrollView];
    self.contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, YH(self.titleScrollView), kScreenWidth, kScreenHeight)];//设置内容 //添加自控制器
    [self.view addSubview:self.contentScrollView];
    for(int i=0;i<self.titles.count;i++){
        ToutiaoHomeSampleViewController *vc = [[ToutiaoHomeSampleViewController alloc]init];
        [self addChildViewController:vc];
    }
    self.buttons = [NSMutableArray array];//设置标题
    NSUInteger count = self.childViewControllers.count;
    for (int i = 0; i<count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i * 50, 0,50, titleHeight)];
        button.tag = i;
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        [self.buttons addObject:button];
        [self.titleScrollView addSubview:button];
        if(i == 0){
            [self click:button];
        }
    }
    self.titleScrollView.contentSize = CGSizeMake(count * 50, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * kScreenWidth, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
    [self.titleScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}


#pragma mark - 按钮点击时间改变contentScrollView的值
-(void) click:(UIButton *) button{
    NSUInteger i = button.tag;
    CGFloat x = i * kScreenWidth;
    //改变按钮
    [self setTitleBtn:button];
    UIViewController * vc = self.childViewControllers[i];
    if (vc.view.superview) {return;}
    vc.view.frame = CGRectMake(x, 0, kScreenWidth, kScreenHeight - YH(self.titleScrollView));
    [self.contentScrollView addSubview:vc.view];
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
}
#pragma  mark - 改变按钮
-(void) setTitleBtn:(UIButton *) button{
    [self.selTitlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selTitlebutton.transform = CGAffineTransformIdentity;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//文字变红
    button.transform = CGAffineTransformMakeScale(1.5, 1.5);//放大的效果,放大1.5倍
    self.selTitlebutton = button;
    //实现一个移动后标题居中//判断ScrollView的contentoffset的值
    CGFloat offset = button.center.x - kScreenWidth * 0.5 ;
    //在当前的左边
    if(offset < 0){offset = 0;}
    CGFloat maxOffset = self.titleScrollView.contentSize.width - kScreenWidth;
    if (offset > maxOffset) {offset = maxOffset;}
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}
#pragma mark - 利用协议解决滑动contentViewController
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger i = self.contentScrollView.contentOffset.x / kScreenWidth;
    [self setTitleBtn:self.buttons[i]];
    CGFloat x = i * kScreenWidth;
    UIViewController * vc = self.childViewControllers[i];
    if (vc.view.superview) {return;}
    vc.view.frame = CGRectMake(x, 0, kScreenWidth, kScreenHeight - YH(self.titleScrollView));
    [self.contentScrollView addSubview:vc.view];
}
#pragma mark - 实现字体颜色大小的渐变
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    //定义一个两个变量控制左右按钮的渐变
    NSInteger left = offset/APPW;
    NSInteger right = 1 + left;
    UIButton * leftButton = self.buttons[left];
    UIButton * rightButton = nil;
    if (right < self.buttons.count) {rightButton = self.buttons[right];}
    //切换左右按钮
    CGFloat scaleR = offset/APPW - left;
    CGFloat scaleL = 1 - scaleR;
    CGFloat tranScale = 1.2 - 1 ;//左右按钮的缩放比例
    //宽和高的缩放(渐变)
    leftButton.transform = CGAffineTransformMakeScale(scaleL * tranScale + 1, scaleL * tranScale + 1);
    rightButton.transform = CGAffineTransformMakeScale(scaleR * tranScale + 1, scaleR * tranScale + 1);
    //颜色的渐变
    UIColor * rightColor = [UIColor colorWithRed:scaleR green:250 blue:250 alpha:1];
    UIColor * leftColor = [UIColor colorWithRed:230 green:230 blue:230 alpha:1];
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
}
@end
