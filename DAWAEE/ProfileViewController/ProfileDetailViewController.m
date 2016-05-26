//
//  ProfileDetailViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 4/26/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "ProfileDetailViewController.h"
#import "AddProfileViewController.h"
@interface ProfileDetailViewController ()

@end

@implementation ProfileDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view_ProfileDetails.bounds];
    self.view_ProfileDetails.layer.masksToBounds = NO;
    self.view_ProfileDetails.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_ProfileDetails.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_ProfileDetails.layer.shadowOpacity = 0.5f;
    self.view_ProfileDetails.layer.shadowPath = shadowPath.CGPath;
}

-(IBAction)AddProfileClicked
{
    AddProfileViewController *obj_AddProfileViewController = [[AddProfileViewController alloc] initWithNibName:@"AddProfileViewController" bundle:nil];
    [self.navigationController presentViewController:obj_AddProfileViewController animated:YES completion:nil];
}
-(IBAction)EditProfileClicked
{
    AddProfileViewController *obj_AddProfileViewController = [[AddProfileViewController alloc] initWithNibName:@"AddProfileViewController" bundle:nil];
    [self.navigationController presentViewController:obj_AddProfileViewController animated:YES completion:nil];
}

-(IBAction)BackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
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
