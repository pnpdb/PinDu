//
//  PNPSessionViewController.h
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNPSessionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *sessionArray;

@end
