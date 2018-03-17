//
//  PNPRegistViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-25.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPRegistViewController.h"
#import "PNPMessageHelper.h"
#import "PNPGetTabController.h"
#import "NSString+MD5.h"
#import "CostomUIKit.h"
#import "PNPCommand.h"
#import "PNPConnCore.h"
#import "PNPConnPool.h"

@interface PNPRegistViewController ()

@end

@implementation PNPRegistViewController

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
    self.title = @"注册";
    [_registButton setEnabled:NO];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:_accountField];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:_passwdField];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:_rePasswdField];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification
                                                  object:_accountField];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification
                                                  object:_passwdField];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification
                                                  object:_rePasswdField];
}

-(void)textFieldChanged:(UITextField*)textField
{
    if(_accountField.text.length > 0 && _passwdField.text.length >0 && _rePasswdField.text.length > 0){
        [_registButton setEnabled:YES];
    }
}

#pragma mark - 点击任意背景返回键盘
- (void)tapGesture
{
    [self.view endEditing:YES];
}


- (IBAction)registAction:(id)sender
{
    if(![_passwdField.text isEqualToString:_rePasswdField.text])
    {
        [CostomUIKit mbpSuccess:@"两次密码不一致"];
    }else{
        [CostomUIKit showPrograss];
        PNPCommand *command = [[PNPCommand alloc] init];
        command.Caption = @"Reg";
        command.Command = _accountField.text;
        command.User = [_passwdField.text MD5Hash];
        command.State = @"5";
        command.From = @"3";
        command.Value  =@"1";
        command.Name = @"Users";
        NSData *data = [PNPMessageHelper getMessageData:command];
        PNPConnCore *core = [[PNPConnCore alloc] initWithHost:KEY_SERVER_HOST andPort:8200];
        [core writeData:data];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"RegistNotification" object:nil];
    }
}

- (void) updateUI:(NSNotification*) notification
{
    
    NSDictionary *dictionary = [notification object];
    if([[[dictionary objectForKey:@"Command"] objectForKey:@"State"] intValue] == 0){
        NSLog(@"updateUI---注册成功");
        [CostomUIKit hidmpb];
        [CostomUIKit mbpSuccess:@"注册成功"];
        [self.navigationController pushViewController:[PNPGetTabController getInstance] animated:YES];
    }else{
        [PNPConnPool close];
        [CostomUIKit hidmpb];
        [CostomUIKit mbpSuccess:[[dictionary objectForKey:@"Command"] objectForKey:@"Tag"]];
    }
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
