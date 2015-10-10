//
//  SectionHeaderView.m
//  ExpandTableView
//
//  Created by 赵亮 on 15/8/26.
//  Copyright (c) 2015年 Liang Zhao. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

- (void)awakeFromNib
{
    self.cartButton.selected = NO;
    [self.cartButton setImage:[UIImage imageNamed:@"carat-open"] forState:UIControlStateSelected];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleHeaderView)];
    [self addGestureRecognizer:tapGestureRecognizer];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)toggleHeaderView
{
    if (!self.cartButton.selected) {
        if ([self.delegate respondsToSelector:@selector(openSection:atPosition:)]) {
            [self.delegate openSection:self atPosition:self.section];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(closeSection:atPosition:)]) {
            [self.delegate closeSection:self atPosition:self.section];
        }
    }
}

@end
