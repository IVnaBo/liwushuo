//
//  HotViewController.m
//  liwushuo
//
//  Created by BO on 17/3/29.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "HotViewController.h"
#import "HotCollectionViewCell.h"
#import "Hot_model.h"
static NSString * HotIdentify = @"HotIdentify";
@interface HotViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** colV */
@property (strong,nonatomic)UICollectionView * collectionV;
/** data */
@property (strong,nonatomic)NSMutableArray   * dataArr;

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self HttpRequest];
    self.navigationItem.title = @"礼物榜";
    [self.view addSubview:self.collectionV];
    
    // Do any additional setup after loading the view.
}
- (void)HttpRequest
{
    [NewsHttpReq get:@"http://api.liwushuo.com/v2/items?gender=1&generation=2&limit=50&offset=0" parm:nil sucess:^(id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSDictionary * data = dic[@"data"];
        NSArray      * items = data[@"items"];
        for (NSDictionary * obj in items) {
            NSDictionary * dataDic = obj[@"data"];
            Hot_model * model = [[Hot_model alloc]initwithDic:dataDic];
            [self.dataArr addObject:model];
        }
        [self.collectionV reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:HotIdentify forIndexPath:indexPath];
    Hot_model * model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((iPhone_W - 30)/2.0, (iPhone_W - 30)/2.0 + 100);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//设置内容的内边距
        layout.minimumInteritemSpacing = 5;//设置每个cell之间的最小间距
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, iPhone_W, iphone_H ) collectionViewLayout:layout];
        _collectionV.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [_collectionV registerClass:[HotCollectionViewCell class] forCellWithReuseIdentifier:HotIdentify];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
    }
    return _collectionV;
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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
