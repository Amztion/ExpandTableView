//
//  SectionHeaderView.h
//  ExpandTableView
//
//  Created by 赵亮 on 15/8/26.
//  Copyright (c) 2015年 Liang Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionHeaderViewDelegate;

@interface SectionHeaderView : UITableViewHeaderFooterView


@property (weak, nonatomic) IBOutlet UIButton *cartButton;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;
@property (strong,nonatomic) id<SectionHeaderViewDelegate> delegate;
@property (assign, nonatomic) NSInteger section;

- (void)toggleHeaderView;

@end

@protocol SectionHeaderViewDelegate <NSObject>

@optional
- (void)openSection: (SectionHeaderView*)sectionHeaderView atPosition: (NSInteger)position;
- (void)closeSection: (SectionHeaderView*)sectionHeaderView atPosition: (NSInteger)position;

@end


