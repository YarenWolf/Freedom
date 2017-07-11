//
//  MyDatabaseTabBarController.m
//  MyFirstAPP
//
//  Created by 薛超 on 16/8/19.
//  Copyright © 2016年 薛超. All rights reserved.
//

#import "MyDatabaseTabBarController.h"

@implementation MyDatabaseTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    //通过设置文本属性来设置字体颜色
    for(UIViewController *s in self.childViewControllers){
        NSMutableDictionary *attM = [NSMutableDictionary dictionary];
        [attM setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
        [s.tabBarItem setTitleTextAttributes:attM forState:UIControlStateSelected];
        s.tabBarItem.image = [s.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        s.tabBarItem.selectedImage = [s.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}
@end
