//
//  SIGNINViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/20/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "SIGNINViewController.h"
#import "IQKeyboardManager.h"

@interface SIGNINViewController ()

@end

@implementation SIGNINViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([self.str_SignINorUP isEqualToString:@"SIGNIN"]) {
        self.view_SignIN.hidden=FALSE;
        self.view_SignUP.hidden=TRUE;
    }
    else {
        self.view_SignIN.hidden=TRUE;
        self.view_SignUP.hidden=FALSE;
    }
}
#pragma mark IBAction Methods
-(IBAction)SignINViewClicked
{
    self.view_SignIN.hidden=FALSE;
    self.view_SignUP.hidden=TRUE;
}
-(IBAction)SignUPViewClicked
{
    self.view_SignIN.hidden=TRUE;
    self.view_SignUP.hidden=FALSE;
}
-(IBAction)LoginClicked
{
    obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:obj_HomeViewController animated:YES];
}
-(IBAction)RememberMeClicked
{
    
}
-(IBAction)ForgotPasswordClicked
{
    
}
-(IBAction)BackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITextField Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.txt_EmailID]) {
        [self.lbl_EmailIDLine setBackgroundColor:[UIColor blackColor]];
        [self.lbl_PasswordLine setBackgroundColor:[UIColor lightGrayColor]];
    }
    else if ([textField isEqual:self.txt_Password])
    {
        [self.lbl_EmailIDLine setBackgroundColor:[UIColor lightGrayColor]];
        [self.lbl_PasswordLine setBackgroundColor:[UIColor blackColor]];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
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
