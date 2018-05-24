//
//  HYMainTabbarController.m
//  HYNim
//
//  Created by wangJS on 2018/5/24.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import "HYMainTabbarController.h"

@interface HYMainTabbarController ()
@property (nonatomic ,assign) HYMegViewController *messageController;
@property (nonatomic ,assign) HYMineViewController *mineController;
@property (nonatomic ,assign) HYMegListViewController *listController ;
@end

@implementation HYMainTabbarController

/** 类初始化方法 */
+ (void)initialize
{
    /**
     *  设置底部tabbar的主题样式
     */
    UITabBarItem *appearance = [UITabBarItem appearance];
    
    /**
     *  设置 标题的前景色
     */
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"AFAFAF"], NSForegroundColorAttributeName, [UIFont systemFontOfSize:11], NSFontAttributeName,nil]
                              forState:UIControlStateNormal];
    
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"0xf55688"],NSForegroundColorAttributeName, [UIFont systemFontOfSize:11], NSFontAttributeName,nil]
                              forState:UIControlStateSelected];
    

    [appearance setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 添加所有子控制器 */
    [self addAllChildVcs];
    
    self.selectedIndex = 0;
    // tabbar不透明
    self.tabBar.translucent = NO;
    
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

/** 添加所有子控制器 */
-(void)addAllChildVcs{
    
    
    //消息页
    HYMegViewController* messageController = [[HYMegViewController alloc]init];
    _messageController = messageController;
//    [self addOneChildVc:messageController title:@"消息" imageName:nil selectedImageName:nil];
    
    //我的页
    HYMineViewController *mineController = [[HYMineViewController alloc] init];
    _mineController = mineController ;
//    [self addOneChildVc:mineController title:@"我的" imageName:nil selectedImageName:nil];
    
    //消息列表页
    HYMegListViewController *listController = [[HYMegListViewController alloc] init];
    _listController = listController;
    [self addOneChildVc:listController title:@"信息记录" imageName:nil selectedImageName:nil];
}
/** 增加一个子控制器并配置 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    /**
     *  设置标题
     */
    childVc.title = title;
    /**
     *  设置未选中图标
     */
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    [childVc.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    /**
     *  设置选中图标
     */
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    /**
     *  设置图片渲染为原始类型
     */
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    //设置图片位置
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-4, 0, 4, 0);
    
    /**
     *  添加导航控制器
     */
//    FZNavigationController *nav = [[FZNavigationController alloc] initWithRootViewController:childVc];
//
//    [self addChildViewController:nav];
    HYMainNavigController *nav = [[HYMainNavigController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
