//
//  CommonViewCell.h
//  liwushuo
//
//  Created by BO on 17/4/5.
//  Copyright © 2017年 xsqBO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "select_M.h"
#import "column.h"
#import "author.h"
@interface CommonViewCell : UITableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImgv;
/** 人名 */
@property (weak, nonatomic) IBOutlet UILabel *iconNlab;
/** 个人标签 */
@property (weak, nonatomic) IBOutlet UILabel *iconPislab;
/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgv;
/** 标语 */
@property (weak, nonatomic) IBOutlet UILabel *sloganlab;
/** 描述 */
@property (weak, nonatomic) IBOutlet UILabel *deslab;
/** 当前栏目名称 */
@property (weak, nonatomic) IBOutlet UILabel *columnlab;
/** 点赞数、、 */
@property (weak, nonatomic) IBOutlet UILabel *feednumlab;
/** 模型 */
@property (strong,nonatomic)select_M * select_model;
@property (strong,nonatomic)author   * author_model;
@property (strong,nonatomic)column   * column_model;

@end
