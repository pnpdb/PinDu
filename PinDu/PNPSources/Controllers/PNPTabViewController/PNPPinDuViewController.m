//
//  PNPPinDuViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPPinDuViewController.h"
#import "PNPMacro.h"

@interface PNPPinDuViewController ()

@property(nonatomic, strong) PNPIndexPagerFrame *bannerView;

@end

@implementation PNPPinDuViewController

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
    
    if (CURRENT_SYS_VERSION >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    _bannerView = [self getBannerView];
    [self.view addSubview:_bannerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma propertity

-(PNPIndexPagerFrame*) getBannerView
{
    
    PNPIndexPagerItem *item1 = [[PNPIndexPagerItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"banner1"] tag:0];
    
    PNPIndexPagerItem *item2 = [[PNPIndexPagerItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"banner2"] tag:1];
    
    PNPIndexPagerItem *item3 = [[PNPIndexPagerItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"banner3"] tag:2];
    
    PNPIndexPagerItem *item4 = [[PNPIndexPagerItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"banner4"] tag:4];
    
    PNPIndexPagerFrame *imageFrame = [[PNPIndexPagerFrame alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100.0)
                                                                    delegate:self
                                                             focusImageItems:item1, item2, item3, item4, nil];
    
    return imageFrame;
}


#pragma PNPIndexPagerDelegate

- (void)foucusImageFrame:(PNPIndexPagerItem *)imageFrame didSelectItem:(PNPIndexPagerItem *)item
{
//    NSLog(@"%s \n click===>%@",__FUNCTION__,item.title);
}
- (void)foucusImageFrame:(PNPIndexPagerFrame *)imageFrame currentItem:(int)index;
{
//    NSLog(@"%s \n scrollToIndex===>%d",__FUNCTION__,index);
}

@end
