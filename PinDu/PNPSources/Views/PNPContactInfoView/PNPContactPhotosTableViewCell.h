//
//  PNPContactPhotosTableViewCell.h
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNPContactInfo.h"

typedef NS_ENUM(NSInteger, kXHContactInfoCellType) {
    kPNPContactInfoCellTypeNormal = 0,
    kPNPContactInfoCellTypeAlbum,
};

@interface PNPContactPhotosTableViewCell : UITableViewCell

- (void)configureCellWithContactInfo:(id)info atIndexPath:(NSIndexPath *)indexPath;

@end
