//
//  AppointmentsViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/17/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentsViewController : UIViewController
{
    NSUserDefaults *prefs;
    NSString *str_Language;
    AppDelegate *appDelegate;
}
@property (nonatomic,strong) NSMutableArray *ary_Appointments;
@property (nonatomic,strong) IBOutlet UITableView *tbl_Appointments;
@property (nonatomic,strong) IBOutlet UIButton *btn_RescheduleAppointments,*btn_CancelAppointments;
@property (nonatomic,strong) IBOutlet UIView *view_RescheduleAppointments,*view_Gradient;


// For Reschedule view
@property (nonatomic,strong) IBOutlet UILabel *lbl_Time,*lbl_Day,*lbl_Date,*lbl_Month,*lbl_Year,*lbl_Speciality,*lbl_Location;
@property (nonatomic,strong) NSDate *date_ToPass;
-(IBAction)Back;
-(IBAction)RescheduleAppointmentClicked;
@end
