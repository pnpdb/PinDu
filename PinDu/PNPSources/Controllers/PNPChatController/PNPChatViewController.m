//
//  PNPChatViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPChatViewController.h"

#import "PNPDisplayTextViewController.h"
#import "PNPDisplayMediaViewController.h"
#import "PNPDisplayLocationViewController.h"

#import "PNPContactInfoViewController.h"

#import "PNPAudioPlayerHelper.h"

@interface PNPChatViewController ()<PNPAudioPlayerHelperDelegate>

@property (nonatomic, strong) NSArray *emotionManagers;

@property (nonatomic, strong) PNPMessageTableViewCell *currentSelectedCell;

@end

@implementation PNPChatViewController

- (PNPMessage *)getTextMessageWithBubbleMessageType:(PNPBubbleMessageType)bubbleMessageType {
    PNPMessage *textMessage = [[PNPMessage alloc] initWithText:@"北京市海淀区中关村190号码，18618331097，今天天气还不错，要不要出去走走，品度－－pnpdb.com。每次我想看到你我们却更有距离，是不是都用错了言语，我只是怕你会忘记，有人永远爱着你。" sender:@"华仔" timestamp:[NSDate distantPast]];
    textMessage.avator = [UIImage imageNamed:@"avator"];
    textMessage.avatorUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    textMessage.bubbleMessageType = bubbleMessageType;
    
    return textMessage;
}

- (PNPMessage *)getPhotoMessageWithBubbleMessageType:(PNPBubbleMessageType)bubbleMessageType {
    PNPMessage *photoMessage = [[PNPMessage alloc] initWithPhoto:[UIImage imageNamed:@"placeholderImage"] thumbnailUrl:@"http://d.hiphotos.baidu.com/image/pic/item/30adcbef76094b361721961da1cc7cd98c109d8b.jpg" originPhotoUrl:nil sender:@"Jack" timestamp:[NSDate date]];
    photoMessage.avator = [UIImage imageNamed:@"avator"];
    photoMessage.avatorUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    photoMessage.bubbleMessageType = bubbleMessageType;
    
    return photoMessage;
}

- (PNPMessage *)getVideoMessageWithBubbleMessageType:(PNPBubbleMessageType)bubbleMessageType {
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"IMG_1555.MOV" ofType:@""];
    PNPMessage *videoMessage = [[PNPMessage alloc] initWithVideoConverPhoto:[PNPMessageVideoConverPhotoFactory videoConverPhotoWithVideoPath:videoPath] videoPath:videoPath videoUrl:nil sender:@"Jayson" timestamp:[NSDate date]];
    videoMessage.avator = [UIImage imageNamed:@"avator"];
    videoMessage.avatorUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    videoMessage.bubbleMessageType = bubbleMessageType;
    
    return videoMessage;
}

- (PNPMessage *)getVoiceMessageWithBubbleMessageType:(PNPBubbleMessageType)bubbleMessageType {
    PNPMessage *voiceMessage = [[PNPMessage alloc] initWithVoicePath:nil voiceUrl:nil voiceDuration:@"1" sender:@"Jayson" timestamp:[NSDate date]];
    voiceMessage.avator = [UIImage imageNamed:@"avator"];
    voiceMessage.avatorUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    voiceMessage.bubbleMessageType = bubbleMessageType;
    
    return voiceMessage;
}

- (PNPMessage *)getGIFAnimationMessageWithBubbleMessageType:(PNPBubbleMessageType)bubbleMessageType {
    PNPMessage *emotionMessage = [[PNPMessage alloc] initWithGIFAnimationPath:[[NSBundle mainBundle] pathForResource:@"Demo0.gif" ofType:nil] sender:@"Jayson" timestamp:[NSDate date]];
    emotionMessage.avator = [UIImage imageNamed:@"avator"];
    emotionMessage.avatorUrl = @"http://www.pailixiu.com/jack/JieIcon@2x.png";
    emotionMessage.bubbleMessageType = bubbleMessageType;
    
    return emotionMessage;
}

- (PNPMessage *)getGeolocationsMessageWithBubbleMessageType:(PNPBubbleMessageType)bubbleMessageType {
    PNPMessage *localPositionMessage = [[PNPMessage alloc] initWithLocalPositionPhoto:[UIImage imageNamed:@"Fav_Cell_Loc"] geolocations:@"北京市海淀区西三环北路100号光耀东方大厦" location:[[CLLocation alloc] initWithLatitude:23.110387 longitude:113.399444] sender:@"Jack" timestamp:[NSDate date]];
    localPositionMessage.avator = [UIImage imageNamed:@"avator"];
    localPositionMessage.avatorUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    localPositionMessage.bubbleMessageType = bubbleMessageType;
    
    return localPositionMessage;
}

- (NSMutableArray *)getTestMessages {
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 2; i ++) {
        [messages addObject:[self getPhotoMessageWithBubbleMessageType:(i % 5) ? PNPBubbleMessageTypeSending : PNPBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getVideoMessageWithBubbleMessageType:(i % 6) ? PNPBubbleMessageTypeSending : PNPBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getVoiceMessageWithBubbleMessageType:(i % 4) ? PNPBubbleMessageTypeSending : PNPBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getGIFAnimationMessageWithBubbleMessageType:(i % 2) ? PNPBubbleMessageTypeSending : PNPBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getGeolocationsMessageWithBubbleMessageType:(i % 7) ? PNPBubbleMessageTypeSending : PNPBubbleMessageTypeReceiving]];
        
        [messages addObject:[self getTextMessageWithBubbleMessageType:(i % 2) ? PNPBubbleMessageTypeSending : PNPBubbleMessageTypeReceiving]];
    }
    return messages;
}

- (void)loadDemoDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *messages = [self getTestMessages];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.messages = messages;
            [self.messageTableView reloadData];
            
            [self scrollToBottomAnimated:NO];
        });
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[PNPAudioPlayerHelper shareInstance] stopAudio];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _userName;
    
    // 设置自身用户名
    self.messageSender = @"Jack";
    
    // 添加第三方接入数据
    NSMutableArray *shareMenuItems = [NSMutableArray array];
    NSArray *plugIcons = @[@"sharemore_pic", @"sharemore_video", @"sharemore_location", @"sharemore_friendcard", @"sharemore_myfav", @"sharemore_wxtalk", @"sharemore_videovoip", @"sharemore_voiceinput", @"sharemore_openapi", @"sharemore_openapi", @"avator"];
    NSArray *plugTitle = @[@"照片", @"拍摄", @"位置", @"名片", @"我的收藏", @"实时对讲机", @"视频聊天", @"语音输入", @"大众点评", @"应用", @"曾宪华"];
    for (NSString *plugIcon in plugIcons) {
        PNPShareMenuItem *shareMenuItem = [[PNPShareMenuItem alloc] initWithNormalIconImage:[UIImage imageNamed:plugIcon] title:[plugTitle objectAtIndex:[plugIcons indexOfObject:plugIcon]]];
        
        [shareMenuItems addObject:shareMenuItem];
    }
    
    NSMutableArray *emotionManagers = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++) {
        PNPEmotionManager *emotionManager = [[PNPEmotionManager alloc] init];
        emotionManager.emotionName = [NSString stringWithFormat:@"表情%ld", (long)i];
        NSMutableArray *emotions = [NSMutableArray array];
        for (NSInteger j = 0; j < 32; j ++) {
            PNPEmotion *emotion = [[PNPEmotion alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"section%ld_emotion%ld", (long)i , (long)j % 16];
            emotion.emotionPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Demo%ld.gif", (long)j % 2] ofType:@""];
            emotion.emotionConverPhoto = [UIImage imageNamed:imageName];
            [emotions addObject:emotion];
        }
        emotionManager.emotions = emotions;
        
        [emotionManagers addObject:emotionManager];
    }
    
    self.emotionManagers = emotionManagers;
    [self.emotionManagerView reloadData];
    
    self.shareMenuItems = shareMenuItems;
    [self.shareMenuView reloadData];
    
    [self loadDemoDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.emotionManagers = nil;
    [[PNPAudioPlayerHelper shareInstance] setDelegate:nil];
}

/*
 [self removeMessageAtIndexPath:indexPath];
 [self insertOldMessages:self.messages];
 */

#pragma mark - PNPMessageTableViewCell delegate

- (void)multiMediaMessageDidSelectedOnMessage:(id<PNPMessageProtocol>)message atIndexPath:(NSIndexPath *)indexPath onMessageTableViewCell:(PNPMessageTableViewCell *)messageTableViewCell {
    UIViewController *disPlayViewController;
    switch (message.messageMediaType) {
        case PNPBubbleMessageMediaTypeVideo:
        case PNPBubbleMessageMediaTypePhoto: {
            NSLog(@"message : %@", message.photo);
            NSLog(@"message : %@", message.videoConverPhoto);
            PNPDisplayMediaViewController *messageDisplayTextView = [[PNPDisplayMediaViewController alloc] init];
            messageDisplayTextView.message = message;
            disPlayViewController = messageDisplayTextView;
            break;
        }
            break;
        case PNPBubbleMessageMediaTypeVoice: {
            NSLog(@"message : %@", message.voicePath);
            [[PNPAudioPlayerHelper shareInstance] setDelegate:self];
            if (_currentSelectedCell) {
                [_currentSelectedCell.messageBubbleView.animationVoiceImageView stopAnimating];
            }
            if (_currentSelectedCell == messageTableViewCell) {
                [messageTableViewCell.messageBubbleView.animationVoiceImageView stopAnimating];
                [[PNPAudioPlayerHelper shareInstance] stopAudio];
                self.currentSelectedCell = nil;
            } else {
                self.currentSelectedCell = messageTableViewCell;
                [messageTableViewCell.messageBubbleView.animationVoiceImageView startAnimating];
                [[PNPAudioPlayerHelper shareInstance] managerAudioWithFileName:message.voicePath toPlay:YES];
            }
            break;
        }
        case PNPBubbleMessageMediaTypeGIFAnimation:
            NSLog(@"facePath : %@", message.emotionPath);
            break;
        case PNPBubbleMessageMediaTypeLocalPosition: {
            NSLog(@"facePath : %@", message.localPositionPhoto);
            PNPDisplayLocationViewController *displayLocationViewController = [[PNPDisplayLocationViewController alloc] init];
            displayLocationViewController.message = message;
            disPlayViewController = displayLocationViewController;
            break;
        }
        default:
            break;
    }
    if (disPlayViewController) {
        [self.navigationController pushViewController:disPlayViewController animated:YES];
    }
}

- (void)didDoubleSelectedOnTextMessage:(id<PNPMessageProtocol>)message atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"text : %@", message.text);
    PNPDisplayTextViewController *displayTextViewController = [[PNPDisplayTextViewController alloc] init];
    displayTextViewController.message = message;
    [self.navigationController pushViewController:displayTextViewController animated:YES];
}

- (void)didSelectedAvatorOnMessage:(id<PNPMessageProtocol>)message atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath : %@", indexPath);
    PNPContactInfo *contact = [[PNPContactInfo alloc] init];
    contact.contactName = [message sender];
    contact.contactIntroduction = @"自定义描述，这个需要和业务逻辑挂钩";
//    PNPContactInfoViewController *contactDetailTableViewController = [[PNPContactInfoViewController alloc] initWithContact:contact];
        PNPContactInfoViewController *contactDetailTableViewController = [[PNPContactInfoViewController alloc] init];
    [self.navigationController pushViewController:contactDetailTableViewController animated:YES];
}

- (void)menuDidSelectedAtBubbleMessageMenuSelecteType:(PNPBubbleMessageMenuSelecteType)bubbleMessageMenuSelecteType {
    
}

#pragma mark - PNPAudioPlayerHelper Delegate

- (void)didAudioPlayerStopPlay:(AVAudioPlayer *)audioPlayer {
    if (!_currentSelectedCell) {
        return;
    }
    [_currentSelectedCell.messageBubbleView.animationVoiceImageView stopAnimating];
    self.currentSelectedCell = nil;
}

#pragma mark - PNPEmotionManagerView DataSource

- (NSInteger)numberOfEmotionManagers {
    return self.emotionManagers.count;
}

- (PNPEmotionManager *)emotionManagerForColumn:(NSInteger)column {
    return [self.emotionManagers objectAtIndex:column];
}

- (NSArray *)emotionManagersAtManager {
    return self.emotionManagers;
}

#pragma mark - PNPMessageTableViewController Delegate

- (BOOL)shouldLoadMoreMessagesScrollToTop {
    return YES;
}

- (void)loadMoreMessagesScrollTotop {
    if (!self.loadingMoreMessage) {
        self.loadingMoreMessage = YES;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *messages = [self getTestMessages];
            sleep(2);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self insertOldMessages:messages];
                self.loadingMoreMessage = NO;
            });
        });
    }
}

/**
 *  发送文本消息的回调方法
 *
 *  @param text   目标文本字符串
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date {
    PNPMessage *textMessage = [[PNPMessage alloc] initWithText:text sender:sender timestamp:date];
    textMessage.avator = [UIImage imageNamed:@"avator"];
    textMessage.avatorUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    [self addMessage:textMessage];
    [self finishSendMessageWithBubbleMessageType:PNPBubbleMessageMediaTypeText];
}

/**
 *  发送图片消息的回调方法
 *
 *  @param photo  目标图片对象，后续有可能会换
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendPhoto:(UIImage *)photo fromSender:(NSString *)sender onDate:(NSDate *)date {
    PNPMessage *photoMessage = [[PNPMessage alloc] initWithPhoto:photo thumbnailUrl:nil originPhotoUrl:nil sender:sender timestamp:date];
    photoMessage.avator = [UIImage imageNamed:@"avator"];
    photoMessage.avatorUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    [self addMessage:photoMessage];
    [self finishSendMessageWithBubbleMessageType:PNPBubbleMessageMediaTypePhoto];
}

/**
 *  发送视频消息的回调方法
 *
 *  @param videoPath 目标视频本地路径
 *  @param sender    发送者的名字
 *  @param date      发送时间
 */
- (void)didSendVideoConverPhoto:(UIImage *)videoConverPhoto videoPath:(NSString *)videoPath fromSender:(NSString *)sender onDate:(NSDate *)date {
    PNPMessage *videoMessage = [[PNPMessage alloc] initWithVideoConverPhoto:videoConverPhoto videoPath:videoPath videoUrl:nil sender:sender timestamp:date];
    videoMessage.avator = [UIImage imageNamed:@"avator"];
    videoMessage.avatorUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    [self addMessage:videoMessage];
    [self finishSendMessageWithBubbleMessageType:PNPBubbleMessageMediaTypeVideo];
}

/**
 *  发送语音消息的回调方法
 *
 *  @param voicePath        目标语音本地路径
 *  @param voiceDuration    目标语音时长
 *  @param sender           发送者的名字
 *  @param date             发送时间
 */
- (void)didSendVoice:(NSString *)voicePath voiceDuration:(NSString *)voiceDuration fromSender:(NSString *)sender onDate:(NSDate *)date {
    PNPMessage *voiceMessage = [[PNPMessage alloc] initWithVoicePath:voicePath voiceUrl:nil voiceDuration:voiceDuration sender:sender timestamp:date];
    voiceMessage.avator = [UIImage imageNamed:@"avator"];
    voiceMessage.avatorUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    [self addMessage:voiceMessage];
    [self finishSendMessageWithBubbleMessageType:PNPBubbleMessageMediaTypeVoice];
}

/**
 *  发送第三方表情消息的回调方法
 *
 *  @param facePath 目标第三方表情的本地路径
 *  @param sender   发送者的名字
 *  @param date     发送时间
 */
- (void)didSendEmotion:(NSString *)emotionPath fromSender:(NSString *)sender onDate:(NSDate *)date {
    PNPMessage *emotionMessage = [[PNPMessage alloc] initWithGIFAnimationPath:emotionPath sender:sender timestamp:date];
    emotionMessage.avator = [UIImage imageNamed:@"avator"];
    emotionMessage.avatorUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    [self addMessage:emotionMessage];
    [self finishSendMessageWithBubbleMessageType:PNPBubbleMessageMediaTypeGIFAnimation];
}

/**
 *  有些网友说需要发送地理位置，这个我暂时放一放
 */
- (void)didSendGeoLocationsPhoto:(UIImage *)geoLocationsPhoto geolocations:(NSString *)geolocations location:(CLLocation *)location fromSender:(NSString *)sender onDate:(NSDate *)date {
    PNPMessage *geoLocationsMessage = [[PNPMessage alloc] initWithLocalPositionPhoto:geoLocationsPhoto geolocations:geolocations location:location sender:sender timestamp:date];
    geoLocationsMessage.avator = [UIImage imageNamed:@"avator"];
    geoLocationsMessage.avatorUrl = @"http://www.pailixiu.com/jack/meIcon@2x.png";
    [self addMessage:geoLocationsMessage];
    [self finishSendMessageWithBubbleMessageType:PNPBubbleMessageMediaTypeLocalPosition];
}

/**
 *  是否显示时间轴Label的回调方法
 *
 *  @param indexPath 目标消息的位置IndexPath
 *
 *  @return 根据indexPath获取消息的Model的对象，从而判断返回YES or NO来控制是否显示时间轴Label
 */
- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2)
        return YES;
    else
        return NO;
}

/**
 *  配置Cell的样式或者字体
 *
 *  @param cell      目标Cell
 *  @param indexPath 目标Cell所在位置IndexPath
 */
- (void)configureCell:(PNPMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

/**
 *  协议回掉是否支持用户手动滚动
 *
 *  @return 返回YES or NO
 */
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling {
    return YES;
}


@end
