//
//  HCLoginViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCLoginViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

{
    NSMutableArray *years;
    UIPickerView *pickerView;
    NSUserDefaults *prefs;
    NSString *str_Language;
    AppDelegate *appDelegate;
}
@property (nonatomic,strong) IBOutlet UITextField *txt_HealthCard,*txt_YOB,*txt_SMS;
@property (nonatomic,strong) NSAttributedString *placeholder_healthcard,*placeholder_yob,*placeholder_sms;
@property (nonatomic,strong) IBOutlet UILabel *lbl_HealthCardLine,*lbl_HealthCardStatic,*lbl_YOBLine,*lbl_SMSLine;
@property (nonatomic,strong) IBOutlet UIButton *btn_Login,*btn_ALLLogin;
@property (readwrite) BOOL flag_HCLogin;

@property (nonatomic,weak) IBOutlet UIButton *btn_pickerDone,*btn_pickerCancel;
@property (nonatomic,weak) IBOutlet UIView *view_PickerTool;


-(IBAction)AllLoginClicked;
-(IBAction)Loginclicked;
@end
