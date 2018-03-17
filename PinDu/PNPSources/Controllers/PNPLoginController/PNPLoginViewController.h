//
//  PNPLoginViewController.h
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNPLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *accountField;

- (IBAction)loginAction:(id)sender;

- (IBAction)findPasswdAction:(id)sender;

- (IBAction)registAction:(id)sender;

@end
