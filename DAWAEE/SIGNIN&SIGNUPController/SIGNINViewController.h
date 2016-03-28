//
//  SIGNINViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/20/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
@interface SIGNINViewController : UIViewController
{
    HomeViewController *obj_HomeViewController;
}
@property (nonatomic,strong) IBOutlet UIButton *btn_SignIn,*btn_SignUp,*btn_Login,*btn_RememberMe,*btn_ForgotPassword;
@property (nonatomic,strong) IBOutlet UITextField *txt_EmailID,*txt_Password;
@property (nonatomic,strong) IBOutlet UIView *view_SignIN,*view_SignUP;
@property (nonatomic,strong) IBOutlet UILabel *lbl_EmailIDLine,*lbl_PasswordLine;

@property (nonatomic,strong) NSString *str_SignINorUP;
-(IBAction)SignINViewClicked;
-(IBAction)SignUPViewClicked;
-(IBAction)LoginClicked;
-(IBAction)RememberMeClicked;
-(IBAction)ForgotPasswordClicked;
-(IBAction)BackClicked;
@end
