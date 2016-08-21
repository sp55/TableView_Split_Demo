//
//  ViewController.m
//  TableView_Split_Demo
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "ViewController.h"
#import "Define.h"
#import "IgnoreHeaderTouchTableView.h"
#import "TableCellView.h"
#import "TestTableViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;//在顶部不可以移动
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;//
@property (nonatomic, assign) BOOL canScroll;//是否可以滚动

@property (nonatomic, strong) IgnoreHeaderTouchTableView *tableView;//自定制TableView 里面加了一个isCanScroll的方法
@property (nonatomic, strong) TableCellView *tableCellView;//中间的关注和热门直播view

@property (nonatomic, strong) UIView *headerView;//tableView的headView

@property (nonatomic, strong) NSMutableArray *tmpControllers;//关注和热门直播的控制器的数组
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //离开置顶
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];
    //改变scrollview的滚动状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mytest:) name:@"changeTableViewHeaderScrollState" object:nil];
    [self setTableView];
    [self setSearchBar];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Method
- (void)setTableView {
    //最底下的那层容器
    _tableView = [[IgnoreHeaderTouchTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = self.headerView;
    [self.view addSubview:_tableView];
}
//搜索框
- (void)setSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    searchBar.placeholder = @"搜索用户";
    searchBar.delegate = self;
    searchBar.barTintColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = searchBar;
}

#pragma mark -- 控制界面悬停
- (void)acceptMsg:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

- (void)mytest:(NSNotification *)notification {
    NSString *userInfo = notification.object;
    
    if ([userInfo isEqualToString:@"NO"]) {
        self.tableView.scrollEnabled = NO;
    } else if ([userInfo isEqualToString:@"YES"]){
        self.tableView.scrollEnabled = YES;
    }
}
//头视图
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}

#pragma mark - Getter && Setter

- (TableCellView *)tableCellView {
    if (!_tableCellView) {
        NSArray *tabConfigArray = @[@{
                                        @"btnIMG":@"tab_brief",
                                        @"btnIMG_ON":@"tab_brief_on",
                                        @"title":@"关注",
                                        @"position":@0
                                        },@{
                                        @"btnIMG":@"tab_detail",
                                        @"btnIMG_ON":@"tab_detail_on",
                                        @"title":@"热门直播",
                                        @"position":@1
                                        }];
        
        _tableCellView = [[TableCellView alloc] initWithTabConfigArray:tabConfigArray];
        for (int i = 0; i < tabConfigArray.count; i++) {
            TestTableViewController *vc = self.tmpControllers[i];
            //viewController的呈现高度 应该是 tableCellView的高度 - 中间标题栏的高度
            vc.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 64);
            [self addChildViewController:vc];
            [_tableCellView.tabContentView addSubview:vc.view];
        }
    }
    return _tableCellView;
}
//三个控制器
- (NSMutableArray *)tmpControllers {
    if (!_tmpControllers) {
        _tmpControllers = @[].mutableCopy;
        for (int i = 0; i < 2; i++) {
            TestTableViewController *vc = [[TestTableViewController alloc] initWithStyle:UITableViewStylePlain];
            [_tmpControllers addObject:vc];
        }
    }
    return _tmpControllers;
}

#pragma mark - UITableView DataSource && UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CGFloat height = 0;
        height = CGRectGetHeight(self.view.frame);
        return height;
    }
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifer = @"test123";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifer];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {//第0行上
        [cell.contentView addSubview:self.tableCellView];
    }
    return cell;
}


//没发现有什么用处
//- (void)tableTitleDidChangedValue:(NSInteger)num
//{
//    [self.tableCellView setItemSelected:num];
//}

#pragma mark - UIScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat tabOffsetY = [_tableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"tabOffsetY===%f",tabOffsetY);//200
//    NSLog(@"offsetY===%f",offsetY);//0~200  偏移量

    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
   //刚开始都是NO 0 0
//    NSLog(@"----%d=====%d",_isTopIsCanNotMoveTabView,_isTopIsCanNotMoveTabViewPre);
    if (offsetY>=tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"搜索框 开始编辑 push下一个界面");
    return NO;
}
@end
