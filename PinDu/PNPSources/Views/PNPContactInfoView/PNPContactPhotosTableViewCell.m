//
//  PNPContactPhotosTableViewCell.m
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPContactPhotosTableViewCell.h"
#import "PNPContactPhotosView.h"
#import "PNPMacro.h"

@interface PNPContactPhotosTableViewCell ()

@property (nonatomic, strong) PNPContactPhotosView *contactPhotosView;

@end

@implementation PNPContactPhotosTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.detailTextLabel.numberOfLines = 2;
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:self.contactPhotosView];
    }
    return self;
}

- (void)configureCellWithContactInfo:(id)info atIndexPath:(NSIndexPath *)indexPath {
    NSString *placeholder;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.contactPhotosView.hidden = YES;
    switch (indexPath.row) {
        case 0:
            placeholder = @"地区";
            break;
        case 1:
            placeholder = @"个人签名";
            break;
        case 2: {
            placeholder = @"个人相册";
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        default:
            break;
    }
    
    self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    self.textLabel.text = placeholder;
    if ([info isKindOfClass:[NSString class]]) {
        self.detailTextLabel.text = info;
    } else if ([info isKindOfClass:[NSArray class]]) {
        self.contactPhotosView.hidden = NO;
        self.contactPhotosView.photos = info;
        [self.contactPhotosView reloadData];
    }
}

- (PNPContactPhotosView *)contactPhotosView {
    if (!_contactPhotosView) {
        CGFloat contactPhotosViewWidht = kPNPAlbumPhotoSize * 3 + kPNPAlbumPhotoInsets * 2;
        _contactPhotosView = [[PNPContactPhotosView alloc] initWithFrame:CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - (contactPhotosViewWidht + 40), kPNPAlbumPhotoInsets, contactPhotosViewWidht, kPNPAlbumPhotoSize)];
        _contactPhotosView.backgroundColor = self.contentView.backgroundColor;
        _contactPhotosView.hidden = YES;
    }
    return _contactPhotosView;
}

/**
 *  显示FooterView上的分割线
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse {
    self.contactPhotosView.photos = nil;
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
