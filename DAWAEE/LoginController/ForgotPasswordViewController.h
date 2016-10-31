//
//  ForgotPasswordViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController
@property (nonatomic,strong) IBOutlet UITextField *txt_EmailId;
@property (nonatomic,strong) NSMutableString *placeholder_emailid;
@property (nonatomic,strong) IBOutlet UIButton *btn_ResetPassword;
-(IBAction)Back;
-(IBAction)ResetPasswordClicked;
@end
