//
//  SettingsViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 4/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "SettingsViewController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "PharmaciesViewController.h"
#import "MedicineDeliveryViewController.h"
#import "AskYourPharmacistViewController.h"
#import "NewsArticlesViewController.h"
#import "FAQsViewController.h"
#import "FirstAdViewController.h"
#import "MyMedicationProfileViewController.h"
#import "DrugInformationViewController.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    
    
}
-(IBAction)HomeClicked
{
    self.view_Gradient.hidden=FALSE;
    self.view_Menu.hidden=FALSE;
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

#pragma mark UITableView Delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.ary_Menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"eventCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.textLabel.text = [self.ary_Menu objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.0 weight:UIFontWeightSemibold]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.ary_Menu objectAtIndex:indexPath.row]]];
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
        MedicineDeliveryViewController *obj_MedicineDeliveryViewController = [[MedicineDeliveryViewController alloc] initWithNibName:@"MedicineDeliveryViewController" bundle:nil];
        [self.navigationController pushViewController:obj_MedicineDeliveryViewController animated:YES];
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
