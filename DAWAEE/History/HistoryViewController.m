//
//  HistoryViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/16/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryCell.h"
@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbl_History.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    self.tbl_History.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tbl_History.separatorStyle = UITableViewCellSelectionStyleNone;
    lbl_PriscriptionBG.layer.cornerRadius=2;
    lbl_AppointmentBG.layer.cornerRadius=2;
    lbl_LabResultBG.layer.cornerRadius=2;
    lbl_AdmissionBG.layer.cornerRadius=2;
    lbl_AdmissionBG.clipsToBounds=YES;
    lbl_LabResultBG.clipsToBounds=YES;
    lbl_AppointmentBG.clipsToBounds=YES;
    lbl_PriscriptionBG.clipsToBounds=YES;
}


-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)FilterExpand
{
    CGRect filterframe = self.view_Filters.frame;
    if (filterframe.size.height==50) {
        ViewFilterHeightConstraint.constant=150;
        self.view_Gradient.hidden=FALSE;
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(ShowHideFilters) userInfo:nil repeats:NO];
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
    else
    {
        
        ViewFilterHeightConstraint.constant=50;
        self.view_Gradient.hidden=TRUE;
        lbl_AdmissionBG.hidden=TRUE;
        lbl_LabResultBG.hidden=TRUE;
        lbl_AppointmentBG.hidden=TRUE;
        lbl_PriscriptionBG.hidden=TRUE;
        btn_AdmissionBG.hidden=TRUE;
        btn_LabResultBG.hidden=TRUE;
        btn_AppointmentBG.hidden=TRUE;
        btn_PriscriptionBG.hidden=TRUE;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
    
}
-(void)ShowHideFilters
{
    CGRect filterframe = self.view_Filters.frame;
    if (filterframe.size.height==50) {

    }
    else {
        
        lbl_AdmissionBG.hidden=FALSE;
        lbl_LabResultBG.hidden=FALSE;
        lbl_AppointmentBG.hidden=FALSE;
        lbl_PriscriptionBG.hidden=FALSE;
        btn_AdmissionBG.hidden=FALSE;
        btn_LabResultBG.hidden=FALSE;
        btn_AppointmentBG.hidden=FALSE;
        btn_PriscriptionBG.hidden=FALSE;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
        return 35;
    else
        return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.lbl_Date.hidden=TRUE;
            cell.iv_CategoryBG.hidden=TRUE;
            cell.lbl_Line.hidden=TRUE;
            cell.lbl_CategoryStatic.hidden=TRUE;
            
            cell.lbl_Year.hidden=FALSE;
            cell.iv_YearBG.hidden=FALSE;
            
        }
        else {
            cell.lbl_Date.hidden=FALSE;
            cell.iv_CategoryBG.hidden=FALSE;
            cell.lbl_Line.hidden=FALSE;
            cell.lbl_CategoryStatic.hidden=FALSE;
            
            cell.lbl_Year.hidden=TRUE;
            cell.iv_YearBG.hidden=TRUE;
        }
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
