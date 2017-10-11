//
//  OrgTreeCell.h
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrgTreeDepartment;


@interface OrgTreeCell : UITableViewCell


@property (nonatomic, strong) UILabel *lblDepartmentName;


- (void)configCellWithModel:(OrgTreeDepartment *)department;


@end
