//
//  RegisterViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/23/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (nonatomic,strong) IBOutlet UIButton *btn_CreateAnAccount;
@property (nonatomic,strong) IBOutlet UITextField *txt_UserID,*txt_Password,*txt_Email,*txt_SecurityQuestion,*txt_SecurityAnswer;
@property (nonatomic,strong) NSAttributedString *placeholder_userid,*placeholder_password,*placeholder_Email,*placeholder_SQ,*placeholder_SA;
@property (nonatomic,strong) IBOutlet UIScrollView *scrl_Main;
@end
