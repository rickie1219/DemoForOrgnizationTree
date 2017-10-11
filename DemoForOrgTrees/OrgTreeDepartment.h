//
//  OrgTreeDepartment.h
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrgTreeDepartment : NSObject


/** 部门名称 */
@property (nonatomic, strong) NSString *deparmentName;

/** 部门级别 */
@property (nonatomic, assign) int departmentLevel;

/** 子部门数组 */
@property (nonatomic, strong) NSMutableArray *departmentChildArray;

/** 部门索引 */
@property (nonatomic, assign) int departIndex;



@end
