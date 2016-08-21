//
//  Define.h
//  TableView_Split_Demo
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#ifndef Define_h
#define Define_h


static NSString *const kGoTopNotificationName = @"goTop";//进入置顶命令
static NSString *const kLeaveTopNotificationName = @"leaveTop";//离开置顶命令
static CGFloat const kTopBarHeight = 65;
static CGFloat const kBottomBarHeight = 55;
static CGFloat const kTabTitleViewHeight = 50;

//获取屏幕的宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/** RGB颜色*/
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** 16进制颜色转换*/
#define UIColorWithHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1]

/** APP主色  绿色*/
#define DefaultGreenColor UIColorWithHex(0x8ec31e)

/** 字体的灰色*/
#define DefaultGrayColor  UIColorWithHex(0x888888)

/** 字体的黑色*/
#define DefaultBlackColor  UIColorWithHex(0x333333)

/** 提示Badge的背景颜色*/
#define DefaultBadgeColor  RGBColor(255,59,48)

//RGB 251 173 42
#define kLiveVideoThemeColor RGBColor(251,173,42)



#endif /* Define_h */
