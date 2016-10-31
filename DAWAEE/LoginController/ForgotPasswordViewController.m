//
//  ForgotPasswordViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn_ResetPassword.layer setCornerRadius:25.0f];
    [self.btn_ResetPassword.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.btn_ResetPassword.layer setShadowOpacity:0.5];
    [self.btn_ResetPassword.layer setShadowRadius:2.0];
    [self.btn_ResetPassword.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont fontWithName:@"Arial" size:16.0],
                               NSForegroundColorAttributeName : [UIColor whiteColor]
                               };
    _placeholder_emailid = [[NSAttributedString alloc] initWithString:@"Your Email Address" attributes:attrDict];
    _txt_EmailId.attributedPlaceholder = _placeholder_emailid;
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)ResetPasswordClicked
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
