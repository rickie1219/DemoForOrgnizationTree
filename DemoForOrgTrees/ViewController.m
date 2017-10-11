//
//  ViewController.m
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import "ViewController.h"
#import "OrgTreeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 100, 200, 100);
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(pushToNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)pushToNextVC
{
    OrgTreeViewController *vc = [[OrgTreeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
