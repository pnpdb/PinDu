//
//  PNPEmotionCollectionViewCell.m
//  PNP
//
//  Created by lianhai on 14-8-21.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPEmotionCollectionViewCell.h"

@interface PNPEmotionCollectionViewCell ()

/**
 *  显示表情封面的控件
 */
@property (nonatomic, weak) UIImageView *emotionImageView;

/**
 *  配置默认控件和参数
 */
- (void)setup;
@end

@implementation PNPEmotionCollectionViewCell

#pragma setter method

- (void)setEmotion:(PNPEmotion *)emotion {
    _emotion = emotion;
    
    // TODO:
    self.emotionImageView.image = emotion.emotionConverPhoto;
}

#pragma mark - Life cycle

- (void)setup {
    if (!_emotionImageView) {
        UIImageView *emotionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPNPEmotionImageViewSize, kPNPEmotionImageViewSize)];
//        emotionImageView.backgroundColor = [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000];
        [self.contentView addSubview:emotionImageView];
        self.emotionImageView = emotionImageView;
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
    self.emotion = nil;
}

@end
