//
//  TLGroupViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupViewController.h"
#import "TLSearchController.h"

#import "TLChatViewController.h"
#import "TLRootViewController.h"
#import "TLGroupCell.h"
#import "UINavigationController+JZExtension.h"
@interface TLGroupViewController () <UISearchBarDelegate>

@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"群聊"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    [self registerCellClass];
    
    self.data = [TLFriendHelper sharedFriendHelper].groupsData;
}

#pragma mark - Getter -
- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[TLSearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController setSearchResultsUpdater:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setDelegate:self];
    }
    return _searchController;
}

- (TLGroupSearchViewController *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLGroupSearchViewController alloc] init];
    }
    return _searchVC;
}

#pragma mark - Public Methods -
- (void)registerCellClass
{
    [self.tableView registerClass:[TLGroupCell class] forCellReuseIdentifier:@"TLGroupCell"];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLGroup *group = self.data[indexPath.row];
    TLGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLGroupCell"];
    [cell setGroup:group];
    [cell setBottomLineStyle:(indexPath.row == self.data.count - 1 ? TLCellLineStyleFill : TLCellLineStyleDefault)];
    return cell;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLGroup *group = [self.data objectAtIndex:indexPath.row];
    TLChatViewController *chatVC = [TLChatViewController sharedChatVC];
    [chatVC setPartner:group];
    UIViewController *vc = [[TLRootViewController sharedRootViewController] childViewControllerAtIndex:0];
    [[TLRootViewController sharedRootViewController] setSelectedIndex:0];
    [vc setHidesBottomBarWhenPushed:YES];
    [vc.navigationController pushViewController:chatVC animated:YES completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:NO];
    }];
    [vc setHidesBottomBarWhenPushed:NO];
}

//MARK: UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchVC setGroupData:self.data];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
