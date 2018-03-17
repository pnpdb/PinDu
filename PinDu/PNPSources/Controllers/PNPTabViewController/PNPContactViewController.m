//
//  PNPContactViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPContactViewController.h"
#import "PNPHanZiConvertHelper.h"
#import "PNPContactTableViewCell.h"
#import "PNPContactInfoViewController.h"

#define ALLANME @"张家辉 张学友 章子怡 赵文卓 炎亚纶 吴尊 汪东城 辰亦儒 言承旭 周渝民 吴建豪 朱孝天 胡宇崴 唐禹哲 陈浩民 陈小春 苏有朋 吴奇隆 陈志朋 周杰 张铁林 王刚 张国立 黄百鸣 林宥嘉 陈建州 胡歌 霍建华 佟大为 文章 陆毅 任泉 黄晓明 何润东 周杰伦 刘德华 郭富城 黎明 周润发 王力宏 古巨基 潘粤明 胡兵 欧阳震华 陈冠希 谢霆锋 张国荣 张翰 魏晨 朱梓骁 俞灏明 苏醒 韩庚 卓文萱 张韶涵 林依晨 杨丞琳 徐熙媛 徐熙娣 安以轩 黄小柔 赵薇 林心如 范冰冰 李冰冰 马雅舒 邓婕 范玮琪 杨幂 唐嫣 刘亦菲 刘品言 蔡依林 舒淇 黄奕 马伊俐 李小璐 张柏芝 王菲 郑爽 谢娜 容祖儿 黄圣依 王心凌 林志玲 鲍蕾 陶虹 孙俪 李宇春 张靓颖 周笔畅 何洁 谈莉娜 王珞丹 苗圃 陈慧琳 梁咏琪 李湘 刘若英 陈好 薛佳凝 周迅 安在旭 安琥 安又琪 安以轩 柳瀚雅"

@interface PNPContactViewController ()

@end

@implementation PNPContactViewController

@synthesize mTableView;
@synthesize allName;

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
    
    dataSouceArray = [NSArray arrayWithArray:[ALLANME componentsSeparatedByString:@" "]];
    self.allName = [[NSMutableArray alloc] init];
    for (int i=0; i<dataSouceArray.count; i++) {
        char firstChar = pinyinFirstLetter([[dataSouceArray objectAtIndex:i] characterAtIndex:0]);
        NSString *youName = [NSString stringWithFormat:@"%c",firstChar];
        //不添加重复元素
        if (![allName containsObject:[youName uppercaseString]]) {
            [self.allName addObject:[youName uppercaseString]];
        }
        
    }
    
    [self.allName sortUsingSelector:@selector(compare:)];
    //
    nameDic = [[NSMutableDictionary alloc] init];
    //每个section对应的行数列表
    for(NSString * sectionString  in allName)
    {
        NSMutableArray *rowSource = [[NSMutableArray alloc] init];
        for (NSString *charString in dataSouceArray) {
            char firstChar = pinyinFirstLetter([charString characterAtIndex:0]);
            NSString *youName = [NSString stringWithFormat:@"%c",firstChar];
            if ([sectionString isEqualToString:[youName uppercaseString]]) {
                [rowSource addObject:charString];
            }
        }
        
        [nameDic setValue:rowSource forKey:sectionString];
        
    }
    mTableView= [[UITableView alloc]initWithFrame:self.view.frame];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:mTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *dicCount = [nameDic objectForKey:[allName objectAtIndex:section]];
    return [dicCount count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [allName count];
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [allName objectAtIndex:section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    
    for(char c = 'A';c<='Z';c++)
        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
//    [toBeReturned addObject:@"#"];
    
    return toBeReturned;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SessionCellIdenfier = @"ContactCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"PNPContactTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:SessionCellIdenfier];
        nibsRegistered = YES;
    }
    
    PNPContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SessionCellIdenfier];
    if (cell == nil) {
        cell = [[PNPContactTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SessionCellIdenfier];
    }
    
    
    NSString * sectionString = [allName objectAtIndex:indexPath.section];
    
    NSArray *allShowName = [nameDic objectForKey:sectionString];
    if (allShowName.count>0) {
        
        int value =arc4random_uniform(3 + 1);
        switch (value) {
            case 0:
                cell.avatorView.image = [UIImage imageNamed:@"lianhai"];
                break;
            case 1:
                cell.avatorView.image = [UIImage imageNamed:@"huangjiaju"];
                break;
            case 2:
                cell.avatorView.image = [UIImage imageNamed:@"yanminmin"];
                break;
            default:
                cell.avatorView.image = [UIImage imageNamed:@"haosiyun"];
                break;
        }
        
        
//        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.nameLabel.text = [allShowName objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    NSInteger count = 0;
    for(NSString *character in allName)
    {
        if([character isEqualToString:title]) return count;
        count ++;
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mTableView deselectRowAtIndexPath:indexPath animated:YES];
    PNPContactInfoViewController *contactInfoController = [[PNPContactInfoViewController alloc] init];
    NSString * sectionString = [allName objectAtIndex:indexPath.section];
    NSArray *allShowName = [nameDic objectForKey:sectionString];
    [contactInfoController setUserName:[allShowName objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:contactInfoController animated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
