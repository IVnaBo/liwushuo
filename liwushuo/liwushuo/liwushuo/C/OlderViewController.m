//
//  OlderViewController.m
//  liwushuo
//
//  Created by BO on 17/4/7.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "OlderViewController.h"

@interface OlderViewController ()

@end

@implementation OlderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)type
{
    return @"http://api.liwushuo.com/v2/channels/6/items_v2?gender=1&generation=2&limit=20&offset=0";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
