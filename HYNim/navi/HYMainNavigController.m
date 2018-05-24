
//
//  HYMainNavigController.m
//  HYNim
//
//  Created by wangJS on 2018/5/24.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import "HYMainNavigController.h"

@interface HYMainNavigController ()

@end

@implementation HYMainNavigController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"DDA0DD"];
    //系统导航栏背景颜色
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"40E0D0"];
    //返回按钮颜色
//    self.navigationBar.tintColor = [UIColor colorWithHexString:@"F08080"];
    self.navigationBar.tintColor = [UIColor whiteColor];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item{

    //修改系统导航栏返回按钮文本
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    item.backBarButtonItem = back;

    //系统导航栏返回按钮是否显示
    return YES;

}

@end
