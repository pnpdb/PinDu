//
//  PNPContactInfoView.m
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPContactInfoView.h"
//#import "PNPMacro.h"

@interface PNPContactInfoView ()

@property(nonatomic, strong) UIButton *avatorButton;

@property(nonatomic, strong) UILabel *userNameLabel;

@property(nonatomic, strong) UILabel *userIdLabel;

@property(nonatomic, strong) UILabel *userNickNameLabel;

@property(nonatomic, strong) UIImageView *userSexImageView;


@end

@implementation PNPContactInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void) initViews
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.getAvatorImageView];
    [self addSubview:self.getUserNameLabel];
    [self addSubview:self.getUserIdLabel];
    [self addSubview:self.getUserNickNameLabel];
    [self.avatorButton addTarget:self action:@selector(avatorButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)avatorButtonClicked {
    if ([self.delegate respondsToSelector:@selector(didClickAvator)]){
        [self.delegate didClickAvator];
    }
}

-(UIButton*) getAvatorImageView
{
    if(!_avatorButton){
        _avatorButton = [[UIButton alloc] initWithFrame:CGRectMake(kPNPAlbumAvatorSpacing, kPNPAlbumAvatorSpacing, kPNPContactAvatorSize, kPNPContactAvatorSize)];
    }
    
    [_avatorButton setBackgroundImage:[UIImage imageNamed:@"avator2"] forState:UIControlStateNormal];
    
    return _avatorButton;
}

-(UILabel*) getUserNameLabel
{
    if (!_userNameLabel) {
        CGFloat userNameLabelX = CGRectGetMaxX(self.avatorButton.frame) + kPNPAlbumAvatorSpacing;
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabelX, CGRectGetMinY(self.avatorButton.frame), CGRectGetWidth(self.bounds) - userNameLabelX - kPNPAlbumAvatorSpacing, kPNPContactNameLabelHeight)];
        _userNameLabel.backgroundColor = [UIColor clearColor];
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.font = [UIFont boldSystemFontOfSize:14];
        
    }
    _userNameLabel.text = @"师芷韵";
    
    return _userNameLabel;
}

-(UILabel*) getUserIdLabel
{
    if (!_userIdLabel) {
        CGRect userIdLabelFrame = self.userNameLabel.frame;
//        userIdLabelFrame.origin.y += CGRectGetHeight(userIdLabelFrame);
        userIdLabelFrame.origin.y += 22;
        _userIdLabel = [[UILabel alloc] initWithFrame:userIdLabelFrame];
        _userIdLabel.backgroundColor = [UIColor clearColor];
        _userIdLabel.textColor = [UIColor grayColor];
        _userIdLabel.font = [UIFont systemFontOfSize:12];
    }
    _userIdLabel.text = @"品度号:pnpdb.com";
    
    return _userIdLabel;
}

-(UILabel*) getUserNickNameLabel
{
    if (!_userNickNameLabel) {
        CGRect userIdLabelFrame = self.userIdLabel.frame;
        userIdLabelFrame.origin.y += 18;
        _userNickNameLabel = [[UILabel alloc] initWithFrame:userIdLabelFrame];
        _userIdLabel.backgroundColor = [UIColor clearColor];
        _userNickNameLabel.textColor = [UIColor grayColor];
        _userNickNameLabel.font = [UIFont systemFontOfSize:12];
    }
    _userNickNameLabel.text = @"昵称：sunshine";
    
    return _userNickNameLabel;
}

#pragma protocol
- (void)didClickAvator
{
    NSLog(@"fafdasdfasdfasfsa");
}

@end
