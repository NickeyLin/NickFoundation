//
//  NLCoreDataViewController.m
//  NickFoundation
//
//  Created by Nick.Lin on 16/6/28.
//  Copyright © 2016年 Nick.Lin. All rights reserved.
//

#import "NLCoreDataViewController.h"
#import "User.h"

@interface NLCoreDataViewController (){
    NSMutableArray<User *> *_users;
    NLCoreData *_coredata;
}

@end

@implementation NLCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _coredata = [NLCoreData instanceWithModelFileName:@"Contacts" databaseFileName:@"contacts.sqlite"];
    [self refreshData];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [_coredata saveContext];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData{
    _users = [[User itemsInCoreData:_coredata] mutableCopy];
    [self.tableView reloadData];
}
- (IBAction)actionAdd:(UIBarButtonItem *)sender {

    User *user = [User insertNewItemInCoreData:_coredata fillContent:^(id  _Nullable item) {
        ((User *)item).name = @"Nick";
        ((User *)item).sex = @YES;
        ((User *)item).address = @"MY";
    } autoSave:YES];
    [_users addObject:user];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_users.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usercell"];
    cell.textLabel.text = _users[indexPath.row].name;
    cell.detailTextLabel.text = _users[indexPath.row].address;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_users[indexPath.row] removeFrom:_coredata];
        [_users removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [_coredata saveContext];
    }
}
//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了删除");
//        
//        // 1. 更新数据
//        // 2. 更新UI
//        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
//    
//    // 删除一个置顶按钮
//    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了置顶");
//        
//        // 1. 更新数据
//        
//        // 2. 更新UI
//        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
//    }];
//    topRowAction.backgroundColor = [UIColor blueColor];
//    
//    // 添加一个更多按钮
//    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了更多");
//        
//        [tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationMiddle];
//    }];
//    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    
//    // 将设置好的按钮放到数组中返回
//    return @[deleteRowAction, topRowAction, moreRowAction];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
