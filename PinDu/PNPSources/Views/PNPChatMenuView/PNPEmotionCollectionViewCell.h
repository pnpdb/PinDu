//
//  PNPEmotionCollectionViewCell.h
//  PNP
//
//  Created by lianhai on 14-8-21.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNPEmotion.h"

#define kPNPEmotionCollectionViewCellIdentifier @"PNPEmotionCollectionViewCellIdentifier"

@interface PNPEmotionCollectionViewCell : UICollectionViewCell

/**
 *  需要显示和配置的gif表情对象
 */
@property (nonatomic, strong) PNPEmotion *emotion;

@end