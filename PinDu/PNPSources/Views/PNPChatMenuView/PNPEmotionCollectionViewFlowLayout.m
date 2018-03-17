//
//  PNPEmotionCollectionViewFlowLayout.m
//  PNP
//
//  Created by lianhai on 14-8-21.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPEmotionCollectionViewFlowLayout.h"

@implementation PNPEmotionCollectionViewFlowLayout

- (id)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(kPNPEmotionImageViewSize, kPNPEmotionImageViewSize);
        self.minimumLineSpacing = kPNPEmotionMinimumLineSpacing;
        self.sectionInset = UIEdgeInsetsMake(kPNPEmotionMinimumLineSpacing - 4, kPNPEmotionMinimumLineSpacing, 0, kPNPEmotionMinimumLineSpacing);
        self.collectionView.alwaysBounceVertical = YES;
    }
    return self;
}

@end
