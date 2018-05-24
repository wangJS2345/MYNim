//
//  ViewController.m
//  HYNim
//
//  Created by wangJS on 2018/5/23.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(100, 400, 200, 48);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"20B2AA"]];
//    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginClick {
    return;
//    NSLog(@"XX");
    UIAlertController *alController = [UIAlertController alertControllerWithTitle:@"" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        MainViewController *main = [[MainViewController alloc] init];
//        [self presentViewController:main animated:YES completion:nil];
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        app.window.rootViewController = [[HYMainTabbarController alloc] init];

        
    }];
    [alController addAction:okAction];
    [self presentViewController:alController animated:YES completion:nil];
    
}
- (void)doLogin {
    NSString *username = @"20180523";
    NSString *password = @"12345667";
    [SVProgressHUD show];

    NSString *loginAccount = username;
    NSString *loginToken   = [password tokenByPassword];
    [[[NIMSDK sharedSDK] loginManager] login:loginAccount token:loginToken completion:^(NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (error == nil) {
//            [self loginClick];
            
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.window.rootViewController = [[HYMainTabbarController alloc] init];
            
        }else {
            NSString *toast = [NSString stringWithFormat:@"登录失败 code：%zd",error.code];
            [SVProgressHUD showErrorWithStatus:toast];
        }
    }];
}
@end
