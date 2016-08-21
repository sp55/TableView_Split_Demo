//
//  TableTitleView.h
//  TableView_Split_Demo
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableTitleView : UIView


-(instancetype)initWithTitleArray:(NSArray *)titleArray;

-(void)setItemSelected: (NSInteger)column;

/**
 *  定义点击的block
 *
 *  @param NSInteger 点击column数
 */
typedef void (^YXTabTitleClickBlock)(NSInteger);

@property (nonatomic, copy) YXTabTitleClickBlock titleClickBlock;



@end
