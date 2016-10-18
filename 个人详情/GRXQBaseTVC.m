//
//  GRXQBaseTVC.m
//  个人详情
//
//  Created by 孙磊 on 16/8/18.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "GRXQBaseTVC.h"

@interface GRXQBaseTVC ()

@end

@implementation GRXQBaseTVC

- (void)viewDidLoad
{
    //设置头视图
    [self setUpHeadView];
    //设置导航条
    [self setUpNavigationBar];
}

//设置头视图
- (void)setUpHeadView
{
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    headView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableHeaderView = headView;
    //不允许自动设置额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//设置导航条
- (void)setUpNavigationBar
{
    // 设置导航条背景为透明
    // UIBarMetricsDefault只有设置这种模式,才能设置导航条背景图片
    // 传递一个空的UIImage
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 清空导航条的阴影的线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    //设置字体
    UILabel * label = [[UILabel alloc] init];
    label.text = @"包大人";
    [label sizeToFit];
    label.textColor = [UIColor colorWithWhite:0 alpha:0];
    [self.navigationItem setTitleView:label];
}

@end
