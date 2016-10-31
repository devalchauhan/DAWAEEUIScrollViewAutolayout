//
//  MYIDLoginViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYIDLoginViewController : UIViewController
{
    NSUserDefaults *prefs;
    NSString *str_Language;
    AppDelegate *appDelegate;
}
@property (nonatomic,strong) IBOutlet UIButton *btn_Login;
@property (nonatomic,strong) IBOutlet UITextField *txt_MYID,*txt_Password;
@property (nonatomic,strong) NSAttributedString *placeholder_myid,*placeholder_password;
-(IBAction)Back;
-(IBAction)LoginClicked;
@end
