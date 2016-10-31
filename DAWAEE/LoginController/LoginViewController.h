//
//  LoginViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/23/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    NSUserDefaults *prefs;
    NSString *str_Language;
    AppDelegate *appDelegate;
}
@property (nonatomic,strong) IBOutlet UILabel *lbl_ForgotPassword;
@property (nonatomic,strong) IBOutlet UIButton *btn_Login,*btn_ForgotPassword,*btn_Register;
@property (nonatomic,strong) IBOutlet UITextField *txt_UserID,*txt_Password;
@property (nonatomic,strong) NSAttributedString *placeholder_userid,*placeholder_password;
-(IBAction)Back;
-(IBAction)RegisteClicked;
-(IBAction)ForgotPasswordClicked;
-(IBAction)LoginClicked;
@end
