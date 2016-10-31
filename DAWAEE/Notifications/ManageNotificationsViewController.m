//
//  ManageNotificationsViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/16/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "ManageNotificationsViewController.h"
#import "MITableCell.h"
@interface ManageNotificationsViewController ()

@end

@implementation ManageNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    prefs = [NSUserDefaults standardUserDefaults];
    
    w1 =  [prefs valueForKey:@"N1"];
    w2 =  [prefs valueForKey:@"N2"];
    w3 =  [prefs valueForKey:@"N3"];
    w4 = [prefs valueForKey:@"N4"];
    self.ary_Items = [NSMutableArray array];
    [_ary_Items addObject:@"Appointments"];
    [_ary_Items addObject:@"Vaccinations"];
    [_ary_Items addObject:@"Health History"];
    [_ary_Items addObject:@"Announcment"];
    
    //self.tbl_Items.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tbl_Items.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tbl_Items.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
-(IBAction)Back
{
    [UIView beginAnimations:@"animation" context:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [UIView setAnimationDuration: 0.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}

#pragma mark UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_ary_Items count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MITableCell *cell = (MITableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"MITableCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lbl_ItemName.text = [NSString stringWithFormat:@"%@",[_ary_Items objectAtIndex:indexPath.row]];
        [cell.swith addTarget:self action:@selector(flip:) forControlEvents:UIControlEventValueChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.swith.tag = indexPath.row;
        /*if (indexPath.row==0||indexPath.row==1)
         cell.swith.enabled=FALSE;*/
        
        if (indexPath.row==0) {
            if ([w1 isEqualToString:@""]||[w1 isEqualToString:@"0"]||w1==nil)
                cell.swith.on= TRUE;
            else
                cell.swith.on= FALSE;
        }
        else if (indexPath.row==1) {
            if ([w2 isEqualToString:@""]||[w2 isEqualToString:@"0"]||w2==nil)
                cell.swith.on= TRUE;
            else
                cell.swith.on= FALSE;
        }
        
        else if (indexPath.row==2) {
            if ([w3 isEqualToString:@""]||[w3 isEqualToString:@"0"]||w3==nil)
                cell.swith.on= TRUE;
            else
                cell.swith.on= FALSE;
        }
        else if (indexPath.row==3) {
            if ([w4 isEqualToString:@""]||[w4 isEqualToString:@"0"]||w4==nil)
                cell.swith.on= TRUE;
            else
                cell.swith.on= FALSE;
        }
        else if (indexPath.row==4) {
            if ([w5 isEqualToString:@""]||[w5 isEqualToString:@"0"]||w5==nil)
                cell.swith.on= TRUE;
            else
                cell.swith.on= FALSE;
        }
    }
    
    return cell;
}

- (IBAction)flip:(id)sender {
    
    UISwitch *switch_table = (UISwitch*)sender;
    if (switch_table.on) {
        switch (switch_table.tag) {
            case 0:
                [prefs setValue:@"0" forKey:@"N1"];
                [prefs synchronize];
                break;
            case 1:
                [prefs setValue:@"0" forKey:@"N2"];
                [prefs synchronize];
                break;
                
            case 2:
                [prefs setValue:@"0" forKey:@"N3"];
                [prefs synchronize];
                break;
            case 3:
                [prefs setValue:@"0" forKey:@"N4"];
                [prefs synchronize];
                break;
            case 4:
                [prefs setValue:@"0" forKey:@"N5"];
                [prefs synchronize];
                break;
                
            default:
                break;
        }
    }
    else  {
        switch (switch_table.tag) {
            case 0:
                [prefs setValue:@"1" forKey:@"N1"];
                [prefs synchronize];
                break;
            case 1:
                [prefs setValue:@"1" forKey:@"N2"];
                [prefs synchronize];
                break;
            case 2:
                [prefs setValue:@"1" forKey:@"N3"];
                [prefs synchronize];
                break;
            case 3:
                [prefs setValue:@"1" forKey:@"N4"];
                [prefs synchronize];
                break;
            case 4:
                [prefs setValue:@"1" forKey:@"N5"];
                [prefs synchronize];
                break;
                
            default:
                break;
        }
    }
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
