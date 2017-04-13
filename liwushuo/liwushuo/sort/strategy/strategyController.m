//
//  strategyController.m
//  liwushuo
//
//  Created by BO on 17/4/11.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "strategyController.h"
#import "sortCollectionViewCell.h"
#import "categoryCollectionViewCell.h"
#import "SortModel.h"
#import "styleModel.h"
static NSString * identify = @"sortCollectionCell";
static NSString * categoryIdentify = @"categoryIdentify";
static NSString * headIdentify = @"HeadIdentify";
/**攻略 */
@interface strategyController ()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionV;
/**栏目  */
@property (nonatomic,strong)NSMutableArray * columnArr;
/**品类 */
@property (nonatomic,strong)NSMutableArray * categoryArr;
/**风格 */
@property (nonatomic,strong)NSMutableArray * styleArr;
/**对象 */
@property (nonatomic,strong)NSMutableArray * loverArr;
/**头标题数组 */
@property (nonatomic,strong)NSArray * titlesArr;
@end

@implementation strategyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionV];
    self.titlesArr = @[@"栏目",@"品类",@"风格",@"对象"];
    [self HttpRequestcolumn];
    [self HttpRequestloverStyleAndCategory];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**网络请求栏目 */
-(void)HttpRequestcolumn
{
   
    [NewsHttpReq get:@"http://api.liwushuo.com/v2/columns?limit=11&offset=0" parm:nil sucess:^(id responseObject) {
        NSDictionary * tempDic = (NSDictionary *)responseObject;
        int netCode = [tempDic[@"code"]intValue];
        if (netCode == 200) {
            NSDictionary * dataDic = tempDic[@"data"];
            NSArray * infoArr = dataDic[@"columns"];
//            NSLog(@"%@",infoArr);
            self.columnArr  = [SortModel mj_objectArrayWithKeyValuesArray:infoArr];
            [self.collectionV reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
/**网络请求 对象 品类 风格 */
-(void)HttpRequestloverStyleAndCategory
{
    [NewsHttpReq get:@"http://api.liwushuo.com/v2/channel_groups/all" parm:nil sucess:^(id responseObject) {
        NSDictionary * tempDic = (NSDictionary *)responseObject;
        int netCode = [tempDic[@"code"]intValue];
        if (netCode == 200) {
         NSDictionary * dataDic = tempDic[@"data"];
            NSArray * channel_Arr = dataDic[@"channel_groups"];
            NSDictionary *channel_Dic = channel_Arr.firstObject;
            NSDictionary *channel_Dic_sec = channel_Arr[1];
            NSDictionary *channel_Dic_thr = channel_Arr[2];
            /**字典数组 */
            NSArray * channels = channel_Dic[@"channels"];
            NSArray * channels_sec = channel_Dic_sec[@"channels"];
            NSArray * channels_thr = channel_Dic_thr[@"channels"];
            self.categoryArr = [styleModel mj_objectArrayWithKeyValuesArray:channels];
            self.styleArr = [styleModel mj_objectArrayWithKeyValuesArray:channels_sec];
            self.loverArr = [styleModel mj_objectArrayWithKeyValuesArray:channels_thr];
//            /**表格的头标题 */
//            for (NSDictionary * nameDic in channel_Arr) {//三个字典
////                NSString  * name = nameDic[@"name"];
//                NSArray   * arr  = nameDic[@"channels"];//字典中遍历数组
//                NSArray * catgory_arr = [styleModel mj_objectArrayWithKeyValuesArray:arr];
//                [self.dataArr addObject:catgory_arr];
//            }
//            if (self.dataArr.count > 0 ) {
                 [self.collectionV reloadData];
//            }
//            NSLog(@"%ld",self.dataArr.count);
//
            
        }
    } failure:^(NSError *error) {
        
    }];
}
/**有多少组 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
/**每组中有多少个... */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        NSLog(@"%ld",self.columnArr.count);
        return self.columnArr.count;
    }else if (section == 1){
        return self.categoryArr.count;
    }else if (section == 2){
        return self.styleArr.count;
    }else{
        return  self.loverArr.count;
       
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        sortCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        cell.model = self.columnArr[indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        categoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:categoryIdentify forIndexPath:indexPath];
        cell.model = self.categoryArr[indexPath.row];
        return cell;
    }else if (indexPath.section ==2){
        categoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:categoryIdentify forIndexPath:indexPath];
//        NSArray * infoArr = self.dataArr[1];
//        cell.model = infoArr[indexPath.row];
        cell.model = self.styleArr[indexPath.row];
        return cell;
    }else {
        categoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:categoryIdentify forIndexPath:indexPath];
//        NSArray * infoArr = self.dataArr[2];
//        cell.model = infoArr[indexPath.row];
        cell.model = self.loverArr[indexPath.row];
        return cell;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(iPhone_W/2 - 15 , 160);
    }else{
        //513 282;
       return CGSizeMake((iPhone_W - 30)/2.0, (iPhone_W - 30)/2.0*282/513 );
    }
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *Rview = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *view  = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentify forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(30, 10, 150, 25);
//        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13.0];
        label.text = self.titlesArr[indexPath.row];
        label.textColor = [UIColor colorWithRed:0.55 green:0.5 blue:0.5 alpha:1];
        [view addSubview:label];
        view.backgroundColor = [UIColor whiteColor];
        Rview = view;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
//        Rview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
//        UILabel *label = [[UILabel alloc]init];
//        label.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
//        label.backgroundColor = [UIColor blueColor];
//        label.text = @"这是尾部分区内容";
//        [Rview addSubview:label];
    }
    return Rview;
}
#pragma mark - get
-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//设置内容的内边距
        layout.minimumInteritemSpacing = 5;//设置每个cell之间的最小间距
        
        /**底部标签 高度 44 顶部 切换按钮高度 137 */
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 137, iPhone_W, iphone_H-137-44 ) collectionViewLayout:layout];
        _collectionV.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        /**注册不同的cell 0 */
        [_collectionV registerClass:[sortCollectionViewCell class] forCellWithReuseIdentifier:identify];
        /**1 */
        [_collectionV registerClass:[categoryCollectionViewCell class] forCellWithReuseIdentifier:categoryIdentify];
        /**注册头视图 */
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headIdentify];
        [layout setHeaderReferenceSize:CGSizeMake(iPhone_W, 45)];
        
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
    }
    return _collectionV;
}
-(NSMutableArray *)columnArr
{
    if (!_columnArr) {
        _columnArr = [NSMutableArray array];
    }
    return _columnArr;
}
-(NSMutableArray *)categoryArr
{
    if (!_categoryArr) {
        _categoryArr = [NSMutableArray array];
    }
    return _categoryArr;
}
-(NSMutableArray *)styleArr
{
    if (!_styleArr) {
        _styleArr = [NSMutableArray array];
    }
    return _styleArr;
}
-(NSMutableArray *)loverArr
{
    if (!_loverArr) {
        _loverArr = [NSMutableArray array];
    }
    return _loverArr;
}



@end
