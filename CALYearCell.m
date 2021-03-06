////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALYearCell.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/20/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALYearCell.h"
#import "CALMonthCell.h"
#import "CALMonth.h"

@interface CALYearCell()

@property(nonatomic, strong)NSArray *items;

@end

#define CELL_ID @"MONTH_CELL"

@implementation CALYearCell

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(90, 100);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 2;
        self.monthView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.monthView.delegate = self;
        self.monthView.dataSource = self;
        [self.monthView registerClass:[CALMonthCell class] forCellWithReuseIdentifier:CELL_ID];
        self.monthView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.monthView];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object
{
    self.items = (NSArray*)object;
    //setup calmonth view with object data.
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat pad = 10;
    self.monthView.frame = CGRectMake(pad, 0, self.contentView.bounds.size.width-(pad*2), self.contentView.bounds.size.height); //self.contentView.bounds;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    CALMonth *month = self.items[indexPath.row];
    [cell setObject:month];
    return cell;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@end
