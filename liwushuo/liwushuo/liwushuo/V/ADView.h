//
//  ADView.h
//  AdView
//
//  Created by BO on 17/3/29.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^adViewClick)(NSInteger index);

@interface ADView : UIView
/** 设置代码块属性 */
@property (copy,nonatomic)adViewClick click;

@property (strong,nonatomic)NSArray * imgArr;

/** ADView 初始化方法
 @param openTimer 是否开启定时器
 @param Block 当广告视图点击时做的什么操作...
 @return ADView
 */
-(instancetype)initWithFrame:(CGRect)frame isOpenTimer
                            :(BOOL)openTimer clickBlock:(adViewClick)Block;
//-(void)addImg:(NSArray *)tempArr;


@end
