//
//  AddMedicationViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 5/15/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMedicationViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    IBOutlet NSLayoutConstraint *ViewHeightConstraint;
    IBOutlet UITextField *txt_Frequency;
    UIPickerView *pv_Frequency,*pv_PillsReminder;
    NSMutableArray *ary_Frequency,*ary_ReminderValues,*ary_Times,*ary_TimesDB,*ary_PillsReminder;
    IBOutlet UIDatePicker *timePicker,*datePicker;
    
}
@property (nonatomic,weak) IBOutlet UIScrollView *scrl;
@property (nonatomic,weak) IBOutlet UIView *view_SCRLContainer,*view_Medication,*view_Reminders,*view_Dosage,*view_Schedule,*view_Instruction,*view_Gradient,*view_Rescheduler,*view_NumberOfDays,*view_SpecificDaysOfWeek;


-(IBAction)BackClicked;

//DoseView
@property (nonatomic,weak) IBOutlet UITextField *txt_PillsReminder;

//MedicationView
@property (nonatomic,weak) IBOutlet UITextField *txt_MedicationName;
@property (nonatomic,weak) IBOutlet UILabel *lbl_MedicationName;
@property (nonatomic,weak) IBOutlet UIButton *btn_Picture,*btn_DHACheck;
-(IBAction)PictureClicked;
-(IBAction)DHACheckClicked;

//RechulderView
@property (nonatomic,weak) IBOutlet UIButton *btn_Cancel,*btn_Set,*btn_Plus,*btn_Minus;
@property (nonatomic,weak) IBOutlet UITextField *txt_Dose;
@property (nonatomic,readwrite) float Dose;
@property (nonatomic,readwrite) long TimeDose_IndexToUpdate;
@property (nonatomic, weak) NSString *TimeToUpdate;
-(IBAction)CancelClicked;
-(IBAction)SetClicked;
-(IBAction)PlusClicked;
-(IBAction)MinusClicked;

//ScheduleView
@property (nonatomic,weak) NSString *str_SpecificDaysValue,*str_FlagNDorDI;
@property (nonatomic,weak) IBOutlet UILabel *lbl_NumberOfDays,*lbl_SpecificDays,*lbl_DaysInterval;
@property (nonatomic,readwrite) float NumberOfDays,DaysInterval;
@property (nonatomic,weak) IBOutlet UIView *view_DatePicker;
@property (nonatomic,weak) IBOutlet UITextField *txt_StartDate,*txt_NumberOfDays;
@property (nonatomic,weak) IBOutlet UIButton *btn_DoneDatePicker,*btn_CancelDatePicker,*btn_Continuous,*btn_NumberOfDays,*btn_EveryDay,*btn_SpecificDays,*btn_DaysInterval;
@property (nonatomic,weak) IBOutlet UIButton *btn_Sunday,*btn_Monday,*btn_Tuesday,*btn_Wednesday,*btn_Thursday,*btn_Friday,*btn_Saturday;
-(IBAction)DoneDatePickerClicked;
-(IBAction)ContinuousClicked;
-(IBAction)NumbersOfDaysClicked;
-(IBAction)CancelNumberOfDaysClicked;
-(IBAction)SetNumberOfDaysClicked;
-(IBAction)MinusNumberOfDaysClicked;
-(IBAction)PlusNumberOfDaysClicked;
-(IBAction)EveryDayClicked;
-(IBAction)SpecificDaysClicked;
-(IBAction)DaysIntervalClicked;
-(IBAction)SundayClicked;
-(IBAction)MondayClicked;
-(IBAction)TuesdayClicked;
-(IBAction)WednesdayClicked;
-(IBAction)ThursdayClicked;
-(IBAction)FridayClicked;
-(IBAction)SaturdayClicked;
-(IBAction)CancelSpecificDayClicked;
-(IBAction)SetSpecificDayClicked;
@end
