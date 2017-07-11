
#import "BaseViewController.h"
#import "Reachability.h"
#include <objc/runtime.h>
static BaseViewController *BVC = nil;
@interface BaseViewController ()
@property (nonatomic,strong) UILabel *sizeLabel;
@property (nonatomic,strong) UITextView *sizeTextView;
@end
@implementation BaseViewController
+ (BaseViewController *) sharedViewController{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        BVC = [[BaseViewController alloc] initWithNavStyle:1];
    });
    return BVC;
}
- (id)initWithNavStyle:(NSInteger)style{
    self = [super init];
    if (self) {
        
    }return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[Utility Share]setCurrentViewController:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)name:kReachabilityChangedNotification object:nil];
    if (Version7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    if (Version7) {
        self.automaticallyAdjustsScrollViewInsets=NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController.navigationBar setFrame:CGRectMake(0, 0,APPW, TopHeight)];
        [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back"]];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"返回";
        self.navigationItem.backBarButtonItem = backItem;
        [self.navigationController.view setBackgroundColor:whitecolor];
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor whiteColor],[UIFont boldSystemFontOfSize:18.0f], nil] forKeys:[NSArray arrayWithObjects: NSForegroundColorAttributeName,NSFontAttributeName, nil]];
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    [self.view setClipsToBounds:YES];
    [self.view setBackgroundColor:whitecolor];
    [self.navigationController.navigationBar setBarTintColor:gradcolor];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (Version7) {
        CGFloat topBarOffset = [[self performSelector:@selector(topLayoutGuide)] length];
        DLog(@"viewDidLayoutSubviews_topBarOffset:%f",topBarOffset);
    }
    self.automaticallyAdjustsScrollViewInsets=NO;
}
- (UIBarButtonItem*)leftBarButtonItemWithTitle:(NSString*)title Image:(UIImage *)image customView:(UIView*)view style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)sel{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]init];
    leftItem.style = style;
    if(image){
        leftItem.image = image;
    }else if(title){
        leftItem.title = title;
    }else if(view){
        leftItem.customView = view;
    }
    leftItem.target = target;
    leftItem.action = sel;
    self.navigationItem.leftBarButtonItem = leftItem;
    return leftItem;
}
- (UIBarButtonItem*)rightBarButtonItemWithTitle:(NSString*)title Image:(UIImage *)image customView:(UIView*)view style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)sel{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]init];
    rightItem.style = style;
    if(image){
        rightItem.image = image;
    }else if(title){
        rightItem.title = title;
    }else if(view){
        rightItem.customView = view;
    }
    rightItem.target = target;
    rightItem.action = sel;
    self.navigationItem.rightBarButtonItem = rightItem;
    return rightItem;
}

- (void)setTitle:(NSString *)title titleView:(UIView *)titleV backGroundColor:(UIColor *)color backGroundImage:(NSString *)image{
    if(titleV){
        self.navigationItem.titleView = titleV;
    }else{
        self.navigationItem.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPW-140, 44)];
    }
    if (title.length) {
        CAGradientLayer* gradientMask = [CAGradientLayer layer];
        gradientMask.bounds = self.navigationItem.titleView.layer.bounds;
        gradientMask.position = CGPointMake([self.navigationItem.titleView bounds].size.width / 2, [self.navigationItem.titleView bounds].size.height / 2);
        NSObject *transparent = (NSObject*) [[UIColor clearColor] CGColor];
        NSObject *opaque = (NSObject*) [[UIColor blackColor] CGColor];
        gradientMask.startPoint = CGPointMake(0.0, CGRectGetMidY(self.navigationItem.titleView.frame));
        gradientMask.endPoint = CGPointMake(1.0, CGRectGetMidY(self.navigationItem.titleView.frame));
        float fadePoint = (float)10/self.navigationItem.titleView.frame.size.width;
        [gradientMask setColors: [NSArray arrayWithObjects: transparent, opaque, opaque, transparent, nil]];
        [gradientMask setLocations:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:fadePoint],[NSNumber numberWithFloat:1-fadePoint],[NSNumber numberWithFloat:1.0],nil]];
        self.navigationItem.titleView.layer.mask = gradientMask;

        UILabel *label = [[UILabel alloc] initWithFrame:self.navigationItem.titleView.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = BoldFont(18);
        label.textColor  = [UIColor blackColor];
        label.shadowOffset = CGSizeMake(0, 0);
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [self.navigationItem.titleView addSubview:label];
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
        if (label.frame.size.width<size.width) {
            label.frameWidth=size.width;
            [self performSelector:@selector(startScrollAnimateWithLabel:) withObject:label afterDelay:3.0];
        }
    }
    if(image.length){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:image] forBarMetrics:UIBarMetricsDefault];
    }
    if(color){
         [self.navigationController.navigationBar setBackgroundImage:[[Utility Share]imageFromColor:color size:CGSizeMake(APPW, 64)] forBarMetrics:UIBarMetricsDefault];
//        self.navigationController.navigationBar.backgroundColor = color;
    }
}

-(void)startScrollAnimateWithLabel:(UILabel*)label{
    CGRect frame=label.frame;
    UIView *nBGv=self.navigationItem.titleView;
    [UIView animateWithDuration:5.4 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        label.frameX = -frame.size.width;
    } completion:^(BOOL finished) {
        [self EntertainingDiversionsAnimation:10.8 aView:label supView:nBGv];
    }];
}
-(void)EntertainingDiversionsAnimation:(NSTimeInterval)interval aView:(UIView *)av supView:(UIView *)sv{
    CGRect frame =av.frame;
    av.frame=CGRectMake(W(av), frame.origin.y, frame.size.width, frame.size.height);
    [UIView animateWithDuration:interval delay:0.0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear animations:^{
         av.frame = frame;
     }completion:^(BOOL finished) {
     }];
}
#pragma mark - Methods
- (BaseViewController*)pushController:(Class)controller withInfo:(id)info{
    return [self pushController:controller withInfo:info withTitle:nil withOther:nil tabBarHidden:YES];
}
- (BaseViewController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title{
    return [self pushController:controller withInfo:info withTitle:title withOther:nil tabBarHidden:YES];
}
- (BaseViewController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other{
   return [self pushController:controller withInfo:info withTitle:title withOther:other tabBarHidden:YES];
}
- (BaseViewController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other tabBarHidden:(BOOL)abool{
    DLog(@"\n跳转到 %@ 类",NSStringFromClass(controller));
    return [self pushController:[[controller alloc]init] withInfo:info withTitle:title withOther:other tabBarHid:abool];
}
- (BaseViewController*)pushController:(BaseViewController*)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other tabBarHid:(BOOL)abool{
    DLog(@"\n跳转到 %@ 页面",title);
    DLog(@"\nBase UserInfo:%@",info);
    DLog(@"\nBase OtherInfo:%@",other);
    if ([(NSObject*)controller respondsToSelector:@selector(setUserInfo:)]) {
        controller.userInfo = info;
        controller.otherInfo = other;
    }
    controller.title = title;
    controller.hidesBottomBarWhenPushed=abool;
    [self.navigationController pushViewController:controller animated:YES];
    return controller;
}
- (void)popToControllerNamed:(NSString*)controller{
    Class cls = NSClassFromString(controller);
    if ([cls isSubclassOfClass:[UIViewController class]]) {
        [self.navigationController popToViewController:(UIViewController*)cls animated:YES];
    }else{
        DLog(@"popToController NOT FOUND.");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)popToTheControllerNamed:(id)controller{
    if ([controller isKindOfClass:[UIViewController class]]) {
        [self.navigationController popToViewController:controller animated:YES];
    }else{
        DLog(@"popToController NOT FOUND.");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)popToControllerNamed:(NSString*)controllerstr withSel:(SEL)sel withObj:(id)info{
    DLog(@"\n返回到 %@ 页面",controllerstr);
    if ([info isKindOfClass:[NSDictionary class]]) {
        DLog(@"\nBase UserInfo:%@",info);
    }
    for (id controller in self.navigationController.viewControllers) {
        if ([NSStringFromClass([controller class]) isEqualToString:controllerstr]) {
            if ([(NSObject*)controller respondsToSelector:sel]) {
                [controller performSelector:sel withObject:info afterDelay:0.01];
            }
            [self popToTheControllerNamed:controller];
            break;
        }
    }
}
/**
 *	根据文字计算Label高度
 *	@param	_width	限制宽度
 *	@param	_font	字体
 *	@param	_text	文字内容
 *	@param	_aLine	文字内容换行行间距
 *	@return	Label高度
 */
- (CGFloat)heightForLabel:(CGFloat)_width font:(UIFont*)_font text:(NSString*)_text lineSpace:(CGFloat)_aLine{
    if (!self.sizeLabel) {
        self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    }
    self.sizeLabel.numberOfLines = 0;
    self.sizeLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    [self.sizeLabel setLineBreakMode:NSLineBreakByTruncatingTail|NSLineBreakByWordWrapping];
    self.sizeLabel.font = _font;
    if (_text) {
        self.sizeLabel.text = _text;
        if (_aLine) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_text];
            NSMutableParagraphStyle *paragraphStyleT = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyleT setLineSpacing:_aLine];//调整行间距
            paragraphStyleT.lineBreakMode = NSLineBreakByWordWrapping;
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(0, [_text length])];
            self.sizeLabel.attributedText = attributedString;
        }
        return [self.sizeLabel sizeThatFits:CGSizeMake(_width, MAXFLOAT)].height;
    }else{
        return 0;
    }
}
- (CGFloat)heightForTextView:(CGFloat)_width font:(UIFont*)_font text:(NSString*)_text lineSpace:(CGFloat)_aLine{
    if (!self.sizeTextView) {
        self.sizeTextView = [[UITextView alloc] init];
    }
    [self.sizeTextView setEditable:NO];
    self.sizeTextView.frame=CGRectMake(0,0, _width, 20);
    self.sizeTextView.font = _font;
    if (_text) {
        self.sizeTextView.text = _text;
        if (_aLine) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineSpacing = _aLine;
            NSDictionary *attributes = @{ NSFontAttributeName:_font, NSParagraphStyleAttributeName:paragraphStyle};
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            self.sizeTextView.attributedText =[[NSAttributedString alloc]initWithString:_text attributes:attributes];
             if (Version7) {
                CGSize size = [_text boundingRectWithSize:CGSizeMake(_width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
                DLog(@"TextView的高度:%f",size.height);
                return  size.height;
            }else{
                return self.sizeTextView.contentSize.height-16;
            }
        }
        return [self.sizeTextView sizeThatFits:CGSizeMake(_width, MAXFLOAT)].height;
    }else{
        return 0;
    }
}
#pragma mark - Actions
- (void)backToHomeViewController{
    NSArray *controllers = [(UITabBarController*)[(UIWindow*)[[UIApplication sharedApplication] windows][0] rootViewController] viewControllers];//首页的controllers
    if([controllers[0] navigationController]){
        [[controllers[0] navigationController]popToRootViewControllerAnimated:YES];//回到首页
    }else{
        [controllers[0] dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)goback{
    [SVProgressHUD dismiss];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark UItableViewDelegagte
- (void)fillTheTableDataWithHeadV:(UIView*)head footV:(UIView*)foot canMove:(BOOL)move canEdit:(BOOL)edit headH:(CGFloat)headH footH:(CGFloat)footH rowH:(CGFloat)rowH sectionN:(NSInteger)sectionN rowN:(NSInteger)rowN cellName:(NSString *)cell{
    self.tableView.tableHeaderView = head;
    self.tableView.tableFooterView = foot;
    self.tableView.canMoveRow = move;
    self.tableView.canEditRow = edit;
    self.tableView.headH = headH;
    self.tableView.footH = footH;
    self.tableView.rowH = rowH;
    self.tableView.sectionN = sectionN;
    self.tableView.rowN = rowN;
    self.tableView.cell = [NSClassFromString(cell) getInstance];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.rowH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.tableView.headH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.tableView.footH;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableView.sectionN;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableView.rowN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.tableView.cell){
        self.tableView.cell = [BaseTableViewCell getInstance];
    }
    [self.tableView.cell  setDataWithDict:self.tableView.dataArray[indexPath.row]];
    return self.tableView.cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.tableView.tableHeaderView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.tableView.tableFooterView;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.canEditRow;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.canMoveRow;
}

#pragma mark  子类重写
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"请子类重写这个方法");
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    DLog(@"请子类重写这个方法");return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    DLog(@"请子类重写这个方法");return nil;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self.tableView.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    // 2 添加一个置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
        [self.tableView.dataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    }];
    topRowAction.backgroundColor = gradcolor;
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction,topRowAction];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return UITableViewCellEditingStyleDelete;
    //return UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleNone;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView.dataArray removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        [self.tableView.dataArray addObject:self.tableView.dataArray[indexPath.row]];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    DLog(@"请子类重写这个方法");
    [self.tableView.dataArray removeObjectAtIndex:sourceIndexPath.row];
    [self.tableView.dataArray insertObject:self.tableView.dataArray[sourceIndexPath.row] atIndex:destinationIndexPath.row];
}
#pragma mark UICollectionViewDelegate
-(void)fillTheCollectionViewDataWithCanMove:(BOOL)move sectionN:(NSInteger)sectionN itemN:(NSInteger)itemN itemName:(NSString *)item{
    self.collectionView.canMoveRow = move;
    self.collectionView.sectionN = sectionN;
    self.collectionView.itemN = itemN;
    [self.collectionView registerClass:NSClassFromString(item) forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@Identifier",item]];
    self.collectionReuseId = [NSString stringWithFormat:@"%@Identifier",item];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.collectionView.sectionN;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionView.itemN;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    self.collectionView.cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.collectionReuseId forIndexPath:indexPath];
    [self.collectionView.cell  setCollectionDataWithDic:self.collectionView.dataArray[indexPath.row]];
    return self.collectionView.cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.collectionView.canMoveRow;
}

//子类重写
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      DLog(@"请子类重写这个方法");
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
      DLog(@"请子类重写这个方法");
}
#pragma mark -Notify
-(void) reachabilityChanged:(NSNotification*) notification{
    if ([(Reachability*)[notification object] currentReachabilityStatus] == ReachableViaWiFi) {
        NSLog(@"网络状态改变了.");
    }
}
#pragma mark others
- (void)addFloatView{
    
}
- (void)readData {
    AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TotalData"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:NO],
                                [NSSortDescriptor sortDescriptorWithKey:@"icon" ascending:NO]];
    NSError *error = nil;
    NSArray *a = [del.managedObjectContext executeFetchRequest:request error:&error];
    DLog(@"%@", error);
    if (!a || ([a isKindOfClass:[NSArray class]] && [a count] <= 0)) {
        // 添加数据到数据库
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *strPath = [[NSBundle mainBundle] pathForResource:@"icons" ofType:@"txt"];
            NSString *text = [NSString stringWithContentsOfFile:strPath encoding:NSUTF16StringEncoding error:nil];
            NSArray *lineArr = [text componentsSeparatedByString:@"\n"];
            AppDelegate *del = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            NSEntityDescription *description = [NSEntityDescription entityForName:@"TotalData" inManagedObjectContext:del.managedObjectContext];
            for (NSString *line in lineArr) {
                NSArray *icons = [line componentsSeparatedByString:@"\t"];
                /*items[0],items[1], items[2], items[3], items[4], items[5]*/
                TotalData *icon = [[TotalData alloc] initWithEntity:description insertIntoManagedObjectContext:self.managedObjectContext];
                icon.title = icons[0];
                icon.icon = icons[1];
                DLog(@"%@===%@",icons,icons[2]);
                icon.control = icons[2];
            }
            [del saveContext];
            //从数据库中读
            NSError *error = nil;
            NSArray *b = [del.managedObjectContext executeFetchRequest:request error:&error];
            if (error) {
                DLog(@"%@", error);
            } else {
                self.items = [NSArray arrayWithArray:b];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    [collectionView reloadData];
                });
            }
        });
    } else {
        self.items = [NSArray arrayWithArray:a];
        //        [collectionView reloadData];
    }
    //     删除所有数据
    //                for (TotalData *postcode in a) {
    //                    [del.managedObjectContext deleteObject:postcode];
    //                }
    //                [del saveContext];
}

-(void)radialMenu:(CKRadialMenu *)radialMenu didSelectPopoutWithIndentifier:(NSString *)identifier{
    DLog(@"代理通知发现点击了控制器%@", identifier);
    int a = [identifier intValue];
    [radialMenu didTapCenterView:nil];
    DLog(@"%@",self.items);
    NSString *s =[NSString stringWithFormat:@"%@ViewController",[self.items[a] valueForKey:@"control"]];
    UIViewController *con = [[NSClassFromString(s) alloc]init];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cube";
    //    animation.type = kCATransitionReveal;
    //    animation.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self presentViewController:con animated:NO completion:^{}];
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    win.rootViewController = con;
    [win makeKeyAndVisible];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[self.items[a] valueForKey:@"title"]]];
    
    //    常见变换类型（type）
    //    kCATransitionFade//淡出
    //    kCATransitionMoveIn//覆盖原图
    //    kCATransitionPush  //推出
    //    kCATransitionReveal//底部显出来
    //SubType:
    //    kCATransitionFromRight
    //    kCATransitionFromLeft// 默认值
    //    kCATransitionFromTop
    //    kCATransitionFromBottom
    //(type):
    //    pageCurl   向上翻一页
    //    pageUnCurl 向下翻一页
    //    rippleEffect 滴水效果
    //    suckEffect 收缩效果
    //    cube 立方体效果
    //    oglFlip 上下翻转效果
}
-(void)showStoryboardWithStoryboardName:(NSString*)story andViewIdentifier:(NSString*)identifier{
    UIStoryboard *StoryBoard = [UIStoryboard storyboardWithName:story bundle:nil];
    [self showViewController:[StoryBoard instantiateViewControllerWithIdentifier:identifier] sender:self];
}
-(void)presentStoryboardWithStoryboardName:(NSString*)story andViewIdentifier:(NSString*)identifier{
    UIStoryboard *StoryBoard = [UIStoryboard storyboardWithName:story bundle:nil];
    UIViewController *dvc = [StoryBoard instantiateViewControllerWithIdentifier:identifier];
    dvc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:dvc animated:YES completion:NULL];
}
-(void)showRadialMenu{
    if(!self.radialView){
        [self readData];
        self.radialView = [[CKRadialMenu alloc] initWithFrame:CGRectMake(kScreenWidth/2-25, kScreenHeight/2-25, 50, 50)];
        for(int i = 0;i<self.items.count;i++){
            UIImageView *a = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
            a.image = [UIImage imageNamed:[self.items[i] valueForKey:@"icon"]];
            [self.radialView addPopoutView:a withIndentifier:[NSString stringWithFormat:@"%d",i]];
        }
        [self.radialView enableDevelopmentMode];
        self.radialView.distanceBetweenPopouts = 2*180/self.items.count;
        self.radialView.delegate = self;
        [self.view addSubview:self.radialView];
        self.radialView.center = self.view.center;
        UIWindow *win = [[UIApplication sharedApplication]keyWindow];
        [win addSubview:self.radialView];
        [win bringSubviewToFront:self.radialView];
    }else{
        [self.radialView removeFromSuperview];
        self.radialView = nil;
    }
   
}
#pragma mark 摇一摇
/** 开始摇一摇 */
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self showRadialMenu];
}
/** 摇一摇结束 */
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion != UIEventSubtypeMotionShake)return;
    DLog(@"结束摇一摇");
}
/** 摇一摇取消(被中断 比如突然来了电话 )*/
- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    DLog(@"取消摇一摇");
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
