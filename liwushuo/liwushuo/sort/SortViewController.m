//
//  SortViewController.m
//  liwushuo
//
//  Created by BO on 17/3/29.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "SortViewController.h"
/**单品 */
#import "simpleController.h"
/**攻略 */
#import "strategyController.h"
#define TitlesViewH 35
#define TitlesViewY 64
@interface SortViewController ()
<UIScrollViewDelegate>
/**
 标签栏底部红色的指示器
 */
@property (nonatomic,strong)UIView * indicatorView;
/**
 当前选中的按钮
 */
@property (nonatomic,strong)UIButton * selectButton;
/**
 顶部的所有标签
 */
@property (nonatomic,strong)UIView * titleView;
/**
 底部的所有标签
 */
@property (nonatomic,strong)UIScrollView * contentView;
/**搜索 */
@property (nonatomic,strong)UITextField * searchTxt;

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupChildView];
    [self setupTitlesView];
    [self setupContentView];
    [self setupNav];

    
    
    
  /**
   
   {
   "code": 200,
   "data": {
   "hot_words": [
   "情侣",
   "生日",
   "项链",
   "手机壳",
   "杯子",
   "钱包",
   "手表",
   "双肩包"
   ],
   "placeholder": "选份走心好礼送给Ta"
   },
   "message": "OK"
   }
   
   */
    
    
    // Do any additional setup after loading the view.
}
//初始化子控制器
- (void) setupChildView
{
    /**攻略 */
    strategyController* handP = [[strategyController alloc]init];
    [self addChildViewController:handP];
    /**单品 */
    simpleController * girl = [[simpleController alloc]init];
    [self addChildViewController:girl];
    
}
//点击标签导航栏事件
- (void)tilteClick:(UIButton *)button
{
    //修改按钮状态
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

-(void)setupNav
{
        UIImageView *searchBar = [[UIImageView alloc]initWithFrame:CGRectMake(10,105,iPhone_W-20, 30)];
        searchBar.image = [UIImage imageNamed:@"白色搜索框"];
        searchBar.alpha = 0.9f;
        UIImageView *search = [[UIImageView alloc]initWithFrame:CGRectMake(10, (30-25)/2+2, 25, 25)];
        search.image = [UIImage imageNamed:@"黑色搜索icon"];
        [searchBar addSubview:search];
        UILabel *guanggao = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(search.frame)+10, 0, 180, 30)];
        guanggao.text = @"选份走心好礼送给Ta";
        guanggao.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        guanggao.font = [UIFont systemFontOfSize:14.0f];
        guanggao.textAlignment = NSTextAlignmentLeft;
        [searchBar addSubview:guanggao];
    [self.view addSubview:searchBar];
    
}
//设置顶部标签栏
- (void)setupTitlesView
{
    UIView * titlesView = [[UIView alloc]init];
    //三种设置透明度的方法
    //    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = TitlesViewH;
    titlesView.y = TitlesViewY;
    
    [self.view addSubview:titlesView];
    //底部的红色指示器
    UIView * indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    
    self.indicatorView = indicatorView;
    //内部的子标签
    NSArray * titles = @[@"攻略",@"单品"];
    CGFloat width = 60;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0 ; i<titles.count; i++) {
        UIButton * button = [[UIButton alloc]init];
        button.tag = i;
        button.height =height;
        button.width = width;
        button.x = self.view.centerX - 60 - (-i)*65;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //        [button layoutIfNeeded];//强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(tilteClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了一个按钮
        if (i == 0) {
            
            button.enabled = NO;
            self.selectButton = button;
            //让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    self.titleView =titlesView;
    [titlesView addSubview:indicatorView];
}
//设置底部的scrollView
- (void)setupContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * contenView = [[UIScrollView alloc]init];
    contenView.frame = self.view.bounds;
    contenView.delegate = self;
    contenView.pagingEnabled = YES;
    [self.view insertSubview:contenView atIndex:0];
    contenView.contentSize = CGSizeMake(contenView.width * self.childViewControllers.count, 0);
    self.contentView = contenView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contenView];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController * vc = self.childViewControllers[index];
    
    if (vc.view.superview) {//判断一个view 是否被加载过    如果被加载过，它的superview就不会是nil 就不需要重新添加
        return ;
    }
    
    
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器的y值为20 默认的
    vc.view.height = scrollView.height;//设置控制器view的height值为整个屏幕高度（默认是比屏幕少20）
    
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self tilteClick:self.titleView.subviews[index]];
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

@end
