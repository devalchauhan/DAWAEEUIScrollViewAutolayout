//
//  SwitchProfileViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "SwitchProfileViewController.h"
#import "SUTableCell.h"
@interface SwitchProfileViewController ()

@end

@implementation SwitchProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn_AddNewUser.layer.cornerRadius = 25.0f;
    self.ary_Profiles = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        [self.ary_Profiles addObject:@"Abd er Rahman"];
    }
    self.tbl_Profiles.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tbl_Profiles.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_ary_Profiles count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SUTableCell *cell = (SUTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SUTableCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lbl_ItemName.text = [NSString stringWithFormat:@"%@",[_ary_Profiles objectAtIndex:indexPath.row]];
        if (indexPath.row==0) {
            cell.btn_Delete.hidden=TRUE;
        }
        else
            cell.btn_Active.hidden=TRUE;
        
        cell.btn_Active.layer.cornerRadius=12.0f;
        cell.iv_ProfileImage.layer.cornerRadius = 30.0f;
        cell.iv_ProfileImage.clipsToBounds=YES;
        
    }
    
    return cell;
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
