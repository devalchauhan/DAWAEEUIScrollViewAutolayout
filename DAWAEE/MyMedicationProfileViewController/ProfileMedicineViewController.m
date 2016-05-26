//
//  ProfileMedicineViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 5/15/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "ProfileMedicineViewController.h"
#import "ProfileTableViewCell.h"
#import "AddMedicationViewController.h"
@interface ProfileMedicineViewController ()

@end

@implementation ProfileMedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)BackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)ALLClicked
{
    self.lbl_ALL.hidden=FALSE;
    self.lbl_DHA.hidden=TRUE;
    self.lbl_EXTERNAL.hidden=TRUE;
}
-(IBAction)DHAClicked
{
    self.lbl_ALL.hidden=TRUE;
    self.lbl_DHA.hidden=FALSE;
    self.lbl_EXTERNAL.hidden=TRUE;
}
-(IBAction)EXTERNALClicked
{
    self.lbl_ALL.hidden=TRUE;
    self.lbl_DHA.hidden=TRUE;
    self.lbl_EXTERNAL.hidden=FALSE;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)EditMedicineClicked
{
    AddMedicationViewController *obj_AddMedicationViewController = [[AddMedicationViewController alloc] initWithNibName:@"AddMedicationViewController" bundle:nil];
    [self.navigationController pushViewController:obj_AddMedicationViewController animated:YES];
}
-(void)DeleteMedicineClicked
{
    
}
#pragma mark UITableView Delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        static NSString *CellIdentifier = @"MessageCellIdentifier";
        ProfileTableViewCell *cell = (ProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell=nil;
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"ProfileTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.iv_ProfileImage.image = [UIImage imageNamed:@"profile.png"];
            cell.iv_ProfileImage.layer.cornerRadius = 22.0f;
            cell.lbl_ProfileName.text = @"Medicine Name";
            [cell.btn_Edit addTarget:self action:@selector(EditMedicineClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell.btn_Delete addTarget:self action:@selector(DeleteMedicineClicked) forControlEvents:UIControlEventTouchUpInside];
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
