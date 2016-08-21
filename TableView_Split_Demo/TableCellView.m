//
//  TableCellView.m
//  TableView_Split_Demo
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "TableCellView.h"
#import "TableTitleView.h"//封装的关注和直播的view
#import "Define.h"


@interface TableCellView ()<UIScrollViewDelegate>


@end

@implementation TableCellView

-(instancetype)initWithTabConfigArray:(NSArray *)tabConfigArray{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _tabTitleView = [[TableTitleView alloc] initWithTitleArray:tabConfigArray];
        
        __weak typeof(self) weakSelf = self;
        _tabTitleView.titleClickBlock = ^(NSInteger row){
            NSLog(@"当前点击%zi",row);
            if (weakSelf.tabContentView) {
                weakSelf.tabContentView.contentOffset = CGPointMake(SCREEN_WIDTH*row, 0);
            }
        };
        
        [self addSubview:_tabTitleView];
        
        _tabContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tabTitleView.frame), SCREEN_WIDTH, CGRectGetHeight(self.frame) - CGRectGetHeight(_tabTitleView.frame))];
        _tabContentView.contentSize = CGSizeMake(CGRectGetWidth(_tabContentView.frame)*tabConfigArray.count, CGRectGetHeight(_tabContentView.frame));
        _tabContentView.pagingEnabled = YES;
        _tabContentView.bounces = NO;
        _tabContentView.showsHorizontalScrollIndicator = NO;
        _tabContentView.delegate = self;
        [self addSubview:_tabContentView];
        
        
    }
    return self;
}

- (void)setItemSelected:(NSInteger)column
{
    if (self.tabContentView) {
        self.tabContentView.contentOffset = CGPointMake(SCREEN_WIDTH*column, 0);
        [self.tabTitleView setItemSelected:column];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pageNum = offsetX/SCREEN_WIDTH;
//    NSLog(@"pageNum == %zi",pageNum);
    [_tabTitleView setItemSelected:pageNum];
}

@end
