//
//  OrgTreeHeaderViewItem.m
//  DemoForOrgTrees
//
//  Created by Rickie_Lambert on 2017/10/9.
//  Copyright © 2017年 RickieLambert. All rights reserved.
//

#import "OrgTreeHeaderViewItem.h"
#import "OrgTreeDepartment.h"

static CGFloat labelHeight = 20;
static CGFloat fontSize = 14;

@interface OrgTreeHeaderViewItem()
{
    CGFloat itemHeight;
}
@end


@implementation OrgTreeHeaderViewItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor yellowColor];
        itemHeight = frame.size.height;
    }
    return self;
}


- (void)setDepartment:(OrgTreeDepartment *)department
{
    _department = department;
    // 计算文本一行显示需要的长度
    // 根据菜单选项文本，计算标签的长度
    // 根据字体得到NSString的尺寸
    
    CGSize maximumLabelSize = CGSizeMake(FLT_MAX, labelHeight);
//    CGSize maximumLabelSize = CGSizeMake(MAXFLOAT, itemHeight);
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
    UIColor *color = [UIColor blackColor];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, color, NSForegroundColorAttributeName, nil];
    CGRect expectedLabelRect = [_department.deparmentName boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributesDictionary context:nil];
    
    CGFloat originX = self.frame.origin.x;
    CGFloat originY = self.frame.origin.y;
    
    // 1->选项文本前的箭头图片
    UIImageView *hintImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, 6, 12)];
    // 设置箭头的中心点，使箭头图片垂直居中
    hintImageView.center = CGPointMake(hintImageView.center.x, itemHeight/2);
    hintImageView.image = [UIImage imageNamed:@"arrow"];
    //hintImageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:hintImageView];
    
    CGFloat maxHintImageX = CGRectGetMaxX(hintImageView.frame);
    
    // 2->选项的标题文本
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(maxHintImageX + 3, 0, expectedLabelRect.size.width + 15, itemHeight)];
    lblName.text = _department.deparmentName;
    lblName.textColor = [UIColor blackColor];
    lblName.font = font;
    //lblName.backgroundColor = [UIColor cyanColor];
    lblName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lblName];
    
    CGFloat maxhintImageX = CGRectGetMaxX(lblName.frame);
    self.frame = CGRectMake(originX, originY, maxhintImageX, itemHeight);
    
    // 选项的背景颜色
    self.backgroundColor = [UIColor colorWithRed:((float)((0xf2f2f2 & 0xFF0000) >> 16))/255.0 green:((float)((0xf2f2f2 & 0xFF00) >> 8))/255.0 blue:((float)(0xf2f2f2 & 0xFF))/255.0 alpha:1.0];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    // 触碰的个数/点击菜单的个数
    NSUInteger tapCount = touch.tapCount;
    NSLog(@"touch method block -> department = %@", _department.deparmentName);
    NSLog(@"selected No.%d item", _index);
    switch (tapCount)
    {
        case 1:
            if (self.itemClickBlock)
            {
                self.itemClickBlock(self);
            }
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
}


@end
