//
//  FundTableViewController.m
//  liwushuo
//
//  Created by BO on 17/4/7.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "FundTableViewController.h"
#import "CommonViewCell.h"
#import "select_M.h"
#import "DetailWebViewController.h"
CGFloat const TitlesViewH = 35;
//精华顶部标题的Y
CGFloat const TitlesViewY = 64;
static NSString * const TopicCellId = @"topic";
@interface FundTableViewController ()
/** 选择数据源 */
@property (strong,nonatomic)NSMutableArray * selectArr;

@end

@implementation FundTableViewController

-(NSString *)type
{
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonViewCell" bundle:nil] forCellReuseIdentifier:TopicCellId];
    [self setupTableView];
    [self getSelectionData];
    
}
- (void)setupTableView
{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    //    CGFloat bottom = 49;
    CGFloat top = TitlesViewY + TitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;//取消分割线
    self.tableView.backgroundColor = [UIColor clearColor];
}
/** 获取表格数据源.. */
-(void)getSelectionData
{
    
    [NewsHttpReq get:self.type parm:nil sucess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSDictionary * data = dic[@"data"];
        NSArray      * items = data[@"items"];
        self.selectArr = [select_M  mj_objectArrayWithKeyValuesArray:items];
//        NSLog(@"------>>>调用了<<<<<<-----");
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.selectArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellId forIndexPath:indexPath];
    
    cell.select_model  = self.selectArr[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  170 + 38 *(iPhone_W - 20)/69;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    select_M * model = self.selectArr[indexPath.row];
    NSString * weburlStr = model.url;
    DetailWebViewController * webViewController = [DetailWebViewController new];
    webViewController.weburl = weburlStr;
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - get 

- (NSMutableArray *)selectArr
{
    if (!_selectArr ) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

@end
