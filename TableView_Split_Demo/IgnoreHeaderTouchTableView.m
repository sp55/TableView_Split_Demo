//
//  IgnoreHeaderTouchTableView.m
//  TableView_Split_Demo
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "IgnoreHeaderTouchTableView.h"

@implementation IgnoreHeaderTouchTableView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //    NSLog(@"header = %@", [self.tableHeaderView class]);
    //    if ([self.tableHeaderView isKindOfClass:[JMCustomHeaderView class]] && CGRectContainsPoint(self.tableHeaderView.frame, point)) {
    //        JMCustomHeaderView * header = (JMCustomHeaderView *)self.tableHeaderView;
    //        if (!header.viewTryOn.isHidden ) {
    //            self.isCanScroll = @"NO";
    //        }else{
    //            self.isCanScroll = @"YES";
    //        }
    //    }else{
    //        self.isCanScroll = @"YES";
    //    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTableViewHeaderScrollState" object:self.isCanScroll];
    return [super pointInside:point withEvent:event];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
