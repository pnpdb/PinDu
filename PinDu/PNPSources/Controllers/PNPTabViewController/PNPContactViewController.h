//
//  PNPContactViewController.h
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNPContactViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *dataSouceArray;//所有的汉子数组
    NSMutableDictionary *nameDic;//key:姓 value:对应姓的NSArray
}

@property(nonatomic, strong) UITableView *mTableView;

@property(nonatomic, strong) NSMutableArray *allName;

@end
