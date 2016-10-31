//
//  RegisterViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/23/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSAttributedString *str_ForgotPassword = [[NSAttributedString alloc] initWithString:@"Forgot Password?"
                                                                             attributes:underlineAttribute];
    
    
    [self.btn_CreateAnAccount.layer setCornerRadius:25.0f];
    [self.btn_CreateAnAccount.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.btn_CreateAnAccount.layer setShadowOpacity:0.5];
    [self.btn_CreateAnAccount.layer setShadowRadius:2.0];
    [self.btn_CreateAnAccount.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont fontWithName:@"Arial" size:16.0],
                               NSForegroundColorAttributeName : [UIColor whiteColor]
                               };
    _placeholder_userid = [[NSAttributedString alloc] initWithString:@"User ID" attributes:attrDict];
    _txt_UserID.attributedPlaceholder = _placeholder_userid;
    _placeholder_password = [[NSAttributedString alloc] initWithString:@"Password" attributes:attrDict];
    _txt_Password.attributedPlaceholder = _placeholder_password;
    _placeholder_Email = [[NSAttributedString alloc] initWithString:@"Email" attributes:attrDict];
    _txt_Email.attributedPlaceholder = _placeholder_Email;
    _placeholder_SQ = [[NSAttributedString alloc] initWithString:@"Security Question" attributes:attrDict];
    _txt_SecurityQuestion.attributedPlaceholder = _placeholder_SQ;
    _placeholder_SA = [[NSAttributedString alloc] initWithString:@"Security Answer" attributes:attrDict];
    _txt_SecurityAnswer.attributedPlaceholder = _placeholder_SA;
    
    CGSize scrollableSize = CGSizeMake(320, _scrl_Main.frame.size.height);
    [_scrl_Main setContentSize:scrollableSize];
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
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
