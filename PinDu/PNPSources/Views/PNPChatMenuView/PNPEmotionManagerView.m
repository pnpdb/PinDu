//
//  PNPEmotionManagerView.m
//  PNP
//
//  Created by lianhai on 14-8-21.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPEmotionManagerView.h"

#import "PNPEmotionSectionBar.h"

#import "PNPEmotionCollectionViewCell.h"
#import "PNPEmotionCollectionViewFlowLayout.h"


@interface PNPEmotionManagerView () <UICollectionViewDelegate, UICollectionViewDataSource, PNPEmotionSectionBarDelegate>

/**
 *  显示表情的collectView控件
 */
@property (nonatomic, weak) UICollectionView *emotionCollectionView;

/**
 *  显示页码的控件
 */
@property (nonatomic, weak) UIPageControl *emotionPageControl;

/**
 *  管理多种类别gif表情的滚动试图
 */
@property (nonatomic, weak) PNPEmotionSectionBar *emotionSectionBar;

/**
 *  当前选择了哪类gif表情标识
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 *  配置默认控件
 */
- (void)setup;

@end

@implementation PNPEmotionManagerView

- (void)reloadData {
    NSInteger numberOfEmotionManagers = [self.dataSource numberOfEmotionManagers];
    if (!numberOfEmotionManagers) {
        return ;
    }
    
    self.emotionSectionBar.emotionManagers = [self.dataSource emotionManagersAtManager];
    [self.emotionSectionBar reloadData];
    
    
    PNPEmotionManager *emotionManager = [self.dataSource emotionManagerForColumn:self.selectedIndex];
    NSInteger numberOfEmotions = emotionManager.emotions.count;
//    self.emotionPageControl.numberOfPages = (numberOfEmotions / (kPNPEmotionPerRowItemCount * 2) + (numberOfEmotions % (kPNPEmotionPerRowItemCount * 2) ? 1 : 0));
    /**
     //UIpageControl的页数
     *  /////////////////////////////////////////
     */
    self.emotionPageControl.numberOfPages = 3;
    
    
    [self.emotionCollectionView reloadData];
}

#pragma mark - Life cycle

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    self.isShowEmotionStoreButton = YES;
    
    
    if (!_emotionCollectionView) {
        UICollectionView *emotionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - kPNPEmotionPageControlHeight - kPNPEmotionSectionBarHeight) collectionViewLayout:[[PNPEmotionCollectionViewFlowLayout alloc] init]];
        emotionCollectionView.backgroundColor = self.backgroundColor;
        [emotionCollectionView registerClass:[PNPEmotionCollectionViewCell class] forCellWithReuseIdentifier:kPNPEmotionCollectionViewCellIdentifier];
        emotionCollectionView.showsHorizontalScrollIndicator = NO;
        emotionCollectionView.showsVerticalScrollIndicator = NO;
        [emotionCollectionView setScrollsToTop:NO];
        emotionCollectionView.pagingEnabled = YES;
        emotionCollectionView.delegate = self;
        emotionCollectionView.dataSource = self;
        [self addSubview:emotionCollectionView];
        self.emotionCollectionView = emotionCollectionView;
    }
    
    if (!_emotionPageControl) {
        UIPageControl *emotionPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emotionCollectionView.frame), CGRectGetWidth(self.bounds), kPNPEmotionPageControlHeight)];
        emotionPageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.471 alpha:1.000];
        emotionPageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.678 alpha:1.000];
        emotionPageControl.backgroundColor = self.backgroundColor;
        emotionPageControl.hidesForSinglePage = YES;
        emotionPageControl.defersCurrentPageDisplay = YES;
        [self addSubview:emotionPageControl];
        self.emotionPageControl = emotionPageControl;
    }
    
    if (!_emotionSectionBar) {
        PNPEmotionSectionBar *emotionSectionBar = [[PNPEmotionSectionBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emotionPageControl.frame), CGRectGetWidth(self.bounds), kPNPEmotionSectionBarHeight) showEmotionStoreButton:self.isShowEmotionStoreButton];
        emotionSectionBar.delegate = self;
        emotionSectionBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        emotionSectionBar.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
        [self addSubview:emotionSectionBar];
        self.emotionSectionBar = emotionSectionBar;
    }
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.emotionPageControl = nil;
    self.emotionSectionBar = nil;
    self.emotionCollectionView.delegate = nil;
    self.emotionCollectionView.dataSource = nil;
    self.emotionCollectionView = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self reloadData];
    }
}

#pragma mark - PNPEmotionSectionBar Delegate

- (void)didSelecteEmotionManager:(PNPEmotionManager *)emotionManager atSection:(NSInteger)section {
    self.selectedIndex = section;
    self.emotionPageControl.currentPage = 0;
    [self reloadData];
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    [self.emotionPageControl setCurrentPage:currentPage];
}

#pragma UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PNPEmotionManager *emotionManager = [self.dataSource emotionManagerForColumn:self.selectedIndex];
    NSInteger count = emotionManager.emotions.count;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PNPEmotionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPNPEmotionCollectionViewCellIdentifier forIndexPath:indexPath];
    
    PNPEmotionManager *emotionManager = [self.dataSource emotionManagerForColumn:self.selectedIndex];
    cell.emotion = emotionManager.emotions[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelecteEmotion:atIndexPath:)]) {
        PNPEmotionManager *emotionManager = [self.dataSource emotionManagerForColumn:indexPath.section];
        [self.delegate didSelecteEmotion:emotionManager.emotions[indexPath.row] atIndexPath:indexPath];
    }
}

@end
