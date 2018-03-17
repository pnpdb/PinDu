//
//  PNPMessageTableViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPMessageTableViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import "PNPVoiceRecordHUD.h"
#import "PNPAudioRecorderHelper.h"
#import "PNPPhotographyHelper.h"
#import "PNPLocationHelper.h"

#import "UIScrollView+KeyboardControl.h"

#import "PNPMacro.h"

@interface PNPMessageTableViewController ()

/**
 *  判断是否用户手指滚动
 */
@property (nonatomic, assign) BOOL isUserScrolling;

/**
 *  记录旧的textView contentSize Heigth
 */
@property (nonatomic, assign) CGFloat previousTextViewContentHeight;

/**
 *  记录键盘的高度，为了适配iPad和iPhone
 */
@property (nonatomic, assign) CGFloat keyboardViewHeight;

@property (nonatomic, assign) PNPInputViewType textViewInputViewType;

@property (nonatomic, weak, readwrite) PNPMessageTableView *messageTableView;
@property (nonatomic, weak, readwrite) PNPMessageInputView *messageInputView;
@property (nonatomic, weak, readwrite) PNPShareMenuView *shareMenuView;
@property (nonatomic, weak, readwrite) PNPEmotionManagerView *emotionManagerView;
@property (nonatomic, strong, readwrite) PNPVoiceRecordHUD *voiceRecordHUD;


@property (nonatomic, strong) UIView *headerContainerView;
@property (nonatomic, strong) UIActivityIndicatorView *loadMoreActivityIndicatorView;

/**
 *  管理本机的摄像和图片库的工具对象
 */
@property (nonatomic, strong) PNPPhotographyHelper *photographyHelper;

/**
 *  管理地理位置的工具对象
 */
@property (nonatomic, strong) PNPLocationHelper *locationHelper;

/**
 *  管理录音工具对象
 */
@property (nonatomic, strong) PNPAudioRecorderHelper *voiceRecordHelper;

#pragma mark - DataSource Change
/**
 *  改变数据源需要的子线程
 *
 *  @param queue 子线程执行完成的回调block
 */
- (void)exChangeMessageDataSourceQueue:(void (^)())queue;

/**
 *  执行块代码在主线程
 *
 *  @param queue 主线程执行完成回调block
 */
- (void)exMainQueue:(void (^)())queue;

#pragma mark - Previte Method
/**
 *  判断是否允许滚动
 *
 *  @return 返回判断结果
 */
- (BOOL)shouldAllowScroll;

#pragma mark - Life Cycle
/**
 *  配置默认参数
 */
- (void)setup;

/**
 *  初始化显示控件
 */
- (void)initilzer;

#pragma mark - RecorderPath Helper Method
/**
 *  获取录音的路径
 *
 *  @return 返回录音的路径
 */
- (NSString *)getRecorderPath;

#pragma mark - UITextView Helper Method
/**
 *  获取某个UITextView对象的content高度
 *
 *  @param textView 被获取的textView对象
 *
 *  @return 返回高度
 */
- (CGFloat)getTextViewContentH:(UITextView *)textView;

#pragma mark - Layout Message Input View Helper Method
/**
 *  动态改变TextView的高度
 *
 *  @param textView 被改变的textView对象
 */
- (void)layoutAndAnimateMessageInputTextView:(UITextView *)textView;

#pragma mark - Scroll Message TableView Helper Method
/**
 *  根据bottom的数值配置消息列表的内部布局变化
 *
 *  @param bottom 底部的空缺高度
 */
- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom;

/**
 *  根据底部高度获取UIEdgeInsets常量
 *
 *  @param bottom 底部高度
 *
 *  @return 返回UIEdgeInsets常量
 */
- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom;

#pragma mark - Message Calculate Cell Height
/**
 *  统一计算Cell的高度方法
 *
 *  @param message   被计算目标消息对象
 *  @param indexPath 被计算目标消息所在的位置
 *
 *  @return 返回计算的高度
 */
- (CGFloat)calculateCellHeightWithMessage:(id <PNPMessageProtocol>)message atIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Message Send helper Method
/**
 *  根据文本开始发送文本消息
 *
 *  @param text 目标文本
 */
- (void)didSendMessageWithText:(NSString *)text;
/**
 *  根据图片开始发送图片消息
 *
 *  @param photo 目标图片
 */
- (void)didSendMessageWithPhoto:(UIImage *)photo;
/**
 *  根据视频的封面和视频的路径开始发送视频消息
 *
 *  @param videoConverPhoto 目标视频的封面图
 *  @param videoPath        目标视频的路径
 */
- (void)didSendMessageWithVideoConverPhoto:(UIImage *)videoConverPhoto videoPath:(NSString *)videoPath;
/**
 *  根据录音路径开始发送语音消息
 *
 *  @param voicePath        目标语音路径
 *  @param voiceDuration    目标语音时长
 */
- (void)didSendMessageWithVoice:(NSString *)voicePath voiceDuration:(NSString*)voiceDuration;
/**
 *  根据第三方gif表情路径开始发送表情消息
 *
 *  @param emotionPath 目标gif表情路径
 */
- (void)didSendEmotionMessageWithEmotionPath:(NSString *)emotionPath;
/**
 *  根据地理位置信息和地理经纬度开始发送地理位置消息
 *
 *  @param geolcations 目标地理信息
 *  @param location    目标地理经纬度
 */
- (void)didSendGeolocationsMessageWithGeolocaltions:(NSString *)geolcations location:(CLLocation *)location;

#pragma mark - Other Menu View Frame Helper Mehtod
/**
 *  根据显示或隐藏的需求对所有第三方Menu进行管理
 *
 *  @param hide 需求条件
 */
- (void)layoutOtherMenuViewHiden:(BOOL)hide;

#pragma mark - Voice Recording Helper Method
/**
 *  开始录音
 */
- (void)startRecord;
/**
 *  完成录音
 */
- (void)finishRecorded;
/**
 *  想停止录音
 */
- (void)pauseRecord;
/**
 *  继续录音
 */
- (void)resumeRecord;
/**
 *  取消录音
 */
- (void)cancelRecord;

@end

@implementation PNPMessageTableViewController

#pragma mark - DataSource Change

- (void)exChangeMessageDataSourceQueue:(void (^)())queue {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

- (void)exMainQueue:(void (^)())queue {
    dispatch_async(dispatch_get_main_queue(), queue);
}

- (void)addMessage:(PNPMessage *)addedMessage {
    [self exChangeMessageDataSourceQueue:^{
        NSMutableArray *messages = [NSMutableArray arrayWithArray:self.messages];
        [messages addObject:addedMessage];
        
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:1];
        [indexPaths addObject:[NSIndexPath indexPathForRow:messages.count - 1 inSection:0]];
        
        [self exMainQueue:^{
            self.messages = messages;
            [self.messageTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [self scrollToBottomAnimated:YES];
        }];
    }];
}

- (void)removeMessageAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.messages.count)
        return;
    [self.messages removeObjectAtIndex:indexPath.row];
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:1];
    [indexPaths addObject:indexPath];
    
    [self.messageTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
}

static CGPoint  delayOffset = {0.0};
// http://stackoverflow.com/a/11602040 Keep UITableView static when inserting rows at the top
- (void)insertOldMessages:(NSArray *)oldMessages {
    [self exChangeMessageDataSourceQueue:^{
        NSMutableArray *messages = [NSMutableArray arrayWithArray:oldMessages];
        [messages addObjectsFromArray:self.messages];
        
        delayOffset = self.messageTableView.contentOffset;
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:oldMessages.count];
        [oldMessages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [indexPaths addObject:indexPath];
            
            delayOffset.y += [self calculateCellHeightWithMessage:[messages objectAtIndex:idx] atIndexPath:indexPath];
        }];
        
        [self exMainQueue:^{
            [UIView setAnimationsEnabled:NO];
            [self.messageTableView beginUpdates];
            self.messages = messages;
            [self.messageTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            
            [self.messageTableView setContentOffset:delayOffset animated:NO];
            [self.messageTableView endUpdates];
            [UIView setAnimationsEnabled:YES];
            
        }];
    }];
}

#pragma mark - Propertys

- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _messages;
}

- (UIView *)headerContainerView {
    if (!_headerContainerView) {
        _headerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
        _headerContainerView.backgroundColor = self.messageTableView.backgroundColor;
        [_headerContainerView addSubview:self.loadMoreActivityIndicatorView];
    }
    return _headerContainerView;
}
- (UIActivityIndicatorView *)loadMoreActivityIndicatorView {
    if (!_loadMoreActivityIndicatorView) {
        _loadMoreActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadMoreActivityIndicatorView.center = CGPointMake(CGRectGetWidth(_headerContainerView.bounds) / 2.0, CGRectGetHeight(_headerContainerView.bounds) / 2.0);
    }
    return _loadMoreActivityIndicatorView;
}
- (void)setLoadingMoreMessage:(BOOL)loadingMoreMessage {
    _loadingMoreMessage = loadingMoreMessage;
    if (loadingMoreMessage) {
        [self.loadMoreActivityIndicatorView startAnimating];
    } else {
        [self.loadMoreActivityIndicatorView stopAnimating];
    }
}

- (PNPShareMenuView *)shareMenuView {
    if (!_shareMenuView) {
        PNPShareMenuView *shareMenuView = [[PNPShareMenuView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), self.keyboardViewHeight)];
        shareMenuView.delegate = self;
        shareMenuView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
        shareMenuView.alpha = 0.0;
        shareMenuView.shareMenuItems = self.shareMenuItems;
        [self.view addSubview:shareMenuView];
        _shareMenuView = shareMenuView;
    }
    [self.view bringSubviewToFront:_shareMenuView];
    return _shareMenuView;
}

- (PNPEmotionManagerView *)emotionManagerView {
    if (!_emotionManagerView) {
        PNPEmotionManagerView *emotionManagerView = [[PNPEmotionManagerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), self.keyboardViewHeight)];
        emotionManagerView.delegate = self;
        emotionManagerView.dataSource = self;
        emotionManagerView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
        emotionManagerView.alpha = 0.0;
        [self.view addSubview:emotionManagerView];
        _emotionManagerView = emotionManagerView;
    }
    [self.view bringSubviewToFront:_emotionManagerView];
    return _emotionManagerView;
}

- (PNPVoiceRecordHUD *)voiceRecordHUD {
    if (!_voiceRecordHUD) {
        _voiceRecordHUD = [[PNPVoiceRecordHUD alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    }
    return _voiceRecordHUD;
}

- (PNPPhotographyHelper *)photographyHelper {
    if (!_photographyHelper) {
        _photographyHelper = [[PNPPhotographyHelper alloc] init];
    }
    return _photographyHelper;
}

- (PNPLocationHelper *)locationHelper {
    if (!_locationHelper) {
        _locationHelper = [[PNPLocationHelper alloc] init];
    }
    return _locationHelper;
}

- (PNPAudioRecorderHelper *)voiceRecordHelper {
    
    typeof(self) __weak weakSelf = self;
    
    if (!_voiceRecordHelper) {
        _voiceRecordHelper = [[PNPAudioRecorderHelper alloc] init];
        _voiceRecordHelper.maxTimeStopRecorderCompletion = ^{
            NSLog(@"已经达到最大限制时间了，进入下一步的提示");
            [weakSelf finishRecorded];
        };
        _voiceRecordHelper.peakPowerForChannel = ^(float peakPowerForChannel) {
            weakSelf.voiceRecordHUD.peakPower = peakPowerForChannel;
        };
        _voiceRecordHelper.maxRecordTime = kVoiceRecorderTotalTime;
    }
    return _voiceRecordHelper;
}

#pragma mark - Messages View Controller

- (void)finishSendMessageWithBubbleMessageType:(PNPBubbleMessageMediaType)mediaType {
    switch (mediaType) {
        case PNPBubbleMessageMediaTypeText: {
            [self.messageInputView.inputTextView setText:nil];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                self.messageInputView.inputTextView.enablesReturnKeyAutomatically = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.messageInputView.inputTextView.enablesReturnKeyAutomatically = YES;
                    [self.messageInputView.inputTextView reloadInputViews];
                });
            }
            break;
        }
        case PNPBubbleMessageMediaTypePhoto: {
            break;
        }
        case PNPBubbleMessageMediaTypeVideo: {
            break;
        }
        case PNPBubbleMessageMediaTypeVoice: {
            break;
        }
        case PNPBubbleMessageMediaTypeGIFAnimation: {
            break;
        }
        case PNPBubbleMessageMediaTypeLocalPosition: {
            break;
        }
        default:
            break;
    }
}

- (void)setBackgroundColor:(UIColor *)color {
    self.view.backgroundColor = color;
    _messageTableView.backgroundColor = color;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.messageTableView.backgroundView = nil;
    self.messageTableView.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
	if (![self shouldAllowScroll])
        return;
	
    NSInteger rows = [self.messageTableView numberOfRowsInSection:0];
    
    if (rows > 0) {
        [self.messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                                     atScrollPosition:UITableViewScrollPositionBottom
                                             animated:animated];
    }
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath
			  atScrollPosition:(UITableViewScrollPosition)position
					  animated:(BOOL)animated {
	if (![self shouldAllowScroll])
        return;
	
	[self.messageTableView scrollToRowAtIndexPath:indexPath
                                 atScrollPosition:position
                                         animated:animated];
}

#pragma mark - Previte Method

- (BOOL)shouldAllowScroll {
    if (self.isUserScrolling) {
        if ([self.delegate respondsToSelector:@selector(shouldPreventScrollToBottomWhileUserScrolling)]
            && [self.delegate shouldPreventScrollToBottomWhileUserScrolling]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Life Cycle

- (void)setup {
    // iPhone or iPad keyboard view height set here.
    self.keyboardViewHeight = (kIsiPad ? 264 : 216);
    _allowsPanToDismissKeyboard = YES;
    _allowsSendVoice = YES;
    _allowsSendMultiMedia = YES;
    _allowsSendFace = YES;
    _inputViewStyle = PNPMessageInputViewStyleFlat;
    
    self.delegate = self;
    self.dataSource = self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)initilzer {
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 默认设置用户滚动为NO
    _isUserScrolling = NO;
    
    // 初始化message tableView
	PNPMessageTableView *messageTableView = [[PNPMessageTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	messageTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	messageTableView.dataSource = self;
	messageTableView.delegate = self;
    messageTableView.separatorColor = [UIColor clearColor];
    messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    BOOL shouldLoadMoreMessagesScrollToTop = YES;
    if ([self.delegate respondsToSelector:@selector(shouldLoadMoreMessagesScrollToTop)]) {
        shouldLoadMoreMessagesScrollToTop = [self.delegate shouldLoadMoreMessagesScrollToTop];
    }
    if (shouldLoadMoreMessagesScrollToTop) {
        messageTableView.tableHeaderView = self.headerContainerView;
    }
    [self.view addSubview:messageTableView];
    [self.view sendSubviewToBack:messageTableView];
	_messageTableView = messageTableView;
    
    // 设置Message TableView 的bottom edg
    CGFloat inputViewHeight = (self.inputViewStyle == PNPMessageInputViewStyleFlat) ? 45.0f : 40.0f;
    [self setTableViewInsetsWithBottomValue:inputViewHeight];
    
    // 设置整体背景颜色
    [self setBackgroundColor:[UIColor whiteColor]];
    
    // 输入工具条的frame
    CGRect inputFrame = CGRectMake(0.0f,
                                   self.view.frame.size.height - inputViewHeight,
                                   self.view.frame.size.width,
                                   inputViewHeight);
    
    if (self.allowsPanToDismissKeyboard) {
        // 控制输入工具条的位置块
        void (^AnimationForMessageInputViewAtPoint)(CGPoint point) = ^(CGPoint point) {
            CGRect inputViewFrame = self.messageInputView.frame;
            CGPoint keyboardOrigin = [self.view convertPoint:point fromView:nil];
            inputViewFrame.origin.y = keyboardOrigin.y - inputViewFrame.size.height;
            self.messageInputView.frame = inputViewFrame;
        };
        
        self.messageTableView.keyboardDidScrollToPoint = ^(CGPoint point) {
            if (self.textViewInputViewType == PNPInputViewTypeText)
                AnimationForMessageInputViewAtPoint(point);
        };
        
        self.messageTableView.keyboardWillSnapBackToPoint = ^(CGPoint point) {
            if (self.textViewInputViewType == PNPInputViewTypeText)
                AnimationForMessageInputViewAtPoint(point);
        };
        
        self.messageTableView.keyboardWillBeDismissed = ^() {
            CGRect inputViewFrame = self.messageInputView.frame;
            inputViewFrame.origin.y = self.view.bounds.size.height - inputViewFrame.size.height;
            self.messageInputView.frame = inputViewFrame;
        };
    }
    
    // block回调键盘通知
    self.messageTableView.keyboardWillChange = ^(CGRect keyboardRect, UIViewAnimationOptions options, double duration, BOOL showKeyborad) {
        if (self.textViewInputViewType == PNPInputViewTypeText) {
            [UIView animateWithDuration:duration
                                  delay:0.0
                                options:options
                             animations:^{
                                 CGFloat keyboardY = [self.view convertRect:keyboardRect fromView:nil].origin.y;
                                 
                                 CGRect inputViewFrame = self.messageInputView.frame;
                                 CGFloat inputViewFrameY = keyboardY - inputViewFrame.size.height;
                                 
                                 // for ipad modal form presentations
                                 CGFloat messageViewFrameBottom = self.view.frame.size.height - inputViewFrame.size.height;
                                 if (inputViewFrameY > messageViewFrameBottom)
                                     inputViewFrameY = messageViewFrameBottom;
                                 
                                 self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                                              inputViewFrameY,
                                                                              inputViewFrame.size.width,
                                                                              inputViewFrame.size.height);
                                 
                                 [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
                                  - self.messageInputView.frame.origin.y];
                                 if (showKeyborad)
                                     [self scrollToBottomAnimated:NO];
                             }
                             completion:nil];
        }
    };
    
    self.messageTableView.keyboardDidChange = ^(BOOL didShowed) {
        if ([self.messageInputView.inputTextView isFirstResponder]) {
            if (didShowed) {
                if (self.textViewInputViewType == PNPInputViewTypeText) {
                    self.shareMenuView.alpha = 0.0;
                    self.emotionManagerView.alpha = 0.0;
                }
            }
        }
    };
    
    self.messageTableView.keyboardDidHide = ^() {
        [self.messageInputView.inputTextView resignFirstResponder];
    };
    
    // 初始化输入工具条
    PNPMessageInputView *inputView = [[PNPMessageInputView alloc] initWithFrame:inputFrame];
    inputView.allowsSendFace = self.allowsSendFace;
    inputView.allowsSendVoice = self.allowsSendVoice;
    inputView.allowsSendMultiMedia = self.allowsSendMultiMedia;
    inputView.delegate = self;
    [self.view addSubview:inputView];
    [self.view bringSubviewToFront:inputView];
    
    _messageInputView = inputView;
    
    
    // 设置手势滑动，默认添加一个bar的高度值
    self.messageTableView.messageInputBarHeight = CGRectGetHeight(_messageInputView.bounds);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置键盘通知或者手势控制键盘消失
    [self.messageTableView setupPanGestureControlKeyboardHide:self.allowsPanToDismissKeyboard];
    
    // KVO 检查contentSize
    [self.messageInputView.inputTextView addObserver:self
                                          forKeyPath:@"contentSize"
                                             options:NSKeyValueObservingOptionNew
                                             context:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 取消输入框
    [self.messageInputView.inputTextView resignFirstResponder];
    [self setEditing:NO animated:YES];
    
    // remove键盘通知或者手势
    [self.messageTableView disSetupPanGestureControlKeyboardHide:self.allowsPanToDismissKeyboard];
    
    // remove KVO
    [self.messageInputView.inputTextView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化消息页面布局
    [self initilzer];
    [[PNPMessageBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _messages = nil;
    _delegate = nil;
    _dataSource = nil;
    _messageTableView.delegate = nil;
    _messageTableView.dataSource = nil;
    _messageTableView = nil;
    _messageInputView = nil;
    
    _photographyHelper = nil;
    _locationHelper = nil;
}

#pragma mark - View Rotation

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark - RecorderPath Helper Method

- (NSString *)getRecorderPath {
    NSString *recorderPath = nil;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yy-MMMM-dd";
    recorderPath = [[NSString alloc] initWithFormat:@"%@/Documents/", NSHomeDirectory()];
    //    dateFormatter.dateFormat = @"hh-mm-ss";
    dateFormatter.dateFormat = @"yyyy-MM-dd-hh-mm-ss";
    recorderPath = [recorderPath stringByAppendingFormat:@"%@-MySound.caf", [dateFormatter stringFromDate:now]];
    return recorderPath;
}

#pragma mark - UITextView Helper Method

- (CGFloat)getTextViewContentH:(UITextView *)textView {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    } else {
        return textView.contentSize.height;
    }
}

#pragma mark - Layout Message Input View Helper Method

- (void)layoutAndAnimateMessageInputTextView:(UITextView *)textView {
    CGFloat maxHeight = [PNPMessageInputView maxHeight];
    
    CGFloat contentH = [self getTextViewContentH:textView];
    
    BOOL isShrinking = contentH < self.previousTextViewContentHeight;
    CGFloat changeInHeight = contentH - _previousTextViewContentHeight;
    
    if (!isShrinking && (self.previousTextViewContentHeight == maxHeight || textView.text.length == 0)) {
        changeInHeight = 0;
    }
    else {
        changeInHeight = MIN(changeInHeight, maxHeight - self.previousTextViewContentHeight);
    }
    
    if (changeInHeight != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             [self setTableViewInsetsWithBottomValue:self.messageTableView.contentInset.bottom + changeInHeight];
                             
                             [self scrollToBottomAnimated:NO];
                             
                             if (isShrinking) {
                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                                     self.previousTextViewContentHeight = MIN(contentH, maxHeight);
                                 }
                                 // if shrinking the view, animate text view frame BEFORE input view frame
                                 [self.messageInputView adjustTextViewHeightBy:changeInHeight];
                             }
                             
                             CGRect inputViewFrame = self.messageInputView.frame;
                             self.messageInputView.frame = CGRectMake(0.0f,
                                                                      inputViewFrame.origin.y - changeInHeight,
                                                                      inputViewFrame.size.width,
                                                                      inputViewFrame.size.height + changeInHeight);
                             if (!isShrinking) {
                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                                     self.previousTextViewContentHeight = MIN(contentH, maxHeight);
                                 }
                                 // growing the view, animate the text view frame AFTER input view frame
                                 [self.messageInputView adjustTextViewHeightBy:changeInHeight];
                             }
                         }
                         completion:^(BOOL finished) {
                         }];
        
        self.previousTextViewContentHeight = MIN(contentH, maxHeight);
    }
    
    // Once we reached the max height, we have to consider the bottom offset for the text view.
    // To make visible the last line, again we have to set the content offset.
    if (self.previousTextViewContentHeight == maxHeight) {
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime,
                       dispatch_get_main_queue(),
                       ^(void) {
                           CGPoint bottomOffset = CGPointMake(0.0f, contentH - textView.bounds.size.height);
                           [textView setContentOffset:bottomOffset animated:YES];
                       });
    }
}

#pragma mark - Scroll Message TableView Helper Method

- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom {
    UIEdgeInsets insets = [self tableViewInsetsWithBottomValue:bottom];
    self.messageTableView.contentInset = insets;
    self.messageTableView.scrollIndicatorInsets = insets;
}

- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        insets.top = 64;
    }
    
    insets.bottom = bottom;
    
    return insets;
}

#pragma mark - Message Calculate Cell Height

- (CGFloat)calculateCellHeightWithMessage:(id <PNPMessageProtocol>)message atIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = 0;
    
    BOOL displayTimestamp = YES;
    if ([self.delegate respondsToSelector:@selector(shouldDisplayTimestampForRowAtIndexPath:)]) {
        displayTimestamp = [self.delegate shouldDisplayTimestampForRowAtIndexPath:indexPath];
    }
    
    cellHeight = [PNPMessageTableViewCell calculateCellHeightWithMessage:message displaysTimestamp:displayTimestamp];
    
    return cellHeight;
}

#pragma mark - Message Send helper Method

- (void)didSendMessageWithText:(NSString *)text {
    NSLog(@"send text : %@", text);
    if ([self.delegate respondsToSelector:@selector(didSendText:fromSender:onDate:)]) {
        [self.delegate didSendText:text fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendMessageWithPhoto:(UIImage *)photo {
    NSLog(@"send photo : %@", photo);
    if ([self.delegate respondsToSelector:@selector(didSendPhoto:fromSender:onDate:)]) {
        [self.delegate didSendPhoto:photo fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendMessageWithVideoConverPhoto:(UIImage *)videoConverPhoto videoPath:(NSString *)videoPath  {
    NSLog(@"send videoPath : %@  videoConverPhoto : %@", videoPath, videoConverPhoto);
    if ([self.delegate respondsToSelector:@selector(didSendVideoConverPhoto:videoPath:fromSender:onDate:)]) {
        [self.delegate didSendVideoConverPhoto:videoConverPhoto videoPath:videoPath fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendMessageWithVoice:(NSString *)voicePath voiceDuration:(NSString*)voiceDuration {
    NSLog(@"send voicePath : %@", voicePath);
    if ([self.delegate respondsToSelector:@selector(didSendVoice:voiceDuration:fromSender:onDate:)]) {
        [self.delegate didSendVoice:voicePath voiceDuration:voiceDuration fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendEmotionMessageWithEmotionPath:(NSString *)emotionPath {
    NSLog(@"send emotionPath : %@", emotionPath);
    if ([self.delegate respondsToSelector:@selector(didSendEmotion:fromSender:onDate:)]) {
        [self.delegate didSendEmotion:emotionPath fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendGeolocationsMessageWithGeolocaltions:(NSString *)geolcations location:(CLLocation *)location {
    NSLog(@"send geolcations : %@", geolcations);
    if ([self.delegate respondsToSelector:@selector(didSendGeoLocationsPhoto:geolocations:location:fromSender:onDate:)]) {
        [self.delegate didSendGeoLocationsPhoto:[UIImage imageNamed:@"Fav_Cell_Loc"] geolocations:geolcations location:location fromSender:self.messageSender onDate:[NSDate date]];
    }
}

#pragma mark - Other Menu View Frame Helper Mehtod

- (void)layoutOtherMenuViewHiden:(BOOL)hide {
    [self.messageInputView.inputTextView resignFirstResponder];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        __block CGRect inputViewFrame = self.messageInputView.frame;
        __block CGRect otherMenuViewFrame;
        
        void (^InputViewAnimation)(BOOL hide) = ^(BOOL hide) {
            inputViewFrame.origin.y = (hide ? (CGRectGetHeight(self.view.bounds) - CGRectGetHeight(inputViewFrame)) : (CGRectGetMinY(otherMenuViewFrame) - CGRectGetHeight(inputViewFrame)));
            self.messageInputView.frame = inputViewFrame;
        };
        
        void (^EmotionManagerViewAnimation)(BOOL hide) = ^(BOOL hide) {
            otherMenuViewFrame = self.emotionManagerView.frame;
            otherMenuViewFrame.origin.y = (hide ? CGRectGetHeight(self.view.frame) : (CGRectGetHeight(self.view.frame) - CGRectGetHeight(otherMenuViewFrame)));
            self.emotionManagerView.alpha = !hide;
            self.emotionManagerView.frame = otherMenuViewFrame;
        };
        
        void (^ShareMenuViewAnimation)(BOOL hide) = ^(BOOL hide) {
            otherMenuViewFrame = self.shareMenuView.frame;
            otherMenuViewFrame.origin.y = (hide ? CGRectGetHeight(self.view.frame) : (CGRectGetHeight(self.view.frame) - CGRectGetHeight(otherMenuViewFrame)));
            self.shareMenuView.alpha = !hide;
            self.shareMenuView.frame = otherMenuViewFrame;
        };
        
        if (hide) {
            switch (self.textViewInputViewType) {
                case PNPInputViewTypeEmotion: {
                    EmotionManagerViewAnimation(hide);
                    break;
                }
                case PNPInputViewTypeShareMenu: {
                    ShareMenuViewAnimation(hide);
                    break;
                }
                default:
                    break;
            }
        } else {
            
            // 这里需要注意block的执行顺序，因为otherMenuViewFrame是公用的对象，所以对于被隐藏的Menu的frame的origin的y会是最大值
            switch (self.textViewInputViewType) {
                case PNPInputViewTypeEmotion: {
                    // 1、先隐藏和自己无关的View
                    ShareMenuViewAnimation(!hide);
                    // 2、再显示和自己相关的View
                    EmotionManagerViewAnimation(hide);
                    break;
                }
                case PNPInputViewTypeShareMenu: {
                    // 1、先隐藏和自己无关的View
                    EmotionManagerViewAnimation(!hide);
                    // 2、再显示和自己相关的View
                    ShareMenuViewAnimation(hide);
                    break;
                }
                default:
                    break;
            }
        }
        
        InputViewAnimation(hide);
        
        [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
         - self.messageInputView.frame.origin.y];
        
        [self scrollToBottomAnimated:NO];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Voice Recording Helper Method

- (void)startRecord {
    [self.voiceRecordHUD startRecordingHUDAtView:self.view];
    [self.voiceRecordHelper startRecordingWithPath:[self getRecorderPath] StartRecorderCompletion:^{
        
    }];
}

- (void)finishRecorded {
    [self.voiceRecordHUD stopRecordCompled:^(BOOL fnished) {
        self.voiceRecordHUD = nil;
    }];
    [self.voiceRecordHelper stopRecordingWithStopRecorderCompletion:^{
        [self didSendMessageWithVoice:self.voiceRecordHelper.recordPath voiceDuration:self.voiceRecordHelper.recordDuration];
    }];
}

- (void)pauseRecord {
    [self.voiceRecordHUD pauseRecord];
}

- (void)resumeRecord {
    [self.voiceRecordHUD resaueRecord];
}

- (void)cancelRecord {
    [self.voiceRecordHUD cancelRecordCompled:^(BOOL fnished) {
        self.voiceRecordHUD = nil;
    }];
    [self.voiceRecordHelper cancelledDeleteWithCompletion:^{
        
    }];
}

#pragma mark - PNPMessageInputView Delegate

- (void)inputTextViewWillBeginEditing:(PNPMessageTextView *)messageInputTextView {
    self.textViewInputViewType = PNPInputViewTypeText;
}

- (void)inputTextViewDidBeginEditing:(PNPMessageTextView *)messageInputTextView {
    if (!self.previousTextViewContentHeight)
		self.previousTextViewContentHeight = [self getTextViewContentH:messageInputTextView];
}

- (void)didChangeSendVoiceAction:(BOOL)changed {
    if (changed) {
        if (self.textViewInputViewType == PNPInputViewTypeText)
            return;
        // 在这之前，textViewInputViewType已经不是PNPTextViewTextInputType
        [self layoutOtherMenuViewHiden:YES];
    }
}

- (void)didSendTextAction:(NSString *)text {
    NSLog(@"text : %@", text);
    if ([self.delegate respondsToSelector:@selector(didSendText:fromSender:onDate:)]) {
        [self.delegate didSendText:text fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSelectedMultipleMediaAction {
    NSLog(@"didSelectedMultipleMediaAction");
    self.textViewInputViewType = PNPInputViewTypeShareMenu;
    [self layoutOtherMenuViewHiden:NO];
}

- (void)didSendFaceAction:(BOOL)sendFace {
    if (sendFace) {
        self.textViewInputViewType = PNPInputViewTypeEmotion;
        [self layoutOtherMenuViewHiden:NO];
    } else {
        [self.messageInputView.inputTextView becomeFirstResponder];
    }
}

- (void)didStartRecordingVoiceAction {
    NSLog(@"didStartRecordingVoice");
    [self startRecord];
}

- (void)didCancelRecordingVoiceAction {
    NSLog(@"didCancelRecordingVoice");
    [self cancelRecord];
}

- (void)didFinishRecoingVoiceAction {
    NSLog(@"didFinishRecoingVoice");
    [self finishRecorded];
}

- (void)didDragOutsideAction {
    NSLog(@"didDragOutsideAction");
    [self resumeRecord];
}

- (void)didDragInsideAction {
    NSLog(@"didDragInsideAction");
    [self pauseRecord];
}

#pragma mark - PNPShareMenuView Delegate

- (void)didSelecteShareMenuItem:(PNPShareMenuItem *)shareMenuItem atIndex:(NSInteger)index {
    NSLog(@"title : %@   index:%ld", shareMenuItem.title, (long)index);
    
    void (^PickerMediaBlock)(UIImage *image, NSDictionary *editingInfo) = ^(UIImage *image, NSDictionary *editingInfo) {
        if (image) {
            [self didSendMessageWithPhoto:image];
        } else {
            if (!editingInfo)
                return ;
            NSString *mediaType = [editingInfo objectForKey: UIImagePickerControllerMediaType];
            NSString *videoPath;
            NSURL *videoUrl;
            if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
                videoUrl = (NSURL*)[editingInfo objectForKey:UIImagePickerControllerMediaURL];
                videoPath = [videoUrl path];
                
                UIImage *thumbnailImage = [PNPMessageVideoConverPhotoFactory videoConverPhotoWithVideoPath:videoPath];
                
                [self didSendMessageWithVideoConverPhoto:thumbnailImage videoPath:videoPath];
            } else {
                [self didSendMessageWithPhoto:[editingInfo valueForKey:UIImagePickerControllerOriginalImage]];
            }
        }
    };
    switch (index) {
        case 0: {
            [self.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:self compled:PickerMediaBlock];
            break;
        }
        case 1: {
            [self.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypeCamera onViewController:self compled:PickerMediaBlock];
            break;
        }
        case 2: {
            [self.locationHelper getCurrentGeolocationsCompled:^(NSArray *placemarks) {
                CLPlacemark *placemark = [placemarks lastObject];
                if (placemark) {
                    NSDictionary *addressDictionary = placemark.addressDictionary;
                    NSArray *formattedAddressLines = [addressDictionary valueForKey:@"FormattedAddressLines"];
                    NSString *geoLocations = [formattedAddressLines lastObject];
                    if (geoLocations) {
                        [self didSendGeolocationsMessageWithGeolocaltions:geoLocations location:placemark.location];
                    }
                }
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - PNPEmotionManagerView Delegate

- (void)didSelecteEmotion:(PNPEmotion *)emotion atIndexPath:(NSIndexPath *)indexPath {
    if (emotion.emotionPath) {
        [self didSendEmotionMessageWithEmotionPath:emotion.emotionPath];
    }
}

#pragma mark - PNPEmotionManagerView DataSource

- (NSInteger)numberOfEmotionManagers {
    return 0;
}

- (PNPEmotionManager *)emotionManagerForColumn:(NSInteger)column {
    return nil;
}

- (NSArray *)emotionManagersAtManager {
    return nil;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(shouldLoadMoreMessagesScrollToTop)]) {
        BOOL shouldLoadMoreMessages = [self.delegate shouldLoadMoreMessagesScrollToTop];
        if (shouldLoadMoreMessages) {
            if (scrollView.contentOffset.y >=0 && scrollView.contentOffset.y <= 44) {
                if (!self.loadingMoreMessage) {
                    if ([self.delegate respondsToSelector:@selector(loadMoreMessagesScrollTotop)]) {
                        [self.delegate loadMoreMessagesScrollTotop];
                    }
                }
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	self.isUserScrolling = YES;
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }
    
    if (self.textViewInputViewType != PNPInputViewTypeNormal && self.textViewInputViewType != PNPInputViewTypeText) {
        [self layoutOtherMenuViewHiden:YES];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.isUserScrolling = NO;
}

#pragma mark - PNPMessageTableViewController Delegate

- (BOOL)shouldPreventScrollToBottomWhileUserScrolling {
    return YES;
}

#pragma mark - PNPMessageTableViewController DataSource

- (id <PNPMessageProtocol>)messageForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.messages[indexPath.row];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id <PNPMessageProtocol> message = [self.dataSource messageForRowAtIndexPath:indexPath];
    
    BOOL displayTimestamp = YES;
    if ([self.delegate respondsToSelector:@selector(shouldDisplayTimestampForRowAtIndexPath:)]) {
        displayTimestamp = [self.delegate shouldDisplayTimestampForRowAtIndexPath:indexPath];
    }
    
    static NSString *cellIdentifier = @"PNPMessageTableViewCell";
    
    PNPMessageTableViewCell *messageTableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!messageTableViewCell) {
        messageTableViewCell = [[PNPMessageTableViewCell alloc] initWithMessage:message displaysTimestamp:displayTimestamp reuseIdentifier:cellIdentifier];
        messageTableViewCell.delegate = self;
    }
    
    messageTableViewCell.indexPath = indexPath;
    [messageTableViewCell configureCellWithMessage:message displaysTimestamp:displayTimestamp];
    [messageTableViewCell setBackgroundColor:tableView.backgroundColor];
    
    if ([self.delegate respondsToSelector:@selector(configureCell:atIndexPath:)]) {
        [self.delegate configureCell:messageTableViewCell atIndexPath:indexPath];
    }
    
    return messageTableViewCell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <PNPMessageProtocol> message = [self.dataSource messageForRowAtIndexPath:indexPath];
    return [self calculateCellHeightWithMessage:message atIndexPath:indexPath];
}

#pragma mark - Key-value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (object == self.messageInputView.inputTextView && [keyPath isEqualToString:@"contentSize"]) {
        [self layoutAndAnimateMessageInputTextView:object];
    }
}

@end