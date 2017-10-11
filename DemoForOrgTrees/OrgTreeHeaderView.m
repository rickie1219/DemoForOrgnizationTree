//
//  OrgTreeHeaderView.m
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import "OrgTreeHeaderView.h"
#import "OrgTreeHeaderViewItem.h"
#import "OrgTreeDepartment.h"


@interface OrgTreeHeaderView()
{
    /** 起始的横坐标点*/
    CGFloat originalX;
    /** 菜单目录的高度*/
    CGFloat kHierarchyNaviViewHeigth;
    /** 菜单目录的宽度*/
    CGFloat kHierarchyNaviViewWidth;
}
@end

@implementation OrgTreeHeaderView

#pragma mark - 菜单头视图上的滚动视图
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.scrollEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}


#pragma mark - 初始化头视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 添加滚动视图
        [self addSubview:self.scrollView];
        // 组织机构视图的高度就是滚动视图的高度
        kHierarchyNaviViewHeigth = frame.size.height;
        kHierarchyNaviViewWidth = frame.size.width;
        
        originalX = 0.0;
        
        OrgTreeHeaderViewItem *item = [[OrgTreeHeaderViewItem alloc] initWithFrame:CGRectMake(originalX, 0, 0, kHierarchyNaviViewHeigth)];
        item.index = 0;
        // 菜单选项选中时，调用的block，block里面调用了代理方法
        item.itemClickBlock = ^(OrgTreeHeaderViewItem *item) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(orgnizationHeaderViewDidClickIndex:)]) {
                    [self.delegate orgnizationHeaderViewDidClickIndex:item.index];
                }
            });
        };
        
        originalX = CGRectGetMaxX(item.frame);
        [self.scrollView addSubview:item];
        
    }
    return self;
}


- (void)setDepartments:(NSArray *)departments
{
    _departments = departments;
    
    if (_departments != nil && _departments.count > 0)
    {
        //        CGFloat originalX = 0.0;
        for (int i = 0; i < self.departments.count; i++) {
            OrgTreeDepartment *dep = [self.departments[i] objectForKey:@"model"];
            OrgTreeHeaderViewItem *item = [[OrgTreeHeaderViewItem alloc] initWithFrame:CGRectMake(originalX, 0, 0, kHierarchyNaviViewHeigth)];
            item.index = [[self.departments[i] objectForKey:@"index"] intValue];
            item.department = dep;
            item.itemClickBlock = ^(OrgTreeHeaderViewItem *item) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self.delegate respondsToSelector:@selector(orgnizationHeaderViewDidClickIndex:)]) {
                        [self.delegate orgnizationHeaderViewDidClickIndex:item.index];
                    }
                });
            };
            originalX = CGRectGetMaxX(item.frame);
            [self.scrollView addSubview:item];
        }
        self.scrollView.contentSize = CGSizeMake(originalX, kHierarchyNaviViewHeigth);
        
        // 初始化的时候,就让它滚动到最后一个选项的位置
        // 1.如果菜单选项item的总宽度大于顶部菜单栏的长度,就让scrollView的偏移量减去顶部菜单的宽度
        if (originalX > kHierarchyNaviViewWidth) {
            self.scrollView.contentOffset = CGPointMake(originalX - kHierarchyNaviViewWidth, 0);
        } else {
            // 2.如果已选择的选项item的总宽度小于顶部菜单的长度,那scrollView的偏移量为0
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
}




@end
