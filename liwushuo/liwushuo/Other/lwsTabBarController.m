//
//  lwsTabBarController.m
//  liwushuo
//
//  Created by BO on 17/3/29.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "lwsTabBarController.h"
#import "NavigationController.h"
#import "liwsViewController.h"
#import "HotViewController.h"
#import "MeViewController.h"
#import "SortViewController.h"
@interface lwsTabBarController ()

@end

@implementation lwsTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    liwsViewController * liwushuo = [[liwsViewController alloc]init];
    HotViewController  * hot      = [[HotViewController alloc]init];
    MeViewController   * me       = [[MeViewController alloc]init];
    SortViewController * sort     = [[SortViewController alloc]init];
    [self setting:liwushuo andNormaImage:@"tabbar_home" andSelectedImage:@"tabbar_home_selected" andTitle:@"礼物说"];
    [self setting:hot andNormaImage:@"tabbar_gift" andSelectedImage:@"tabbar_gift_selected" andTitle:@"热卖"];
    [self setting:sort andNormaImage:@"tabbar_category" andSelectedImage:@"tabbar_category_selected" andTitle:@"分类"];
    [self setting:me andNormaImage:@"tabbar_me" andSelectedImage:@"tabbar_me_selected" andTitle:@"我的"];

}

+(void)initialize{
    //统一设置所有tabBarItem的属性 选项按钮
    UITabBarItem *tabBarItem=[UITabBarItem appearance];
    //设置未选中时 标题的字号 ，颜色
    NSMutableDictionary *nordic=@{}.mutableCopy;//创建可变字典
    nordic[NSFontAttributeName]=[UIFont systemFontOfSize:11.0];//修改字体字号
    nordic[NSForegroundColorAttributeName] = [UIColor colorWithRed:54/255.0 green:53/255.0 blue:53/255.0 alpha:1];//设置文字颜色
    [tabBarItem setTitleTextAttributes:nordic forState:UIControlStateNormal];
    //设置选中时 标题的字号，颜色  设计图片大小范围为33 -37 镂空图 正方形
    NSMutableDictionary *seldic = @{}.mutableCopy;//创建可变字典
    seldic[NSFontAttributeName] = [UIFont systemFontOfSize:11.0];//修改字体字号
    seldic[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.94 green:0.27 blue:0.19 alpha:1];//设置文字颜色
    [tabBarItem setTitleTextAttributes:seldic forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置子视图控制器带导航
-(void)setting:(UIViewController *)child andNormaImage:(NSString *)normalDayImage andSelectedImage:(NSString *)selectedImage  andTitle:(NSString *)title
{
    NavigationController * nav = [[NavigationController alloc]initWithRootViewController:child];
//    nav.title = title;
    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0]];
    [child.tabBarItem setImage:[UIImage imageNamed:normalDayImage]];
    
    [child.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    
    [child.tabBarItem setTitle:title];
    child.tabBarItem.imageInsets = UIEdgeInsetsMake(-4, 0, 4, 0);
    
    [self addChildViewController:nav];
    
}


@end
