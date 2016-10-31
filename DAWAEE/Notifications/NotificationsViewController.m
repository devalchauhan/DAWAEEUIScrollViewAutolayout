//
//  NotificationsViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/16/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "NotificationsViewController.h"
#import "NotificationCell.h"
#import "ManageNotificationsViewController.h"
@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbl_Notificaitons.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tbl_Notificaitons.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)ManageNotificaitonsClicked
{
    ManageNotificationsViewController *objManageNotificationsViewController = [[ManageNotificationsViewController alloc] initWithNibName:@"ManageNotificationsViewController" bundle:nil];
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration: 0.3];
    [self.navigationController pushViewController: objManageNotificationsViewController animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    NotificationCell *cell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"NotificationCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
