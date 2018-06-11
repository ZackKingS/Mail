//
//  TodayViewController.m
//  myToday
//
//  Created by lzy on 2018/6/11.
//  Copyright © 2018 zbc. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <skpsmtpmessage/SKPSMTPMessage.h>
#import "NSData+Base64Additions.h"
#import <SVProgressHUD.h>
@interface TodayViewController () <NCWidgetProviding,SKPSMTPMessageDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTF;

@property (weak, nonatomic) IBOutlet UITextField *contentTF;


@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     [self setupNoti];
}
-(void)setupNoti{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)keyboardWillShow:(NSNotification*)note{
    
   
    
}

-(void)keyboardWillHide:(NSNotification*)note{
    

}


- (IBAction)send:(id)sender {
    
    if (_titleTF.text.length == 0 && _contentTF.text.length == 0 ) {
        return;
    }
    
    SKPSMTPMessage *myMessage = [[SKPSMTPMessage alloc] init];
    myMessage.fromEmail = @"zhengbaich@163.com"; //发送邮箱
    myMessage.toEmail = @"565618435@qq.com"; //收件邮箱
    //    myMessage.bccEmail = @"565618435@qq.com";//抄送
    myMessage.relayHost = @"smtp.163.com";//发送地址host 网易企业邮箱
    myMessage.requiresAuth = YES;
    myMessage.login = @"zhengbaich@163.com";//发送邮箱的用户名
    myMessage.pass = @"1993422";//发送邮箱的密码
    
    myMessage.wantsSecure = YES;
    myMessage.subject = _titleTF.text;//邮件主题
    myMessage.delegate = self;
    
    //文字
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"text/plain",kSKPSMTPPartContentTypeKey,
                           [NSString stringWithFormat:@"%@",_contentTF.text],kSKPSMTPPartMessageKey,
                           @"100bit",kSKPSMTPPartContentTransferEncodingKey,
                           nil];
    //图片
    
//    NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
//    NSData *imgData = [NSData dataWithContentsOfFile:vcfPath];
//
//    NSString *dataObj = [imgData encodeBase64ForData];
//    NSDictionary *imagePart = [NSDictionary dictionaryWithObjectsAndKeys:
//                               @"image/png;\r\n\tx-unix-mode=0644;\r\n\tname=\"backIcon.png\"",kSKPSMTPPartContentTypeKey,
//                               @"attachment;\r\n\tfilename=\"backIcon.png\"",kSKPSMTPPartContentDispositionKey,
//                               dataObj,kSKPSMTPPartMessageKey,
//                               @"base64",kSKPSMTPPartContentTransferEncodingKey,
//                               nil];
    
    
//    myMessage.parts = [NSArray arrayWithObjects:param,imagePart,nil];
    
        myMessage.parts = [NSArray arrayWithObjects:param,nil];
    [myMessage send];
//    [SVProgressHUD show];
    
    
}

- (void)messageSent:(SKPSMTPMessage *)message
{
    
    NSLog(@"%@",message);
//    [SVProgressHUD showSuccessWithStatus:@""];
//    [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1];
    _titleTF.text = @"";
    _contentTF.text = @"";
//    [_titleTF resignFirstResponder];
//    [_contentTF resignFirstResponder];
    
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    
    NSLog(@"delegate - error(%ld): %@", (long)[error code], [error localizedDescription]);
    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    [_titleTF resignFirstResponder];
    [_contentTF resignFirstResponder];
    
}

- (void)dismiss:(id)sender {
//    [SVProgressHUD dismiss];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
