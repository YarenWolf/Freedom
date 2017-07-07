//
//  SettingsViewController.m
//  MyFirstAPP
//
//  Created by 薛超 on 16/6/24.
//  Copyright © 2016年 薛超. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView1;
    NSInteger i;
}

@end
@implementation SettingsViewController
@synthesize contentLength, dismissByBackgroundDrag, dismissByBackgroundTouch, dismissByForegroundDrag;
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = redcolor;
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, 200, kScreenHeight-80)];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView1.backgroundColor = [UIColor clearColor];
    tableView1.tableHeaderView = [self getheadView];
    [self.view addSubview:tableView1];
    ElasticTransition *ET = (ElasticTransition*)self.transitioningDelegate;
    NSLog(@"\ntransition.edge = %@\ntransition.transformType = %@\ntransition.sticky = %@\ntransition.showShadow = %@", [HelperFunctions typeToStringOfEdge:ET.edge], [ET transformTypeToString], ET.sticky ? @"YES" : @"NO", ET.showShadow ? @"YES" : @"NO");
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentLength = kScreenWidth*0.8;
        self.dismissByBackgroundTouch   = YES;
        self.dismissByBackgroundDrag    = YES;
        self.dismissByForegroundDrag    = YES;
    }return self;
}
-(UIView *)getheadView{
    UIScrollView *s = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    s.contentSize = CGSizeMake(1000,1000);
    s.backgroundColor = [UIColor clearColor];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(310, 220, 200, 200)];
    headView.backgroundColor = [UIColor yellowColor];
    [s addSubview:headView];
    return s;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",i++];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
