//
//  TableCellView.h
//  TableView_Split_Demo
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TableTitleView;
@interface TableCellView : UIView

-(instancetype)initWithTabConfigArray:(NSArray *)tabConfigArray;//tab页配置数组
@property (nonatomic, strong) UIScrollView *tabContentView;
@property (nonatomic, strong) TableTitleView *tabTitleView;

-(void)setItemSelected: (NSInteger)column;

@end
