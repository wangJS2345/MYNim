

//
//  HYSessionViewController.m
//  HYNim
//
//  Created by wangJS on 2018/5/24.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import "HYSessionViewController.h"

@interface HYSessionViewController ()<NIMSystemNotificationManagerDelegate>
@property (nonatomic,strong)    HYCustomNotifiSender *notificaionSender;

@end

@implementation HYSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"enter session, id = %@",self.session.sessionId);

    [self seuUpNavigBar];
    _notificaionSender = [[HYCustomNotifiSender alloc] init];
    //需要在导航条上显示“正在输入”
    BOOL disableCommandTyping = self.disableCommandTyping || (self.session.sessionType == NIMSessionTypeP2P &&[[NIMSDK sharedSDK].userManager isUserInBlackList:self.session.sessionId]);
    //需要在导航条上显示在线状态
    if (!disableCommandTyping) {
//        _titleTimer = [[NTESTimerHolder alloc] init];
        [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    }
    
    //删除最近会话列表中有人@你的标记
//    [NTESSessionUtil removeRecentSessionMark:self.session type:NTESRecentSessionMarkTypeAt];
    
    //不显示用户名
//    self.displayUserNameInCell = NO;
}

- (void)dealloc
{
    [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NIMSDK sharedSDK].mediaManager stopRecord];
    [[NIMSDK sharedSDK].mediaManager stopPlay];
}

#pragma mark - UI设置
//自定义导航栏
- (void)seuUpNavigBar {
    UIButton *chatObject = [UIButton buttonWithType:UIButtonTypeCustom];
    [chatObject addTarget:self action:@selector(chatObjectItemCard:) forControlEvents:UIControlEventTouchUpInside];
    [chatObject setTitle:@"好友" forState:UIControlStateNormal];

//    [enterTeamCard setImage:[UIImage imageNamed:@"icon_session_info_normal"] forState:UIControlStateNormal];
//    [enterTeamCard setImage:[UIImage imageNamed:@"icon_session_info_pressed"] forState:UIControlStateHighlighted];
    [chatObject sizeToFit];
    UIBarButtonItem *chatObjectItem = [[UIBarButtonItem alloc] initWithCustomView:chatObject];
    self.navigationItem.rightBarButtonItem = chatObjectItem;

}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UI操作
- (void)chatObjectItemCard:(UIButton *)sender {
    NSLog(@"聊天信息对方信息：%@",self.session);
}
#pragma mark - NIMSystemNotificationManagerDelegate 聊天消息通知
- (void)onReceiveCustomSystemNotification:(NIMCustomSystemNotification *)notification {
    if (!notification.sendToOnlineUsersOnly) {
        return;
    }
    NSData *data = [[notification content] dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:nil];
        if ([dict jsonInteger:NTESNotifyID] == NTESCommandTyping && self.session.sessionType == NIMSessionTypeP2P && [notification.sender isEqualToString:self.session.sessionId])
        {
            [self refreshSessionTitle:@"正在输入..."];
//            [_titleTimer startTimer:5
//                           delegate:self
//                            repeats:NO];
        }
    }
}

@end
