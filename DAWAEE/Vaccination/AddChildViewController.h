//
//  AddChildViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/9/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddChildViewController : UIViewController
{
    IBOutlet UIButton *btn_Gender,*btn_AddChild;
    NSString *str_Gender,*str_Language;
    NSUserDefaults *prefs;
    AppDelegate *appDelegate;
}
@property (nonatomic,strong) IBOutlet UITextField *txt_ChildName,*txt_ChildDOB;
@property (nonatomic,strong) NSAttributedString *placeholder_childname,*placeholder_childdob;


@property (nonatomic,weak) IBOutlet UIButton *btn_pickerDone,*btn_pickerCancel;
@property (nonatomic,weak) IBOutlet UIView *view_PickerTool;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
-(IBAction)Back;
-(IBAction)genderClicked:(id)sender;
-(IBAction)AddPhotoClicked;
-(IBAction)AddChildClicked;
@end
