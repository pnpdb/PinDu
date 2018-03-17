//
//  NSString+MessageInputView.h
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MessageInputView)

- (NSString *)stringByTrimingWhitespace;

- (NSUInteger)numberOfLines;

@end
