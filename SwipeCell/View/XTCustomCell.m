//
//  XTCustomCell.m
//  SwipeCell
//
//  Created by zjwang on 16/6/2.
//  Copyright © 2016年 夏天. All rights reserved.
//

#import "XTCustomCell.h"

@implementation XTCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label.frame = CGRectMake(10, 5, self.frame.size.width, self.frame.size.height - 10);
        self.label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.label];
    }
    return self;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}
@end
