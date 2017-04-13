//
//  ADView.m
//  AdView
//
//  Created by BO on 17/3/29.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import "ADView.h"
#import "UIImageView+WebCache.h"
//#im
typedef enum : NSUInteger {
    ScrollViewDirectionRight,           /** 向右滚动*/
    ScrollViewDirectionLeft,            /** 向左滚动*/
}ScrollViewDirection;
@interface ADView ()<UIScrollViewDelegate>
/** 是否开启定时器 */
@property (nonatomic,assign)BOOL isRunloop;
/** 间隔时间 */
@property (nonatomic,assign)NSTimeInterval dur;
@property (nonatomic,strong)UIColor *color_pageControl;
@property (nonatomic,strong)UIColor *color_currentPageControl;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *dataArry;
@property (nonatomic,assign)NSInteger currentImageIndex;
/** 记录上一次的偏移量。。好进行比较。。。 */
@property (nonatomic,assign)CGFloat lastContentOffset;
@property (nonatomic,assign)ScrollViewDirection scrollDirection;
@property (nonatomic,strong)NSMutableArray *imageViews;
@property (nonatomic,assign)NSInteger imageCount;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIPageControl *pageControl;

@end
@implementation ADView
@synthesize color_currentPageControl = _color_currentPageControl ,
color_pageControl = _color_pageControl ;

-(instancetype)initWithFrame:(CGRect)frame isOpenTimer:(BOOL)openTimer clickBlock:(adViewClick)Block
{
    if (self = [super initWithFrame:frame]) {
       
        /** 没赋值的话 默认时间间隔 就是3 */
        self.dur = 3;
        self.isRunloop = openTimer;
        self.click = Block;
        [self loadBaseView];
    }
    return self;
}

-(void)addImg:(NSArray *)tempArr{
    for (NSString * img in tempArr) {
        /** 判断是本地图片还是远程图片 */
        if ([img hasPrefix:@"http://"]||[img hasPrefix:@"https://"])
        {
          UIImage * tempImg =  [self imageWithStr:img];
            
            if (tempImg) {
                [self.dataArry addObject:tempImg];
            }
        }else{
            UIImageView * imgv = [[UIImageView alloc]init];
            [imgv setImage:[UIImage imageNamed:img]];
            /** 不为空才添加到数组中、 */
            if (imgv.image) {
                [self.dataArry addObject:imgv.image];
            }

        }
    }
}

-(UIImage *)imageWithStr:(NSString *)imgurlstr
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgurlstr]];
    UIImage * img = [UIImage imageWithData:data];
    return img;
    
}
- (void)loadBaseView
{
    
    self.currentImageIndex =0;
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    
    
    for (int i = 0; i<3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        
        if (i == 0 && self.dataArry!=nil && self.dataArry.count > 1) {
            /** 左边显示的图片是数组中的最后一个 */
            imageView.image = self.dataArry[self.dataArry.count - 1];//左边
        }
        if (i == 1 && self.dataArry!=nil && self.dataArry.count > 0) {
            imageView.image = self.dataArry[0];//中间
        }
        if (i == 2 && self.dataArry !=nil && self.dataArry.count > 1) {
            imageView.image = self.dataArry[1];//右边
        }
        [self.imageViews addObject:imageView];
        [self.scrollView addSubview:imageView];
        
    }
    /** 添加手势 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.scrollView addGestureRecognizer:tap];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    
}

#pragma mark -
#pragma mark - set
- (void)setImageCount:(NSInteger)imageCount
{
    _imageCount = imageCount;
    if (_imageCount < 1) {
        self.scrollView.scrollEnabled = NO;
        return;
    }
    self.scrollView.scrollEnabled = YES;
    self.pageControl.numberOfPages = imageCount ;
    CGSize size = [self.pageControl sizeForNumberOfPages:imageCount];
    self.pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    self.pageControl.center = CGPointMake(self.frame.size.width - size.width - 0. , self.frame.size.height - 20.) ;
    self.pageControl.currentPage = 0;
}
- (void)setIsRunloop:(BOOL)isRunloop
{
    _isRunloop = isRunloop;
    if (isRunloop) {
        [self createTimer];
    }
}
- (void)setColor_pageControl:(UIColor *)color_pageControl
{
    _color_pageControl = color_pageControl ;
    
    self.pageControl.pageIndicatorTintColor = _color_pageControl ;
}
-(void)setDur:(NSTimeInterval)dur
{
    _dur = dur;
    
}
-(void)setImgArr:(NSArray *)imgArr
{
    _imgArr = imgArr;
    self.imageCount = imgArr ? imgArr.count : 0;
    for (NSString * img in imgArr) {
        /** 判断是本地图片还是远程图片 */
        if ([img hasPrefix:@"http://"]||[img hasPrefix:@"https://"])
        {
            UIImage * tempImg =  [self imageWithStr:img];
            
            if (tempImg) {
                [self.dataArry addObject:tempImg];
            }
        }else{
            UIImageView * imgv = [[UIImageView alloc]init];
            [imgv setImage:[UIImage imageNamed:img]];
            /** 不为空才添加到数组中、 */
            if (imgv.image) {
                [self.dataArry addObject:imgv.image];
            }
            
        }
    }

}
- (UIColor *)color_pageControl
{
    if (!_color_pageControl) {
        _color_pageControl = [UIColor whiteColor] ;
    }
    return _color_pageControl ;
}

- (void)setColor_currentPageControl:(UIColor *)color_currentPageControl
{
    _color_currentPageControl = color_currentPageControl ;
    
    self.pageControl.currentPageIndicatorTintColor = _color_currentPageControl ;
}
/** 页面控制器的颜色 */
- (UIColor *)color_currentPageControl
{
    if (!_color_currentPageControl) {
        _color_currentPageControl = [UIColor yellowColor] ;
    }
    return _color_currentPageControl ;
}
/** 添加定时器 */
- (void)createTimer{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.dur target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        /** 将nstimer 添加到NSRunLoop中 */
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
#pragma mark -
#pragma mark - action
- (void)timerAction{
    if (_imageCount <= 1) return ;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width *2, 0) animated:YES];
    [self performSelector:@selector(reloadImage) withObject:nil afterDelay:.35];
    
}
- (void)tapAction{
    if (self.click) {
        self.click(_currentImageIndex);
    }
}
#pragma mark -
#pragma mark - scrollViewDelegate
/** 滚动视图停止拖动.... */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
}
/** 开始拖拽 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    /** 将定时器失效 */
    [self.timer invalidate];
    
    self.timer = nil;
}
/** 滚动视图停止拖动.... */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self createTimer];
}
- (void)reloadImage
{
    if ( self.imageViews.count == 0 || self.dataArry.count == 0) {
        return;
    }
    NSInteger leftImageIndex,rightImageIndex ;
    CGPoint offset = [_scrollView contentOffset] ;
    
    if (offset.x > self.frame.size.width)
    { //  向右滑动
        _currentImageIndex = (_currentImageIndex + 1) % self.dataArry.count ;
//        NSLog(@"当前----%ld",_currentImageIndex);
    }
    else if(offset.x < self.frame.size.width)
    { //  向左滑动
        _currentImageIndex = (_currentImageIndex + self.dataArry.count - 1) % self.dataArry.count ;
//        NSLog(@"当前----%ld",_currentImageIndex);
    }
    
    UIImageView * centerImageView = [self.imageViews objectAtIndex:1];
    UIImageView *leftImageView = [self.imageViews objectAtIndex:0];
    UIImageView *rightImageView = [self.imageViews objectAtIndex:2];
    
    centerImageView.image =self.dataArry[_currentImageIndex];
    
    //  重新设置左右图片
    leftImageIndex  = (_currentImageIndex + self.dataArry.count - 1) % self.dataArry.count ;
    rightImageIndex = (_currentImageIndex + 1) % self.dataArry.count ;
    leftImageView.image  = self.dataArry[leftImageIndex] ;
    rightImageView.image= self.dataArry[rightImageIndex] ;
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
    self.pageControl.currentPage = self.currentImageIndex;
}

#pragma mark -
#pragma mark -懒加载
- (NSMutableArray *)imageViews
{
    if (!_imageViews) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        /** 内容区域为 3 个size */
        _scrollView.contentSize = CGSizeMake(self.frame.size.width *3, self.frame.size.height);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        /** 不允许弹出界面一点 */
        _scrollView.bounces = NO;
        
    }
    return _scrollView;
}
-(NSMutableArray *)dataArry
{
    if (!_dataArry) {
        _dataArry = [[NSMutableArray alloc]init];
    }
    return _dataArry;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init] ;
        _pageControl.pageIndicatorTintColor = self.color_pageControl ;
        _pageControl.currentPageIndicatorTintColor = self.color_currentPageControl ;
        
    }
    
    return _pageControl ;
}
- (void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

@end
