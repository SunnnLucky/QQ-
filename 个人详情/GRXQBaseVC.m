//
//  GRXQBaseVC.m
//  个人详情
//
//  Created by 孙磊 on 16/8/18.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "GRXQBaseVC.h"
#import "UIImage+Image.h"
#define GRXQHeadH 200 //头视图高度
#define GRXQTabBarH 44 //选项卡高度
#define GRXQStatus 0 //状态栏高度
#define GRXQMiniH 64 //头视图最小高度

@interface GRXQBaseVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UIImageView* icon;
@property (weak, nonatomic) IBOutlet UIImageView* bgIcon;
@property (nonatomic, assign) CGFloat offsetY; //最开始偏移量
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* layoutHeadViewY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* layoutHeadViewH;
@property (nonatomic, strong) UILabel* label;

@end

@implementation GRXQBaseVC

- (UILabel*)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"包大人";
        [_label sizeToFit];
        _label.textColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return _label;
}

- (void)viewDidLoad
{
    [self setUpTableView];
    [self setUpNavigationBar];
    [self setUpHeadView];
    [self setUpIcon];
}

- (void)setUpIcon
{
    //设置圆角
    self.icon.layer.cornerRadius = 50;
    //设置裁剪
    self.icon.layer.masksToBounds = YES;
    self.icon.image = [UIImage imageNamed:@"1.pic"];
    self.bgIcon.image = [UIImage imageNamed:@"bug"];
}
- (void)setUpTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //先计算偏移量
    _offsetY = -(GRXQHeadH + GRXQTabBarH + GRXQStatus);
    //初始滚动位置,设置时会调用scrollViewDidScroll,所以要先计算偏移量
    self.tableView.contentInset = UIEdgeInsetsMake(GRXQHeadH + GRXQTabBarH + GRXQStatus, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = false;
}

//设置头视图
- (void)setUpHeadView
{
    //    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    //    headView.backgroundColor = [UIColor yellowColor];
    //    self.tableView.tableHeaderView = headView;
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
    NSLog(@"%@", self.label.text);
    [self.navigationItem setTitleView:self.label];
}

//- (BOOL)prefersStatusBarHidden
//{
//    return true;
//}

#pragma mark----- Delegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    //    NSLog(@"%lf",scrollView.contentOffset.y);
    //获取当前滚动偏移量 - 最开始偏移量(264)
    CGFloat y = scrollView.contentOffset.y - _offsetY;
    CGFloat h = GRXQHeadH - y;
    if (h < GRXQMiniH) {
        h = GRXQMiniH;
    }
    //改变自动布局的Y
    self.layoutHeadViewH.constant = h;
    //计算透明度
    CGFloat alpha = y / (GRXQHeadH - GRXQMiniH);
    if (alpha > 1 || alpha == 1) {
        //可能临界值会有透明度的问题,改成0.99
        alpha = 0.99;
    }
    else if (alpha < 0) {
        alpha = 0;
    }
    //设置navigationBar透明度
    // self.navigationController.navigationBar.alpha = alpha;
    UIImage* image = [UIImage imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.label.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    NSLog(@"偏移量%lf,透明度%lf", y, alpha);
}

#pragma mark----- UITableViewDataSource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* IDstr = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:IDstr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDstr];
        cell.backgroundColor = [UIColor yellowColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
    return cell;
}
@end
