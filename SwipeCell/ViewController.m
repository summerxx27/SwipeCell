//
//  ViewController.m
//  SwipeCell
//
//  Created by zjwang on 16/6/2.
//  Copyright © 2016年 夏天. All rights reserved.
//

#import "ViewController.h"
#import "MGSwipeButton.h"
#import "XTCustomCell.h"
#define cellidentifier @"cellidentifier"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayTest;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrayTest = [NSMutableArray arrayWithObjects:
                      @"I AM A CELL",@"I AM A CELL",
                      @"I AM A CELL",@"I AM A CELL",
                      @"I AM A CELL",@"I AM A CELL",
                      @"I AM A CELL",@"I AM A CELL",
                      @"I AM A CELL",@"I AM A CELL",
                      @"I AM A CELL",@"I AM A CELL",
                      nil];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [_tableView registerClass:[XTCustomCell class] forCellReuseIdentifier:cellidentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayTest.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XTCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    cell.label.text = [NSString stringWithFormat:@"%ld------%@", (long)indexPath.row, self.arrayTest[indexPath.row]];
    cell.label.font = [UIFont systemFontOfSize:20];
    cell.delegate = self;
    // NO: 只有单个可以滑动 , YES: 多个可以滑动
    cell.allowsMultipleSwipe = NO;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#warning 使用 swipeTableCell 把 0 改成 1
#if 1
-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
{
    if (direction == MGSwipeDirectionRightToLeft) {
        
        return [self btnRightCount:2];
    }
    else {
        return [self btnLeftCount:3];
        
    }
}
-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    
    switch (direction) {
        case MGSwipeDirectionLeftToRight: {
            if (index == 0) {
                NSLog(@"right ------- 0");
            }else{
                NSLog(@"right ------- 1");
            }
            break;
        }
        case MGSwipeDirectionRightToLeft: {
            if (index == 0) {
                NSLog(@"left ------- 0");
                
                NSIndexPath * path = [_tableView indexPathForCell:cell];
                [_arrayTest removeObjectAtIndex:path.row];
                [_tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
                return NO;
                
            }else{
                NSLog(@"left ------- 1");
            }
            break;
        }
    }
    return YES;
}
#endif
#warning 使用 系统 把 0 改成 1
#if 0
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self.arrayTest removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self.arrayTest exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
    }];
    
    topRowAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    }];
    return @[deleteRowAction,topRowAction,moreRowAction];
}
#endif
- (NSArray *)btnLeftCount:(int)count
{
    NSMutableArray *result = [NSMutableArray array];
    UIColor *colors[3] = {[UIColor greenColor],
        [UIColor colorWithRed:0 green:0x99/255.0 blue:0xcc/255.0 alpha:1.0],
        [UIColor colorWithRed:0.59 green:0.29 blue:0.08 alpha:1.0]};;
    for (int i = 0; i < count; i ++) {
        MGSwipeButton *btn = [MGSwipeButton buttonWithTitle:@"" backgroundColor:colors[i] padding:15 callback:^BOOL(MGSwipeTableCell *sender) {
            return YES;
        }];
        // 把按钮加到数组中
        [result addObject:btn];
    }
    return result;
}
- (NSArray *)btnRightCount:(int)count
{
    
    NSMutableArray *result = [NSMutableArray array];
    NSArray *titleArray = @[@"删除", @"标记未读"];
    UIColor *color[2] = {[UIColor redColor], [UIColor lightGrayColor]};
    for (int i = 0; i < count; i ++) {
        MGSwipeButton *btn = [MGSwipeButton buttonWithTitle:titleArray[i] backgroundColor:color[i] padding:15 callback:^BOOL(MGSwipeTableCell *sender) {
            BOOL autoHide = i != 0;
            return autoHide;
        }];
        // 把按钮加到数组中
        [result addObject:btn];
    }
    return result;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
