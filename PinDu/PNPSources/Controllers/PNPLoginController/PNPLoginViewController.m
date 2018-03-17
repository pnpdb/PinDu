//
//  PNPLoginViewController.m
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPLoginViewController.h"
#import "PNPRegistViewController.h"
#import "PNPFindPasswdViewController.h"
#import "PNPGetTabController.h"
#import "PNPMessageHelper.h"
#import "PNPNetWorkHelper.h"
#import "NSString+MD5.h"
#import "PNPConnCore.h"
#import "CostomUIKit.h"
#import "PNPConnPool.h"

@interface PNPLoginViewController ()

@end

@implementation PNPLoginViewController

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
    self.title = @"登录";
    [_loginButton setEnabled:NO];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setBackBarButtonItem:nil];
    [self.navigationController setNavigationBarHidden:NO];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tap];
    
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
                                               object:_passwordField];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification
                                                  object:_accountField];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification
                                                  object:_passwordField];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoginNotification" object:nil];
}

-(void)textFieldChanged:(UITextField*)textField
{
//    if(_accountField.text.length > 0 && _passwordField.text.length >0){
//        [_loginButton setEnabled:YES];
//    }
    if(_accountField.text.length > 0){
        [_loginButton setEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击任意背景返回键盘
- (void)tapGesture
{
    [self.view endEditing:YES];
}

- (IBAction)loginAction:(id)sender
{
//    if(![PNPNetWorkHelper isNetworkEnabled]){
//        [CostomUIKit hidmpb];
//        [CostomUIKit mbpSuccess:@"网络连接不可用"];
//        return ;
//    }
    [_accountField resignFirstResponder];
    [_passwordField resignFirstResponder];
    
    [CostomUIKit showPrograss];
    
    NSData *data = [PNPMessageHelper getMessageData:[self getMessageWithUser:_accountField.text andPasswd:_passwordField.text andCaption:@"Server"]];
    
    PNPConnCore *core = [[PNPConnCore alloc] initWithHost:KEY_SERVER_HOST andPort:8200];
    [core writeData:data];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"LoginNotification" object:nil];
}

- (void) updateUI:(NSNotification*) notification
{
    NSLog(@"--------------updateUI-----------------");
    NSDictionary *dictionary = [notification object];
    
//    NSLog(@"%@", dictionary);

    if([[[dictionary objectForKey:@"Command"] objectForKey:@"Caption"] isEqualToString:@"Server"]){
        if([[[dictionary objectForKey:@"Command"] objectForKey:@"State"] intValue]== 0){
            NSLog(@"----------------------登录Server成功---------------");
            [self goMain];
        }else{
            [PNPConnPool close];
            [CostomUIKit hidmpb];
            [CostomUIKit mbpSuccess:[[dictionary objectForKey:@"Command"] objectForKey:@"Tag"]];
        }
    }else{
        NSLog(@"开始登录Cloud");
        [PNPConnPool close];
        NSDictionary *dd = [PNPMessageHelper getDictionaryData:[[dictionary objectForKey:@"Command"] objectForKey:@"text"]];
        
        NSString *address = [[dd objectForKey:@"Cloud"] objectForKey:@"Ip"];
        UInt16 port = [[[dd objectForKey:@"Cloud"] objectForKey:@"Port"] intValue];
        NSLog(@"cloud ip=%@ and port=%d", address, port);
        
        
        NSData *data = [PNPMessageHelper getMessageData:[self getMessageWithUser:_accountField.text andPasswd:_passwordField.text andCaption:@"Cloud"]];
        
        PNPConnCore *core = [[PNPConnCore alloc] initWithHost:address andPort:port];
        [core writeData:data];
    }
}

//获取登录Command对象
-(PNPCommand*) getMessageWithUser:(NSString*) user andPasswd:(NSString*) password andCaption:(NSString*) caption
{
    PNPCommand *command = [[PNPCommand alloc] init];
    command.Name = @"Login";
    command.Caption = caption;
    command.State = @"5";
    command.Command = [password MD5Hash];
    command.User = user;
    command.From= @"3";
    command.Value=@"11" ;
    command.Block=@"0";
    
    return command;
}

//登录成功进入主界面
-(void) goMain
{
    [CostomUIKit hidmpb];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:[PNPGetTabController getInstance] animated:YES];
}

- (IBAction)findPasswdAction:(id)sender
{
    PNPFindPasswdViewController *controller = [[PNPFindPasswdViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)registAction:(id)sender
{
    PNPRegistViewController *controller = [[PNPRegistViewController alloc] initWithNibName:@"RegistView" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
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
