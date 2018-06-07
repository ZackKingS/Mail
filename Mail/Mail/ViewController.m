//
//  ViewController.m
//  Mail
//
//  Created by lzy on 2018/6/7.
//  Copyright © 2018 zbc. All rights reserved.
//


#import "ViewController.h"
#import <skpsmtpmessage/SKPSMTPMessage.h>
@interface ViewController ()<SKPSMTPMessageDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SKPSMTPMessage *myMessage = [[SKPSMTPMessage alloc] init];
    myMessage.fromEmail = @"zhengbaich@163.com"; //发送邮箱
    myMessage.toEmail = @"565618435@qq.com"; //收件邮箱
    //    myMessage.bccEmail = @"565618435@qq.com";//抄送
    
    myMessage.relayHost = @"smtp.163.com";//发送地址host 网易企业邮箱
    myMessage.requiresAuth = YES;
    myMessage.login = @"zhengbaich@163.com";//发送邮箱的用户名
    myMessage.pass = @"1993422";//发送邮箱的密码
    
    myMessage.wantsSecure = YES;
    myMessage.subject = @"yes";//邮件主题
    myMessage.delegate = self;
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,[NSString stringWithFormat:@"%@",@"test"],kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey, nil];
    myMessage.parts = [NSArray arrayWithObjects:param,nil];
    
    [myMessage send];
    
    
}

- (void)messageSent:(SKPSMTPMessage *)message
{
    
    NSLog(@"%@",message);
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    
    
    NSLog(@"delegate - error(%ld): %@", (long)[error code], [error localizedDescription]);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
