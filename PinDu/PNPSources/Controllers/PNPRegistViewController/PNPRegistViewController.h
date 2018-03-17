//
//  PNPRegistViewController.h
//  PinDu
//
//  Created by lianhai on 14-9-25.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNPRegistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *registButton;

@property (weak, nonatomic) IBOutlet UITextField *rePasswdField;

@property (weak, nonatomic) IBOutlet UITextField *passwdField;

@property (weak, nonatomic) IBOutlet UITextField *accountField;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

- (IBAction)registAction:(id)sender;


@end
