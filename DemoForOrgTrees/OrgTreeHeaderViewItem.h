//
//  OrgTreeHeaderViewItem.h
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrgTreeDepartment;

@interface OrgTreeHeaderViewItem : UIView


@property (nonatomic, strong) void (^itemClickBlock)(OrgTreeHeaderViewItem *item);


@property (nonatomic, strong) OrgTreeDepartment *department;


@property (nonatomic, assign) int index;


@end
