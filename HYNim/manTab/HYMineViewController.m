//
//  HYMineViewController.m
//  HYNim
//
//  Created by wangJS on 2018/5/24.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import "HYMineViewController.h"
#import "NIMCommonTableDelegate.h"
#import "NIMCommonTableData.h"
#import "HYMineTableViewCell.h"

@interface HYMineViewController ()<NIMUserManagerDelegate>
@property (nonatomic,strong) NIMCommonTableDelegate *delegator;

@property (nonatomic,copy  ) NSArray                 *data;

@property (nonatomic,copy  ) NSString                *userId;

@property (nonatomic,strong) NIMUser                 *user;

//信息名片table
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation HYMineViewController

- (instancetype)initWithUserId:(NSString *)userId{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _userId = userId;
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NIMSDK sharedSDK].userManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    self.view.backgroundColor = [UIColor colorWithHexString:@"FFE4E1"];
    [[NIMSDK sharedSDK].userManager addDelegate:self];

    __weak typeof(self) wself = self;
    self.delegator = [[NIMCommonTableDelegate alloc] initWithTableData:^NSArray *{
        return wself.data;
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"0xe3e6ea"];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate   = self.delegator;
    self.tableView.dataSource = self.delegator;
    [self refresh];
}
- (void)setUpNav{
    self.navigationItem.title = @"个人名片";
    if ([self.userId isEqualToString:[[NIMSDK sharedSDK].loginManager currentAccount]]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(onActionEditMyInfo:)];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    }
}
- (void)onActionEditMyInfo:(id)sender{
//    NTESUserInfoSettingViewController *vc = [[NTESUserInfoSettingViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressNavbar:)];
    [self.navigationController.navigationBar addGestureRecognizer:self.longPressGesture];
}
- (void)onLongPressNavbar:(UIGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSString *title = self.user.description;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"个人信息" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar removeGestureRecognizer:self.longPressGesture];
}
- (void)refresh{
    self.user = [[NIMSDK sharedSDK].userManager userInfo:self.userId];
    [self buildData];
    [self.tableView reloadData];
}
#pragma mark - NIMUserManagerDelegate

- (void)onUserInfoChanged:(NIMUser *)user
{
    if ([user.userId isEqualToString:self.userId]) {
        [self refresh];
    }
}

- (void)onFriendChanged:(NIMUser *)user{
    if ([user.userId isEqualToString:self.userId]) {
        [self refresh];
    }
}

- (void)onBlackListChanged{
    [self refresh];
}

- (void)onMuteListChanged
{
    [self refresh];
}
- (void)buildData {
    BOOL isMe          = [self.userId isEqualToString:[NIMSDK sharedSDK].loginManager.currentAccount];
    BOOL isMyFriend    = [[NIMSDK sharedSDK].userManager isMyFriend:self.userId];
    BOOL isInBlackList = [[NIMSDK sharedSDK].userManager isUserInBlackList:self.userId];
    BOOL needNotify    = [[NIMSDK sharedSDK].userManager notifyForNewMsg:self.userId];
    NSArray *data = @[
                      @{
                          HeaderTitle:@"",
                          RowContent :@[
                                  @{
                                      ExtraInfo     : self.userId.length ? self.user.userId : [NSNull null],
                                      CellClass     : @"NTESCardPortraitCell",
                                      RowHeight     : @(100),
                                      },
                                  ],
                          FooterTitle:@""
                          },
                      @{
                          HeaderTitle:@"",
                          RowContent :@[
                                  @{
                                      Title        : @"备注名",
                                      DetailTitle  : self.user.alias.length ? self.user.alias : @"",
                                      CellAction   : @"onActionEditAlias:",
                                      ShowAccessory: @(YES),
                                      Disable      : @(!isMyFriend),
                                      },
                                  @{
                                      Title        : @"生日",
                                      DetailTitle  : self.user.userInfo.birth.length ? self.user.userInfo.birth : @"",
                                      Disable      : @(!self.user.userInfo.birth.length),
                                      },
                                  @{
                                      Title        : @"手机",
                                      DetailTitle  : self.user.userInfo.mobile.length ? self.user.userInfo.mobile : @"",
                                      Disable      : @(!self.user.userInfo.mobile.length),
                                      },
                                  @{
                                      Title        : @"邮箱",
                                      DetailTitle  : self.user.userInfo.email.length ? self.user.userInfo.email : @"",
                                      Disable      : @(!self.user.userInfo.email.length),
                                      },
                                  @{
                                      Title        : @"签名",
                                      DetailTitle  : self.user.userInfo.sign.length ? self.user.userInfo.sign : @"",
                                      Disable      : @(!self.user.userInfo.sign.length),
                                      },
                                  ],
                          FooterTitle:@""
                          },
                      @{
                          HeaderTitle:@"",
                          RowContent :@[
                                  @{
                                      Title        : @"消息提醒",
                                      CellClass    : @"NTESSettingSwitcherCell",
                                      CellAction   : @"onActionNeedNotifyValueChange:",
                                      ExtraInfo    : @(needNotify),
                                      Disable      : @(isMe),
                                      ForbidSelect : @(YES)
                                      },
                                  ],
                          FooterTitle:@""
                          },
                      @{
                          HeaderTitle:@"",
                          RowContent :@[
                                  @{
                                      Title        : @"黑名单",
                                      CellClass    : @"NTESSettingSwitcherCell",
                                      CellAction   : @"onActionBlackListValueChange:",
                                      ExtraInfo    : @(isInBlackList),
                                      Disable      : @(isMe),
                                      ForbidSelect : @(YES)
                                      },
                                  ],
                          FooterTitle:@""
                          },
                      @{
                          HeaderTitle:@"",
                          RowContent :@[
                                  @{
                                      Title        : @"聊天",
                                      CellClass    : @"NTESColorButtonCell",
                                      CellAction   : @"chat",
                                      ExtraInfo    : @(ColorButtonCellStyleBlue),
                                      Disable      : @(isMe),
                                      RowHeight    : @(60),
                                      ForbidSelect : @(YES),
                                      SepLeftEdge  : @(self.view.width),
                                      },
                                  @{
                                      Title        : @"删除好友",
                                      CellClass    : @"NTESColorButtonCell",
                                      CellAction   : @"deleteFriend",
                                      ExtraInfo    : @(ColorButtonCellStyleRed),
                                      Disable      : @(!isMyFriend || isMe),
                                      RowHeight    : @(60),
                                      ForbidSelect : @(YES),
                                      SepLeftEdge  : @(self.view.width),
                                      },
                                  @{
                                      Title        : @"添加好友",
                                      CellClass    : @"NTESColorButtonCell",
                                      CellAction   : @"addFriend",
                                      ExtraInfo    : @(ColorButtonCellStyleBlue),
                                      Disable      : @(isMyFriend  || isMe),
                                      RowHeight    : @(60),
                                      ForbidSelect : @(YES),
                                      SepLeftEdge  : @(self.view.width),
                                      },
                                  ],
                          FooterTitle:@"",
                          },
                      ];
    self.data = [NIMCommonTableSection sectionsWithData:data];
}

@end
