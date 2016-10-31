//
//  FacilityDetailsViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/12/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "FacilityDetailsViewController.h"

@interface FacilityDetailsViewController ()

@end

@implementation FacilityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrl_Main.scrollsToTop= NO;
    [self.lbl_OpenStatus.layer setCornerRadius:3.0f];
    self.lbl_OpenStatus.clipsToBounds=YES;
    
    [self.btn_DrivingDirection.layer setCornerRadius:15.0f];
    [self.btn_DrivingDirection.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.btn_DrivingDirection.layer setBorderWidth:1.0f];
    
    
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)FavoriteClicked
{
    
}
-(IBAction)ShareClicked
{
    
}
-(IBAction)FacilityDetailsClicked
{
    self.view_FacilityDetails.hidden=FALSE;
    self.view_Specialities.hidden=TRUE;
}
-(IBAction)SpecialitiesCliked
{
    self.view_FacilityDetails.hidden=TRUE;
    self.view_Specialities.hidden=FALSE;
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
