//
//  PNPSessionViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPSessionViewController.h"
#import "PNPChatViewController.h"
#import "PNPSessionTableViewCell.h"
#import "PNPSessionModel.h"

@interface PNPSessionViewController ()

@end

@implementation PNPSessionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [self loadSessionData];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    self.tableView = nil;
    self.sessionArray = nil;
}

-(void) enterMessage:(NSString*)userIdetifier
{
    PNPChatViewController *chatController = [[PNPChatViewController alloc] init];
    chatController.userName = userIdetifier;
    [self.navigationController pushViewController:chatController animated:YES];
}

#pragma UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PNPSessionModel *model = [_sessionArray objectAtIndex:indexPath.row];
    NSString* userIdetifier = model.name;
    [self enterMessage:userIdetifier];
    
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sessionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SessionCellIdenfier = @"SessionCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"PNPSessionTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:SessionCellIdenfier];
        nibsRegistered = YES;
    }
    
    PNPSessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SessionCellIdenfier];
    if (cell == nil) {
        cell = [[PNPSessionTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SessionCellIdenfier];
    }
    NSUInteger row = [indexPath row];
    PNPSessionModel *session = [_sessionArray objectAtIndex:row];
    
    cell.avatorView.image = session.avator;
    cell.nameLabel.text = session.name;
    cell.recordLabel.text = session.record;
    cell.timeLabel.text = session.time;
    if(session.failed){
        cell.statusView.hidden = NO;
    }else{
        cell.statusView.hidden = YES;
    }
    
    return cell;
}

-(void) loadSessionData
{
    PNPSessionModel *m1 = [[PNPSessionModel alloc] initWithAvator:[UIImage imageNamed:@"lianhai"] Name:@"李安海" Record:@"今天天气还不错！" Time:@"一天前" Failed:FALSE];
    PNPSessionModel *m2 = [[PNPSessionModel alloc] initWithAvator:[UIImage imageNamed:@"haosiyun"] Name:@"王小二" Record:@"一二三四五六七！" Time:@"一天前" Failed:FALSE];
    PNPSessionModel *m3 = [[PNPSessionModel alloc] initWithAvator:[UIImage imageNamed:@"yanminmin"] Name:@"牛小牛" Record:@"晚安！" Time:@"10分钟" Failed:FALSE];
    PNPSessionModel *m4 = [[PNPSessionModel alloc] initWithAvator:[UIImage imageNamed:@"huangjiaju"] Name:@"黄家驹" Record:@"这是测试消息消息消息消息消息！" Time:@"一分钟" Failed:TRUE];
    
    _sessionArray = [[NSMutableArray alloc] initWithObjects:m1, m2, m3, m4, nil];
}

@end
