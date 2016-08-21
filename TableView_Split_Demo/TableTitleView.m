//
//  TableTitleView.m
//  TableView_Split_Demo
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "TableTitleView.h"
#import "UIView+Ext.h"
#import "Define.h"


@interface TableTitleView ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *titleBtnArray;
@property (nonatomic, strong) UIView  *indicateLine;
@end

@implementation TableTitleView

-(instancetype)initWithTitleArray:(NSArray *)titleArray{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _titleArray = titleArray;
        _titleBtnArray = [NSMutableArray array];
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTabTitleViewHeight);
        CGFloat btnWidth = SCREEN_WIDTH/titleArray.count;
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, kTabTitleViewHeight)];
            [btn setTitle:_titleArray[i][@"title"] forState:UIControlStateNormal];
            [btn setTitleColor:kLiveVideoThemeColor forState:UIControlStateSelected];
            [btn setTitleColor:DefaultBlackColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
            btn.tag =230+ i;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
            
            if (i == 0) {
                btn.selected = YES;
            }
            
            [self addSubview:btn];
            [_titleBtnArray addObject:btn];
        }
        
        UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-1, self.width, 1)];
        bottomLine.backgroundColor = [DefaultGrayColor colorWithAlphaComponent:0.5];
        [self addSubview:bottomLine];
        _indicateLine = [[UIView alloc] initWithFrame:CGRectMake(0, kTabTitleViewHeight-1, btnWidth, 1)];
        _indicateLine.backgroundColor = kLiveVideoThemeColor;
        UIButton *currentShowBtn = [self viewWithTag:230];
        CGFloat width = [[currentShowBtn currentTitle] boundingRectWithSize:CGSizeMake(currentShowBtn.width, 30) options:NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName:kLiveVideoThemeColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]} context:nil].size.width;
        _indicateLine.width = width;
        _indicateLine.centerX = currentShowBtn.center.x;
        [self addSubview:_indicateLine];
        
    }
    return self;
}

-(void)clickBtn : (UIButton *)btn{
    NSInteger tag = btn.tag-230;
    [self setItemSelected:tag];
    
    CGFloat width = [[btn currentTitle] boundingRectWithSize:CGSizeMake(btn.width, 30) options:NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName:kLiveVideoThemeColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]} context:nil].size.width;
    _indicateLine.width = width;
    _indicateLine.centerX = btn.center.x;
    
    if (self.titleClickBlock) {
        self.titleClickBlock(tag);
    }
}

-(void)setItemSelected: (NSInteger)column{
    for (int i=0; i<_titleBtnArray.count; i++) {
        UIButton *btn = _titleBtnArray[i];
        if (i==column) {
            btn.selected = YES;
            
        }else{
            btn.selected = NO;
        }
    }
    CGFloat btnWidth = SCREEN_WIDTH/_titleBtnArray.count;
    _indicateLine.frame = CGRectMake(btnWidth*column, kTabTitleViewHeight-1, btnWidth, 2);
    
}

@end
