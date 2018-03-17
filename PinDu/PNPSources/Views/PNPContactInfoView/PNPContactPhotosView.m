//
//  PNPContactPhotosView.m
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPContactPhotosView.h"
#import "PNPMacro.h"

@implementation PNPContactPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIButton *)crateButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    return button;
}

- (UIButton *)configurePhotoWithPhoto:(UIImage *)photo {
    UIButton *photoButton = [self crateButton];
    [photoButton setImage:photo forState:UIControlStateNormal];
    
    return photoButton;
}

- (UIButton *)configurePhotoWithPhotoUrlString:(NSString *)photoUrlString {
    return [self crateButton];
}

- (void)reloadData {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    for (id photo in self.photos) {
    for(int index = 0; index < [self.photos count]; index++){
//        NSInteger index = [self.photos indexOfObject:photo];
        id photo = [self.photos objectAtIndex:index];
        CGRect buttonFrame = CGRectMake(index * (kPNPAlbumPhotoSize + kPNPAlbumPhotoInsets), kPNPAlbumPhotoInsets, kPNPAlbumPhotoSize, kPNPAlbumPhotoSize);//y == 0--5
        UIButton *photoButton;
        if ([photo isKindOfClass:[NSString class]]) {
            photoButton = [self configurePhotoWithPhotoUrlString:photo];
        } else if ([photo isKindOfClass:[UIImage class]]) {
            photoButton = [self configurePhotoWithPhoto:photo];
            photoButton.frame = buttonFrame;
        }
        
        [self addSubview:photoButton];
    }
}


@end
