//
//  PNPContactInfoViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPContactInfoViewController.h"
#import "PNPContactPhotosTableViewCell.h"
#import "PNPContactInfoBottomView.h"


@interface PNPContactInfoViewController ()

@property(nonatomic, strong) PNPContactInfo *contact;

@property(nonatomic, strong) PNPContactInfoView *contactHeaderView;

@property (nonatomic, strong) PNPContactInfoBottomView *contactBottomView;

@end

@implementation PNPContactInfoViewController

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
    // Do any additional setup after loading the view.
    self.title = _userName;
    _contact = [[PNPContactInfo alloc] init];
    _mTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _mTableView.tableHeaderView = self.getTableHeaderView;
    _mTableView.tableFooterView = self.getTableBottomView;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    _contactHeaderView.delegate = self;
    
    [self.view addSubview:_mTableView];
    [self loadDataSource];
    
}

- (void)loadDataSource {
    self.dataSource = (NSMutableArray *)@[self.contact.contactRegion, self.contact.contactIntroduction, self.contact.contactMyAlbums];
}

- (NSMutableArray *)getDataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataSource;
}

-(PNPContactInfoView*) getTableHeaderView
{
    if(!_contactHeaderView){
        _contactHeaderView = [[PNPContactInfoView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), kPNPAlbumAvatorSpacing * 2 + kPNPContactAvatorSize)];
    }
    
    return _contactHeaderView;
}

- (PNPContactInfoBottomView *) getTableBottomView {
    if (!_contactBottomView) {
        _contactBottomView = [[PNPContactInfoBottomView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), (kPNPContactButtonHeight + kPNPContactButtonSpacing) * 2)];
        _contactBottomView.backgroundColor = [UIColor clearColor];
        
        [_contactBottomView.videoBottomButton addTarget:self action:@selector(videoBottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contactBottomView.messageBottomButton addTarget:self action:@selector(messageBottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBottomView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.getDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    PNPContactPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PNPContactPhotosTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    [cell configureCellWithContactInfo:self.dataSource[indexPath.row] atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return 60;
    } else {
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma PNPContactInfoAvatorProtocol

- (void)didClickAvator
{
    NSLog(@"click avator");
}

#pragma mark - Table Footer View Action

- (void)videoBottomButtonClicked:(UIButton *)sender {
    NSLog(@"video button clicked");
}

- (void)messageBottomButtonClicked:(UIButton *)sender {
    NSLog(@"message button clicked");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
