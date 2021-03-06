////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  CALMonthCell.m
//  iOS Tester
//
//  Created by Austin Cherry on 3/24/14.
//  Copyright (c) 2014 Basement Krew. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

#import "CALMonthCell.h"
#import "CALMonth.h"
#import "CALDayCell.h"

@interface CALMonthCell()

@property(nonatomic, strong)CALMonth *month;
@property(nonatomic, strong)NSDateFormatter *dateFormat;

@end

#define CELL_ID @"DAY_CELL"

@implementation CALMonthCell

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat pad = 2;
        layout.itemSize = CGSizeMake(10, 10);
        layout.minimumInteritemSpacing = pad;
        layout.minimumLineSpacing = pad*2;
        self.monthView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.monthView.delegate = self;
        self.monthView.dataSource = self;
        [self.monthView registerClass:[CALDayCell class] forCellWithReuseIdentifier:CELL_ID];
        self.monthView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.monthView];
        
        self.monthLabel = [UILabel new];
        self.monthLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.monthLabel];
        
        self.dateFormat = [[NSDateFormatter alloc] init];
        [self.dateFormat setDateFormat:@"MMM"];
    }
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object
{
    self.month = (CALMonth*)object;
    
    self.monthLabel.text = [NSString stringWithFormat:@"%@", [self.dateFormat stringFromDate:self.month.date]];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float pad = 5;
    float height = 21;
    float width = self.contentView.bounds.size.width;
    
    self.monthLabel.frame = CGRectMake(0, pad, width, height);
    height += pad;
    self.monthView.frame = CGRectMake(0, height, width, self.contentView.bounds.size.height-(height));
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CALDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    [cell setObject:@(indexPath.row)];
    return cell;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.month.daysInMonth.length;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////////////////////

@end
