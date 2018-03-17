//
//  PNPSessionTableViewCell.h
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNPSessionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatorView;

@property (weak, nonatomic) IBOutlet UIImageView *statusView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *recordLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
