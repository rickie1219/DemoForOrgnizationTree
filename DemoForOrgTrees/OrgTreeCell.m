//
//  OrgTreeCell.m
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import "OrgTreeCell.h"
#import "OrgTreeDepartment.h"

@implementation OrgTreeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblDepartmentName = [UILabel new];
        _lblDepartmentName.frame = CGRectMake(15, (self.contentView.frame.size.height-30)/2, 300, 30);
        _lblDepartmentName.textColor = [UIColor redColor];
        _lblDepartmentName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lblDepartmentName];
    }
    return self;
}

#pragma mark - 配置cell显示的内容
- (void)configCellWithModel:(OrgTreeDepartment *)department
{
    _lblDepartmentName.text = [NSString stringWithFormat:@"%@", department.deparmentName];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
