//
//  PNPGuideViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-25.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPGuideViewController.h"
#import "PNPLoginViewController.h"
#import "PNPGlobalData.h"

//一共有三页
#define count 3

@interface PNPGuideViewController ()

@property(nonatomic, strong) UIScrollView *mScrollView;

@property(nonatomic, strong) UIPageControl *mPageControl;

@property(nonatomic, strong) UIButton *startButton;

@end

@implementation PNPGuideViewController

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
    
    [self.navigationController setNavigationBarHidden:YES];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    _mScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _mScrollView.showsHorizontalScrollIndicator = NO;
    _mScrollView.showsVerticalScrollIndicator = NO;
    _mScrollView.contentSize = CGSizeMake(count*width, height);
    _mScrollView.pagingEnabled = YES;
    _mScrollView.backgroundColor = [UIColor grayColor];
    //禁止ScrollView上下移动
    _mScrollView.contentSize =  CGSizeMake(count*width, 0);
//    _mScrollView.alwaysBounceVertical = NO;
//    _mScrollView.alwaysBounceHorizontal = YES;
    _mScrollView.delegate = self;
    for (NSInteger i = 0; i < count; i++) {
        NSString *picName = [NSString stringWithFormat:@"%@%d",@"guide1",i+1];
        UIImage *image = [UIImage imageNamed:picName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(i*width, 0, width, height);
        [_mScrollView addSubview:imageView];
    }
    
    _mPageControl = [[UIPageControl alloc] init];
    _mPageControl.bounds = CGRectMake(0, 0, 200, 50);
    _mPageControl.center = CGPointMake(width*0.5, height-40);
    _mPageControl.numberOfPages = count;
    _mPageControl.currentPage = 0;
    [_mPageControl addTarget:self action:@selector(onPointClick) forControlEvents:UIControlEventValueChanged];
    
    _startButton = [[UIButton alloc] init];
    _startButton.bounds = CGRectMake(0, 0, 160, 36);
    _startButton.center = CGPointMake(width*2+width/2, height-80);
    _startButton.layer.cornerRadius = 4;
    _startButton.backgroundColor = [UIColor colorWithWhite:0.660 alpha:1.000];
    [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_startButton setTitle:@"进入品度" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(enterMain) forControlEvents:UIControlEventAllTouchEvents];
    [_mScrollView addSubview:_startButton];
    
    [self.view addSubview:_mScrollView];
    [self.view addSubview:_mPageControl];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) enterMain
{
    [PNPGlobalData setDefaultBOOLValueForKey:YES forKey:KEY_HAD_RUNNED];
    PNPLoginViewController *loginController = [[PNPLoginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
    [self.navigationController pushViewController:loginController animated:YES];
}

- (void) onPointClick
{
    CGFloat offsetX = _mPageControl.currentPage * _mScrollView.frame.size.width;
    [UIView animateWithDuration:0.3 animations:^{
        _mScrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
    
}

#pragma scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    int pageNum = scrollView.contentOffset.x / _mScrollView.frame.size.width;
     NSLog(@"%d", pageNum);
    _mPageControl.currentPage = pageNum;
}

-(void) dealloc
{
    _mScrollView = nil;
    _mPageControl = nil;
    _startButton = nil;
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
