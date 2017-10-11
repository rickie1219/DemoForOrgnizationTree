//
//  OrgTreeHeaderView.h
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrgnizationHeaderView;


#pragma mark - 代理方法
@protocol OrgTreeHeaderViewDelegate <NSObject>
- (void)orgnizationHeaderViewDidClickIndex:(NSInteger)index;
@end


@interface OrgTreeHeaderView : UIView

/** 代理,选中某各个 */
@property (nonatomic, weak) id<OrgTreeHeaderViewDelegate> delegate;
/** 这个数组是用来存储有多少个部门选项 */
@property (nonatomic, strong) NSArray *departments;
/** 用来加载按钮 */
@property (nonatomic, strong) UIScrollView *scrollView;


@end
