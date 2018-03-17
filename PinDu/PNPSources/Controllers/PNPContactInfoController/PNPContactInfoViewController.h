//
//  PNPContactInfoViewController.h
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNPContactInfoView.h"

@interface PNPContactInfoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, PNPContactInfoAvatorProtocol>

@property(nonatomic, copy) NSString *userName;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) UITableView *mTableView;

@end
