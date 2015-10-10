//
//  TableViewController.m
//  ExpandTableView
//
//  Created by 赵亮 on 15/8/26.
//  Copyright (c) 2015年 Liang Zhao. All rights reserved.
//

#import "TableViewController.h"

static NSString *SectionHeaderViewIdentifier = @"SectionHeaderViewIdentifier";

@interface TableViewController ()

@property (strong, nonatomic) SectionHeaderView *openedSectionView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"first", @"second", @"third", @"forth"];
    
    UINib *sectionHeaderViewNib = [UINib nibWithNibName:@"SectionHeaderView" bundle:nil];
    [self.tableView registerNib:sectionHeaderViewNib forHeaderFooterViewReuseIdentifier:SectionHeaderViewIdentifier];
    
    self.openedSectionView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionHeaderView *sectionHeaderView = (SectionHeaderView*)[self.tableView headerViewForSection:section];
    
    return sectionHeaderView.cartButton.selected?self.dataArray.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionHeaderView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];
    
    headerView.section = section;
    
    headerView.delegate = self;
    
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}


#pragma mark - SectionHeaderView Delegate
- (void)openSection:(SectionHeaderView *)sectionHeaderView atPosition:(NSInteger)position
{
    sectionHeaderView.cartButton.selected = YES;
    
    NSMutableArray *indexPathsToInsert = [NSMutableArray array];
    NSMutableArray *indexPathsToDelete = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:position]];
    }

    if (self.openedSectionView != nil) {
        self.openedSectionView.cartButton.selected = NO;
        NSInteger deleteRowCount = [self.tableView numberOfRowsInSection:self.openedSectionView.section];
        for (int i = 0; i < deleteRowCount; ++i) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:self.openedSectionView.section]];
        }
    }
    
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    

    if (self.openedSectionView == nil || position < self.openedSectionView.section) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    
    self.openedSectionView = sectionHeaderView;
    
    NSLog(@"open");
}

- (void)closeSection:(SectionHeaderView *)sectionHeaderView atPosition:(NSInteger)position
{
    sectionHeaderView.cartButton.selected = NO;
    
    NSInteger numberOfRowsToDelete = [self.tableView numberOfRowsInSection:position];
    
    NSMutableArray *indexPathsToDelete = [NSMutableArray array];
    for (int i = 0; i < numberOfRowsToDelete; ++i) {
        [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:position]];
    }
    
    UITableViewRowAnimation deleteAnimation = UITableViewRowAnimationTop;
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    self.openedSectionView = nil;
    NSLog(@"close");
}

@end
