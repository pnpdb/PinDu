//
//  PNPAudioHelper.h
//  品度
//
//  Created by lianhai on 14-9-17.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PNPStartRecorderCompletion)();
typedef void(^PNPStopRecorderCompletion)();
typedef void(^PNPPauseRecorderCompletion)();
typedef void(^PNPResumeRecorderCompletion)();
typedef void(^PNPCancellRecorderDeleteFileCompletion)();
typedef void(^PNPRecordProgress)(float progress);
typedef void(^PNPPeakPowerForChannel)(float peakPowerForChannel);

@interface PNPAudioRecorderHelper : NSObject

@property (nonatomic, copy) PNPStopRecorderCompletion maxTimeStopRecorderCompletion;
@property (nonatomic, copy) PNPRecordProgress recordProgress;
@property (nonatomic, copy) PNPPeakPowerForChannel peakPowerForChannel;
@property (nonatomic, copy, readonly) NSString *recordPath;
@property (nonatomic, copy) NSString *recordDuration;
@property (nonatomic) float maxRecordTime; // 默认 60秒为最大
@property (nonatomic, readonly) NSTimeInterval currentTimeInterval;

- (void)startRecordingWithPath:(NSString *)path StartRecorderCompletion:(PNPStartRecorderCompletion)startRecorderCompletion;

- (void)pauseRecordingWithPauseRecorderCompletion:(PNPPauseRecorderCompletion)pauseRecorderCompletion;

- (void)resumeRecordingWithResumeRecorderCompletion:(PNPResumeRecorderCompletion)resumeRecorderCompletion;

- (void)stopRecordingWithStopRecorderCompletion:(PNPStopRecorderCompletion)stopRecorderCompletion;

- (void)cancelledDeleteWithCompletion:(PNPCancellRecorderDeleteFileCompletion)cancelledDeleteCompletion;

@end
