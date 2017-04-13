//
//  HandPickViewController.m
//  liwushuo
//
//  Created by BO on 17/3/29.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "HandPickViewController.h"
#import "ADView.h"
#import "giftV.h"
#import "ADModel.h"
#import "gift_M.h"
#import "select_M.h"
#import "column.h"
#import "author.h"
#import "CommonViewCell.h"
#import "DetailWebViewController.h"
#import "SDCycleScrollView.h"

#import "UIImageView+WebCache.h"
static NSString * identify = @"CommonViewCell";

@interface HandPickViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
/** 广告视图模型数组 */
@property (strong,nonatomic)NSMutableArray * BannerArr;
/** 选择数据源 */
@property (strong,nonatomic)NSMutableArray * selectArr;
@property (strong,nonatomic)NSMutableArray * authorArr;
@property (strong,nonatomic)NSMutableArray * columnArr;
/** 分类视图 */
@property (strong,nonatomic)giftV          * sortV;
@property (strong,nonatomic)SDCycleScrollView         * adV;
/** 精选表格 */
@property (strong,nonatomic)UITableView    * selectTabv;


@end

@implementation HandPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getADImgArr];
    [self getSortimgArr];
    [self getSelectionData];
    [self setupUI];
    
   
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI
{
    UIView * headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iPhone_W, 181 + (iPhone_W / 3.0 - 30) * 0.664 * 2 + 35)];
//    _adV = [[ADView alloc]initWithFrame:CGRectMake(0, 0, iPhone_W, 180) isOpenTimer:YES clickBlock:^(NSInteger index) {
////
//    }];
    
     _sortV = [[giftV alloc]initWithFrame:CGRectMake(0, 181, iPhone_W,(iPhone_W / 3.0 - 30) * 0.664 * 2 + 35)];
//    [headV addSubview:self.adV];
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, iPhone_W,180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [headV addSubview:cycleScrollView2];
    [headV addSubview:_sortV];
    self.adV = cycleScrollView2;
    
    //         --- 模拟加载延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
//    })
    
    self.selectTabv.tableHeaderView = headV;
   
    [self.selectTabv registerNib:[UINib nibWithNibName:identify bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CommonViewCell"];
    [self.view addSubview:self.selectTabv];
}
#pragma mark - req
/** 获取滚动视图上的数据源 */
- (void)getADImgArr
{
    [NewsHttpReq get:@"http://api.liwushuo.com/v2/banners?channel=iO" parm:nil sucess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSDictionary *tempDic = dic[@"data"];
        NSArray * infoArr = tempDic[@"banners"];
        self.BannerArr = [ADModel mj_objectArrayWithKeyValuesArray:infoArr];
        NSMutableArray * imgArr = [NSMutableArray array];
        for (ADModel * obj in self.BannerArr) {
            [imgArr addObject:obj.image_url];
        }
//        self.adV.imgArr = imgArr;
        self.adV.imageURLStringsGroup = imgArr;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getSortimgArr
{
    NSMutableArray * giftArr = [NSMutableArray array];
    [NewsHttpReq get:@"http://api.liwushuo.com/v2/secondary_banners?gender=1&generation=2" parm:nil sucess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSDictionary * tempDic = dic[@"data"];
        NSArray      * arr     = tempDic[@"secondary_banners"];
//        NSLog(@"%@",arr);
        for (NSDictionary * infoDic in arr) {
            gift_M * gift = [[gift_M alloc]initwithDic:infoDic];
            [giftArr addObject:gift];
        }
        self.sortV.infoArr = giftArr;
    } failure:^(NSError *error) {
        
    }];
}
/** 获取表格数据源.. */
-(void)getSelectionData
{

    [NewsHttpReq get:@"http://api.liwushuo.com/v2/channels/101/items_v2?ad=2&gender=1&generation=2&limit=20&offset=0" parm:nil sucess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSDictionary * data = dic[@"data"];
        NSArray      * items = data[@"items"];
//        NSLog(@"%@",items);
        self.selectArr = [select_M  mj_objectArrayWithKeyValuesArray:items];

        [self.selectTabv reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
#pragma mark - td
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.select_model = self.selectArr[indexPath.row];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    select_M * model = self.selectArr[indexPath.row];
    NSString * weburlStr = model.url;
    DetailWebViewController * webViewController = [DetailWebViewController new];
    webViewController.weburl = weburlStr;
    [self pushVc:webViewController];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  170 + 38 *(iPhone_W - 20)/69;
}


#pragma mark - get

-(NSMutableArray *)BannerArr
{
    if (!_BannerArr) {
        _BannerArr = [NSMutableArray array];
    }
    return _BannerArr;
}

-(UITableView *)selectTabv
{
    if (!_selectTabv) {
        _selectTabv = [[UITableView alloc]initWithFrame:CGRectMake(0,64, iPhone_W, iphone_H - 64 ) style:UITableViewStylePlain];
        _selectTabv.dataSource = self;
        _selectTabv.delegate   = self;
    }
    return _selectTabv;
}
-(NSMutableArray *)selectArr
{
    if (!_selectArr) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

-(NSMutableArray *)authorArr
{
    if (!_authorArr) {
        _authorArr = [NSMutableArray array];
    }
    return _authorArr;
}
-(NSMutableArray *)columnArr
{
    if (!_columnArr) {
        _columnArr = [NSMutableArray array];
    }
    return _columnArr;
}
@end
