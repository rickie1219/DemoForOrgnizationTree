//
//  OrgTreeViewController.m
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import "OrgTreeViewController.h"
#import "OrgTreeCell.h"
#import "OrgTreeHeaderView.h"
#import "OrgTreeDepartment.h"


#define KHierarchViewHeight 44


@interface OrgTreeViewController ()<UITableViewDelegate, UITableViewDataSource, OrgTreeHeaderViewDelegate>
{
    // 这个是表视图的数据源数组
    NSMutableArray      *arrDepartments;
    UITableView         *org_tableView;
    
    /** 顶部菜单视图*/
    OrgTreeHeaderView   *orgHeaderView;
    /** 顶部菜单的数组*/
    NSMutableArray      *arrHeaderItems;
    
    /** 层级标记*/
    int flagLevel;
    
    /** 测试用的数组*/
    NSMutableArray      *arrTemp;
}
@end



@implementation OrgTreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 初始化数组和标记层级位置
    flagLevel = 0;
    arrHeaderItems = [NSMutableArray arrayWithCapacity:0];
    arrDepartments = [NSMutableArray array];
    
    [self initData];
    
    [self initTableView];
    
}

#pragma mark - 初始化菜单栏选项数据
- (void)initData
{
    // 创建假数据
    arrTemp = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 20; i++) {
        OrgTreeDepartment *dep11 = [[OrgTreeDepartment alloc] init];
        dep11.deparmentName = [NSString stringWithFormat:@"第%d层 第%d个元素行数据很长很长很长很长很长很长很长很长很长", flagLevel, i];
        [arrTemp addObject:dep11];
    }
    // 这是根目录下的tableView的数据源数组
    arrDepartments = [arrTemp mutableCopy];
    
    
    // 1.先获取点击的组织机构的基本信息
    OrgTreeDepartment *dep = [[OrgTreeDepartment alloc] init];
    dep.deparmentName = @"根全部";
    // 2.获取当前的索引
    NSString *index = [NSString stringWithFormat:@"%d", flagLevel];
    // 3.获取子部门数据
    NSArray *arr = [arrTemp mutableCopy];
    // 4.将上面的三个数据存入字典,存放到顶部菜单数组中
    NSDictionary *dict = @{@"model": dep, @"index": index, @"array" : arr};
    // 5.菜单数组需要存入包含以上三个信息的字典
    [arrHeaderItems addObject:dict];
    
}

- (void)initTableView
{
    org_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    org_tableView.delegate = self;
    org_tableView.dataSource = self;
    org_tableView.rowHeight = 50;
    [self.view addSubview:org_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrDepartments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"rootCell";
    OrgTreeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[OrgTreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    [cell configCellWithModel:arrDepartments[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
    
    // 创建头视图
    orgHeaderView = [[OrgTreeHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    [headerView addSubview:orgHeaderView];
    orgHeaderView.delegate = self;
   
    // 如果顶部菜单按钮的数组有元素,就说明是点击过组织结构
    if (arrHeaderItems.count > 0)
    {
        orgHeaderView.departments = arrHeaderItems;
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击某个部门的时候, 就获取将该部门的所有子部门,然后刷新表数据,还要刷新分区头
    flagLevel++;
    
    // 1.先获取点击的组织机构的基本信息
    OrgTreeDepartment *dep = arrDepartments[indexPath.row];
    // 2.获取当前的索引
    NSString *index = [NSString stringWithFormat:@"%d", flagLevel];
    // 3.获取子部门数据
    // 3.1->先移除临时数组中的数据
    [arrTemp removeAllObjects];
    // 3.2->再将请求到的子部门的数据添加到临时数组中
    for (int j = 0; j < 20; j++) {
        OrgTreeDepartment *dep11 = [[OrgTreeDepartment alloc] init];
        dep11.deparmentName = [NSString stringWithFormat:@"第%d层 第%d个元素行 子部门也是很长很长的", flagLevel, j];
        [arrTemp addObject:dep11];
    }
    // 4.将上面的三个数据存入字典,存放到顶部菜单数组中
    NSDictionary *dict = @{@"model": dep, @"index": index, @"array" : arrTemp};
    // 5.菜单数组需要存入包含三个信息的字典
    [arrHeaderItems addObject:dict];
    
    // 这里在点击单元格的时候,根据单元格请求数据
    // 然后根据请求到的数据数组, 将数组赋值给表视图的数据源数组
    arrDepartments = [arrTemp mutableCopy];
    
    [org_tableView reloadData];
}

#pragma mark - OrgnizationHeaderViewDelegate
- (void)orgnizationHeaderViewDidClickIndex:(NSInteger)index
{
    // 点击选项按钮的代理方法的时候
    // 1.根据索引,将_headerMenuArray菜单数组中的索引后面的数据都删除掉
    NSLog(@"==代理方法==->打印点击了第%ld个菜单选项", index);
    // 如果点击菜单选项和当前的层级标记相等，不做任何操作，直接返回
    if (flagLevel == (int)index)
    {
        return;
    }
    // 层级标记的索引需要跟点击的菜单选项索引变化
    flagLevel = (int)index;
    
    // 用来保存菜单选项数组的临时数组
    NSMutableArray *arrHeaderTemp = [NSMutableArray array];
    // 根据点击的第几个菜单选项索引x，遍历到原来菜单选项数组第x个元素，添加item到临时数组中
    for (int i = 0; i <= index; i++) {
        [arrHeaderTemp addObject:arrHeaderItems[i]];
    }
    // 临时数组添加好了以后，就将原来的选项数组中的所有元素移除
    [arrHeaderItems removeAllObjects];
    // 再将临时数组中的数组赋值给原来的菜单选项数组
    arrHeaderItems = [arrHeaderTemp mutableCopy];
    // tableView的数据源数组也要进行替换，替换成当前选项菜单下的数据
    // 先移除数组中的所有元素
    [arrDepartments removeAllObjects];
    // 再将选中的菜单选项下的数据赋值给tableView的数据源数组
    arrDepartments = [arrHeaderItems[index] objectForKey:@"array"];
    
    
    // 2.删除掉多余的数据以后,刷新表视图
    [org_tableView reloadData];
}



@end
