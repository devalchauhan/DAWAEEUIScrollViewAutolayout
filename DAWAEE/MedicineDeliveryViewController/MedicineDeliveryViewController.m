//
//  MedicineDeliveryViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 4/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "MedicineDeliveryViewController.h"
#import "Constants.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "PharmaciesViewController.h"
#import "AskYourPharmacistViewController.h"
#import "NewsArticlesViewController.h"
#import "FAQsViewController.h"
#import "FirstAdViewController.h"
#import "MyMedicationProfileViewController.h"
#import "DrugInformationViewController.h"
#import "SettingsViewController.h"
@interface MedicineDeliveryViewController ()

@end

@implementation MedicineDeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view_Gradient.hidden=TRUE;
    self.view_Menu.hidden=TRUE;
    [self.view_Gradient addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideMenu)]];
    self.ary_Menu = [NSMutableArray array];
    [self.ary_Menu addObject:@"Home"];
    [self.ary_Menu addObject:@"Profiles"];
    [self.ary_Menu addObject:@"Pharmacies"];
    [self.ary_Menu addObject:@"Medicine Delivery"];
    [self.ary_Menu addObject:@"Ask Your Pharmacist"];
    [self.ary_Menu addObject:@"News & Articles"];
    [self.ary_Menu addObject:@"FAQ's"];
    [self.ary_Menu addObject:@"First Aid"];
    [self.ary_Menu addObject:@"My Medication Profile"];
    [self.ary_Menu addObject:@"Drug Information"];
    [self.ary_Menu addObject:@"Settings"];
    [self.ary_Menu addObject:@"Logout"];
    
    
    
    [self.scrl setContentSize:CGSizeMake(10, 650)];
    self.scrl.translatesAutoresizingMaskIntoConstraints  = NO;
    
    
    self.view_SCRLContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrl addSubview:self.view_SCRLContainer];
    
    NSDictionary *views = @{@"beeView":self.view_SCRLContainer};
    if (IS_IPHONE_5) {
        NSDictionary *metrics = @{@"height" : @630, @"width" : @304};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6){
        NSDictionary *metrics = @{@"height" : @630, @"width" : @359};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6Plus){
        NSDictionary *metrics = @{@"height" : @630, @"width" : @398};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view_PatientInfo.bounds];
    self.view_PatientInfo.layer.masksToBounds = NO;
    self.view_PatientInfo.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_PatientInfo.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_PatientInfo.layer.shadowOpacity = 0.5f;
    self.view_PatientInfo.layer.shadowPath = shadowPath.CGPath;
    
    UIBezierPath *shadowPath1 = [UIBezierPath bezierPathWithRect:self.view_AppointmentInfo.bounds];
    self.view_AppointmentInfo.layer.masksToBounds = NO;
    self.view_AppointmentInfo.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_AppointmentInfo.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_AppointmentInfo.layer.shadowOpacity = 0.5f;
    self.view_AppointmentInfo.layer.shadowPath = shadowPath1.CGPath;
    
    
    UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRect:self.view_CustomerInfo.bounds];
    self.view_CustomerInfo.layer.masksToBounds = NO;
    self.view_CustomerInfo.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_CustomerInfo.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_CustomerInfo.layer.shadowOpacity = 0.5f;
    self.view_CustomerInfo.layer.shadowPath = shadowPath2.CGPath;
    
    
    
}
-(IBAction)HomeClicked
{
    self.view_Gradient.hidden=FALSE;
    self.view_Menu.hidden=FALSE;
    [self.tbl_Menu reloadData];
}
-(void)HideMenu
{
    self.view_Gradient.hidden=TRUE;
    self.view_Menu.hidden=TRUE;
}
-(IBAction)BackClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)LangaugeClicked
{
    
}
#pragma mark UITextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}


#pragma mark UITableView Delegates


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     if ([tableView isEqual:self.tbl_MedicineDelivery])
        return 3;
    else
        return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:self.tbl_MedicineDelivery])
        return 2;
    else
        return [self.ary_Menu count];
}

- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 6.0;
    }
    
    return 1.0;
}

- (CGFloat)tableView:(UITableView*)tableView
heightForFooterInSection:(NSInteger)section {
    return 5.0;
}

- (UIView*)tableView:(UITableView*)tableView
viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView*)tableView:(UITableView*)tableView
viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"DAWAEE";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"eventCell"];
    }
    if ([tableView isEqual:self.tbl_MedicineDelivery]) {
        
    }
    else {
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.textLabel.text = [self.ary_Menu objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.0 weight:UIFontWeightSemibold]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.ary_Menu objectAtIndex:indexPath.row]]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.view_Menu.hidden=TRUE;
    self.view_Gradient.hidden=TRUE;
    if (indexPath.row==0){
        HomeViewController *obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        [self.navigationController pushViewController:obj_HomeViewController animated:YES];
    }
    else if (indexPath.row==1)
    {
        ProfileViewController *obj_ProfileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        [self.navigationController pushViewController:obj_ProfileViewController animated:YES];
    }
    else if (indexPath.row==2)
    {
        PharmaciesViewController *obj_PharmaciesViewController = [[PharmaciesViewController alloc] initWithNibName:@"PharmaciesViewController" bundle:nil];
        [self.navigationController pushViewController:obj_PharmaciesViewController animated:YES];
    }
    else if (indexPath.row==3)
    {
        
    }
    else if (indexPath.row==4)
    {
        AskYourPharmacistViewController *obj_AskYourPharmacistViewController = [[AskYourPharmacistViewController alloc] initWithNibName:@"AskYourPharmacistViewController" bundle:nil];
        [self.navigationController pushViewController:obj_AskYourPharmacistViewController animated:YES];
    }
    else if (indexPath.row==5)
    {
        NewsArticlesViewController *obj_NewsArticlesViewController = [[NewsArticlesViewController alloc] initWithNibName:@"NewsArticlesViewController" bundle:nil];
        [self.navigationController pushViewController:obj_NewsArticlesViewController animated:YES];
    }
    else if (indexPath.row==6)
    {
        FAQsViewController *obj_FAQsViewController = [[FAQsViewController alloc] initWithNibName:@"FAQsViewController" bundle:nil];
        [self.navigationController pushViewController:obj_FAQsViewController animated:YES];
    }
    else if (indexPath.row==7)
    {
        FirstAdViewController *obj_FirstAdViewController = [[FirstAdViewController alloc] initWithNibName:@"FirstAdViewController" bundle:nil];
        [self.navigationController pushViewController:obj_FirstAdViewController animated:YES];
    }
    else if (indexPath.row==8)
    {
        MyMedicationProfileViewController *obj_MyMedicationProfileViewController = [[MyMedicationProfileViewController alloc] initWithNibName:@"MyMedicationProfileViewController" bundle:nil];
        [self.navigationController pushViewController:obj_MyMedicationProfileViewController animated:YES];
    }
    else if (indexPath.row==9)
    {
        DrugInformationViewController *obj_DrugInformationViewController = [[DrugInformationViewController alloc] initWithNibName:@"DrugInformationViewController" bundle:nil];
        [self.navigationController pushViewController:obj_DrugInformationViewController animated:YES];
    }
    else if (indexPath.row==10)
    {
        SettingsViewController *obj_SettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:obj_SettingsViewController animated:YES];
    }
    else if (indexPath.row==11)
    {
        [self BackClicked];
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
