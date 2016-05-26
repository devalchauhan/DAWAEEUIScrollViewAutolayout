//
//  AddMedicationViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 5/15/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "AddMedicationViewController.h"
#import "Constants.h"
@interface AddMedicationViewController ()

@end

@implementation AddMedicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view_Gradient addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideMenu)]];
    //self.view_Rescheduler.layer.cornerRadius = 5.0f;
    
    _Dose = 1.00;
    _NumberOfDays = 01;
    _DaysInterval = 01;
    self.str_SpecificDaysValue = @"";
    self.lbl_NumberOfDays.text = @"";
    self.lbl_DaysInterval.text = @"";
    
    self.txt_Dose.text = [NSString stringWithFormat:@"%.2f",_Dose];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
    [timePicker setLocale:locale];
    [timePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

    pv_Frequency = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    [pv_Frequency setDataSource:self];
    [pv_Frequency setDelegate:self];
    pv_Frequency.backgroundColor = [UIColor whiteColor];
    txt_Frequency.inputView = pv_Frequency;
    
    pv_PillsReminder = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    [pv_PillsReminder setDataSource:self];
    [pv_PillsReminder setDelegate:self];
    pv_PillsReminder.backgroundColor = [UIColor whiteColor];
    self.txt_PillsReminder.inputView = pv_PillsReminder;
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setBackgroundColor:[UIColor whiteColor]];
    [datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.txt_StartDate.inputView = datePicker;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE dd/MM/yyyy"];
    self.txt_StartDate.text = [dateFormatter stringFromDate:datePicker.date];

    
    ary_PillsReminder = [NSMutableArray array];
    [ary_PillsReminder addObject:@"No reminder"];
    [ary_PillsReminder addObject:@"2 pills remaining"];
    [ary_PillsReminder addObject:@"5 pills remaining"];
    [ary_PillsReminder addObject:@"10 pills remaining"];
    [ary_PillsReminder addObject:@"15 pills remaining"];
    [ary_PillsReminder addObject:@"20 pills remaining"];
    [ary_PillsReminder addObject:@"30 pills remaining"];
    
    ary_Frequency = [NSMutableArray array];
    [ary_Frequency addObject:@"FREQUENCY"];
    [ary_Frequency addObject:@"Once a Day"];
    [ary_Frequency addObject:@"Twice a Day"];
    [ary_Frequency addObject:@"3 Times a Day"];
    [ary_Frequency addObject:@"4 Times a Day"];
    [ary_Frequency addObject:@"5 Times a Day"];
    [ary_Frequency addObject:@"6 Times a Day"];
    [ary_Frequency addObject:@"7 Times a Day"];
    [ary_Frequency addObject:@"8 Times a Day"];
    [ary_Frequency addObject:@"9 Times a Day"];
    [ary_Frequency addObject:@"10 Times a Day"];
    [ary_Frequency addObject:@"11 Times a Day"];
    [ary_Frequency addObject:@"12 Times a Day"];
    [ary_Frequency addObject:@"INTERVALS"];
    [ary_Frequency addObject:@"Every Hour"];
    [ary_Frequency addObject:@"Every 2 Hours"];
    [ary_Frequency addObject:@"Every 4 Hours"];
    [ary_Frequency addObject:@"Every 6 Hours"];
    [ary_Frequency addObject:@"Every 8 Hours"];
    [ary_Frequency addObject:@"Every 10 Hours"];
    [ary_Frequency addObject:@"Every 12 Hours"];
    
    ary_ReminderValues = [NSMutableArray array];
    [ary_ReminderValues addObject:@"1"];
    [ary_ReminderValues addObject:@"1"];
    [ary_ReminderValues addObject:@"2"];
    [ary_ReminderValues addObject:@"3"];
    [ary_ReminderValues addObject:@"4"];
    [ary_ReminderValues addObject:@"5"];
    [ary_ReminderValues addObject:@"6"];
    [ary_ReminderValues addObject:@"7"];
    [ary_ReminderValues addObject:@"8"];
    [ary_ReminderValues addObject:@"9"];
    [ary_ReminderValues addObject:@"10"];
    [ary_ReminderValues addObject:@"11"];
    [ary_ReminderValues addObject:@"12"];
    ////INTERVAL
    [ary_ReminderValues addObject:@"12"];
    [ary_ReminderValues addObject:@"1"];
    [ary_ReminderValues addObject:@"2"];
    [ary_ReminderValues addObject:@"4"];
    [ary_ReminderValues addObject:@"6"];
    [ary_ReminderValues addObject:@"8"];
    [ary_ReminderValues addObject:@"10"];
    [ary_ReminderValues addObject:@"12"];
    
    [self ViewArrange:150];
    
}

-(void)ViewArrange:(long)Height
{
    
    ViewHeightConstraint.constant = Height;
    
    [self.view setNeedsUpdateConstraints];
    float i= Height+660+157;
    [self.scrl setContentSize:CGSizeMake(10, i)];
    self.scrl.translatesAutoresizingMaskIntoConstraints  = NO;
    
    self.view_SCRLContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrl addSubview:self.view_SCRLContainer];
    
    NSDictionary *views = @{@"beeView":self.view_SCRLContainer};
    if (IS_IPHONE_5) {
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @304};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6){
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @359};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6Plus){
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @398};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view_Medication.bounds];
    self.view_Medication.layer.masksToBounds = NO;
    self.view_Medication.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_Medication.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_Medication.layer.shadowOpacity = 0.5f;
    self.view_Medication.layer.shadowPath = shadowPath.CGPath;
    
    UIBezierPath *shadowPath1 = [UIBezierPath bezierPathWithRect:self.view_Reminders.bounds];
    self.view_Reminders.layer.masksToBounds = NO;
    self.view_Reminders.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_Reminders.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_Reminders.layer.shadowOpacity = 0.5f;
    self.view_Reminders.layer.shadowPath = shadowPath1.CGPath;
    
    UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRect:self.view_Dosage.bounds];
    self.view_Dosage.layer.masksToBounds = NO;
    self.view_Dosage.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_Dosage.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_Dosage.layer.shadowOpacity = 0.5f;
    self.view_Dosage.layer.shadowPath = shadowPath2.CGPath;
    
    UIBezierPath *shadowPath3 = [UIBezierPath bezierPathWithRect:self.view_Schedule.bounds];
    self.view_Schedule.layer.masksToBounds = NO;
    self.view_Schedule.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_Schedule.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_Schedule.layer.shadowOpacity = 0.5f;
    self.view_Schedule.layer.shadowPath = shadowPath3.CGPath;
    
    UIBezierPath *shadowPath4 = [UIBezierPath bezierPathWithRect:self.view_Instruction.bounds];
    self.view_Instruction.layer.masksToBounds = NO;
    self.view_Instruction.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_Instruction.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_Instruction.layer.shadowOpacity = 0.5f;
    self.view_Instruction.layer.shadowPath = shadowPath4.CGPath;
    
    int x=8,y=84;
    for (UIView *subview in self.view_Reminders.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
    ary_TimesDB = [NSMutableArray array];
    for (int i=0; i<[ary_Times count]; i++) {
        float time = [[ary_Times objectAtIndex:i] floatValue]/60;
        NSString *str_btnTitle = [NSString stringWithFormat:@"%.2f",time];
        NSMutableDictionary *mdic_Time = [NSMutableDictionary dictionary];
        [mdic_Time setValue:[str_btnTitle stringByReplacingOccurrencesOfString:@"." withString:@":"] forKey:@"Time"];
        [mdic_Time setValue:@"1.00" forKey:@"Dose"];
        [mdic_Time setValue:[ary_Times objectAtIndex:i] forKey:@"TimeForDB"];
        [ary_TimesDB addObject:mdic_Time];
    }
    for (int i=0; i<ary_TimesDB.count; i++) {
        UIButton *btn_Time = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_Time setFrame:CGRectMake(x, y, 90, 21)];
        [btn_Time setTitle:[[ary_TimesDB objectAtIndex:i] valueForKey:@"Time"] forState:UIControlStateNormal];
        btn_Time.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [btn_Time setTitleColor:[UIColor colorWithRed:(25.0/255.0) green:(169.0/255.0) blue:(191.0/255.0) alpha:1.0] forState:UIControlStateNormal];
        btn_Time.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn_Time.tag = i;
        [btn_Time addTarget:self action:@selector(ChangeTimeDose:) forControlEvents:UIControlEventTouchUpInside];
        [self.view_Reminders addSubview:btn_Time];
        
        
        UIButton *btn_Dose = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_Dose setFrame:CGRectMake(self.view_Reminders.frame.size.width-103, y, 95, 21)];
        [btn_Dose setTitle:[NSString stringWithFormat:@"Take %@",[[ary_TimesDB objectAtIndex:i] valueForKey:@"Dose"]] forState:UIControlStateNormal];
        btn_Dose.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btn_Dose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn_Dose setTitleColor:[UIColor colorWithRed:(25.0/255.0) green:(169.0/255.0) blue:(191.0/255.0) alpha:1.0] forState:UIControlStateNormal];
        btn_Dose.tag = i;
        [btn_Dose addTarget:self action:@selector(ChangeTimeDose:) forControlEvents:UIControlEventTouchUpInside];
        [self.view_Reminders addSubview:btn_Dose];
        
        y+=30;
    }
    
}
-(void)ChangeTimeDose:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    _TimeDose_IndexToUpdate = btn.tag;
    NSString *str_Time = [NSString stringWithFormat:@"%@:00",[[ary_TimesDB objectAtIndex:btn.tag] valueForKey:@"Time"]];
    NSLog(@"%@",str_Time);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc]
                           initWithLocaleIdentifier:@"NL"]];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *generatedDate = [formatter dateFromString:str_Time];
    NSLog(@"%@", [formatter stringFromDate:generatedDate]);
    
    
    [timePicker setDate:generatedDate animated:YES];
    self.view_Gradient.hidden=FALSE;
    self.view_Rescheduler.hidden=FALSE;
}

- (void)dateChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    _TimeToUpdate = [dateFormatter stringFromDate:timePicker.date];
    NSLog(@"%@", _TimeToUpdate);
}
- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    /*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE dd/MM/yyyy"];
    self.txt_StartDate.text = [dateFormatter stringFromDate:datePicker.date];*/
}
-(void)FrequencyCalculater:(int)mReminderValue mReminderType:(NSString*)mReminderType
{
    
    double resultantValue = 1, resultantTime = 8;
    int hoursOfDay = 24;
    mReminderValue = mReminderValue;
    double diff = hoursOfDay / mReminderValue;
    resultantValue = (hoursOfDay - 8) / mReminderValue;
    if ([mReminderType isEqualToString:@"FREQUENCY"]) {
        ary_Times = [NSMutableArray array];
        [ary_Times addObject:@"480.000000"];
        for (int index = 0; index < mReminderValue; index++) {
            int hoursLeft = 15 * 60;
            //int interval = 0;
            //if(mReminderValue != 1) {
            //resultantTime = hoursLeft / (mReminderValue-1);
            //}
            
            if (index == 0) {
                resultantTime = (8) * 60;
            } else {
                if (diff == 24) {
                    diff = 0;
                }
                resultantTime = ((hoursLeft / (mReminderValue - 1)) * index);
                resultantTime = (8 * 60) + resultantTime;
                [ary_Times addObject:[NSString stringWithFormat:@"%f",resultantTime]];
                
            }
            
        }
        NSLog(@"ary_Times : %@",ary_Times);
    } else if ([mReminderType isEqualToString:@"INTERVAL"]) {
        ary_Times = [NSMutableArray array];
        /// interval formula...
        int times = hoursOfDay / mReminderValue;
        diff = mReminderValue;
        
        /*if (!isEditInit && !isRefresh) {
            mDoseTimeArray = new long[times];
            mDoseIntakeArray = new double[times];
        }*/
        for (int index = 0; index < times; index++) {
            
            if (index == 0) {
                resultantTime = (8) * 60;
            } else {
                resultantTime = (8 + (diff * index)) * 60;
                resultantTime = resultantTime > 1440 ? resultantTime - 1440 : resultantTime;
            }
            [ary_Times addObject:[NSString stringWithFormat:@"%f",resultantTime]];
           
        }
        NSLog(@"ary_Times : %@",ary_Times);
    }
    long ViewHeight = 150;
    if (ary_Times.count>1) {
        ViewHeight = ([ary_Times count]*30)+130;
    }
    
    [self ViewArrange:ViewHeight];
}


-(void)HideMenu
{
    self.view_Gradient.hidden=TRUE;
    self.view_Rescheduler.hidden=TRUE;
    self.view_NumberOfDays.hidden=TRUE;
    self.view_SpecificDaysOfWeek.hidden=TRUE;
}

#pragma mark UITextField Delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.txt_StartDate]) {
        self.view_DatePicker.hidden=FALSE;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
#pragma mark ScheduleView Methods
-(IBAction)CancelDatePicker
{
    self.view_DatePicker.hidden=TRUE;
    self.txt_StartDate.text=@"";
    [self.txt_StartDate resignFirstResponder];
}
-(IBAction)DoneDatePickerClicked
{
    self.view_DatePicker.hidden=TRUE;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE dd/MM/yyyy"];
    self.txt_StartDate.text = [dateFormatter stringFromDate:datePicker.date];
    [self.txt_StartDate resignFirstResponder];
}
-(IBAction)ContinuousClicked
{
    [self.btn_Continuous setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateNormal];
    [self.btn_NumberOfDays setImage:[UIImage imageNamed:@"UnSelected.png"] forState:UIControlStateNormal];
    self.lbl_NumberOfDays.text = @"";
    _NumberOfDays = 1;
}
-(IBAction)NumbersOfDaysClicked
{
    [self.btn_Continuous setImage:[UIImage imageNamed:@"UnSelected.png"] forState:UIControlStateNormal];
    [self.btn_NumberOfDays setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateNormal];
    self.view_NumberOfDays.hidden=FALSE;
    self.view_Gradient.hidden=FALSE;
    self.lbl_NumberOfDays.text = [NSString stringWithFormat:@"%.0f",_NumberOfDays];
    self.txt_NumberOfDays.text = [NSString stringWithFormat:@"%@",self.lbl_NumberOfDays.text];
    self.str_FlagNDorDI = @"ND";
}
-(IBAction)CancelNumberOfDaysClicked
{
    self.view_Gradient.hidden=TRUE;
    self.view_NumberOfDays.hidden=TRUE;
    if ([self.str_FlagNDorDI isEqualToString:@"ND"]) {
        _NumberOfDays = [self.lbl_NumberOfDays.text floatValue];
    }
    else {
        _DaysInterval = [self.lbl_DaysInterval.text floatValue];
    }
}
-(IBAction)SetNumberOfDaysClicked
{
    
    if ([self.str_FlagNDorDI isEqualToString:@"ND"]) {
        self.lbl_NumberOfDays.text = [NSString stringWithFormat:@"%@",self.txt_NumberOfDays.text];
    }
    else {
        NSString *str_StartDateToPass = self.txt_StartDate.text;
        NSString *str_DaysIntervalValue= @"";
        for (int i=0; i<5; i++) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE dd/MM/yyyy"];
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",str_StartDateToPass]];
            NSDate *nextDate = [NSDate dateWithTimeInterval:(24*60*60*_DaysInterval) sinceDate:date];
            NSString *str_NextDate = [dateFormatter stringFromDate:nextDate];
            str_StartDateToPass = str_NextDate;
            NSLog(@"%@",str_NextDate);
            NSArray *ary_Temp = [str_NextDate componentsSeparatedByString:@" "];
            str_DaysIntervalValue = [str_DaysIntervalValue stringByAppendingString:[NSString stringWithFormat:@", %@",[ary_Temp objectAtIndex:0]]];
        }
        
        self.lbl_DaysInterval.text = [NSString stringWithFormat:@"%@ %@",self.txt_NumberOfDays.text,str_DaysIntervalValue];
    }
    [self.txt_NumberOfDays resignFirstResponder];
    self.view_Gradient.hidden=TRUE;
    self.view_NumberOfDays.hidden=TRUE;
    
}
-(IBAction)MinusNumberOfDaysClicked
{
    if ([self.str_FlagNDorDI isEqualToString:@"ND"]) {
        _NumberOfDays-=01;
        self.txt_NumberOfDays.text = [NSString stringWithFormat:@"%.0f",_NumberOfDays];
    }
    else {
        _DaysInterval-=01;
        self.txt_NumberOfDays.text = [NSString stringWithFormat:@"%.0f",_DaysInterval];
    }
}
-(IBAction)PlusNumberOfDaysClicked
{
    if ([self.str_FlagNDorDI isEqualToString:@"ND"]) {
        _NumberOfDays+=01;
        self.txt_NumberOfDays.text = [NSString stringWithFormat:@"%.0f",_NumberOfDays];
    }
    else {
        _DaysInterval+=01;
        self.txt_NumberOfDays.text = [NSString stringWithFormat:@"%.0f",_DaysInterval];
    }
}
-(IBAction)EveryDayClicked
{
    [self.btn_EveryDay setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateNormal];
    [self.btn_SpecificDays setImage:[UIImage imageNamed:@"UnSelected.png"] forState:UIControlStateNormal];
    [self.btn_DaysInterval setImage:[UIImage imageNamed:@"UnSelected.png"] forState:UIControlStateNormal];
    self.lbl_SpecificDays.text = @"";
    self.lbl_DaysInterval.text = @"";
}
-(IBAction)SpecificDaysClicked
{
    [self.btn_EveryDay setImage:[UIImage imageNamed:@"UnSelected.png"] forState:UIControlStateNormal];
    [self.btn_SpecificDays setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateNormal];
    [self.btn_DaysInterval setImage:[UIImage imageNamed:@"UnSelected.png"] forState:UIControlStateNormal];
    self.view_Gradient.hidden=FALSE;
    self.view_SpecificDaysOfWeek.hidden=FALSE;
    self.str_SpecificDaysValue = @"";
}

-(IBAction)SundayClicked
{
    if (self.btn_Sunday.selected==TRUE)
        self.btn_Sunday.selected=FALSE;
    else
        self.btn_Sunday.selected=TRUE;
}
-(IBAction)MondayClicked
{
    if (self.btn_Monday.selected==TRUE)
        self.btn_Monday.selected=FALSE;
    else
        self.btn_Monday.selected=TRUE;
}
-(IBAction)TuesdayClicked
{
    if (self.btn_Tuesday.selected==TRUE)
        self.btn_Tuesday.selected=FALSE;
    else
        self.btn_Tuesday.selected=TRUE;
}
-(IBAction)WednesdayClicked
{
    if (self.btn_Wednesday.selected==TRUE)
        self.btn_Wednesday.selected=FALSE;
    else
        self.btn_Wednesday.selected=TRUE;
}
-(IBAction)ThursdayClicked
{
    if (self.btn_Thursday.selected==TRUE)
        self.btn_Thursday.selected=FALSE;
    else
        self.btn_Thursday.selected=TRUE;
}
-(IBAction)FridayClicked
{
    if (self.btn_Friday.selected==TRUE)
        self.btn_Friday.selected=FALSE;
    else
        self.btn_Friday.selected=TRUE;
}
-(IBAction)SaturdayClicked
{
    if (self.btn_Saturday.selected==TRUE)
        self.btn_Saturday.selected=FALSE;
    else
        self.btn_Saturday.selected=TRUE;
}
-(IBAction)CancelSpecificDayClicked
{
    self.view_Gradient.hidden=TRUE;
    self.view_SpecificDaysOfWeek.hidden=TRUE;
}
-(IBAction)SetSpecificDayClicked
{
    NSMutableArray *ary = [NSMutableArray array];
    self.view_Gradient.hidden=TRUE;
    self.view_SpecificDaysOfWeek.hidden=TRUE;
    if (self.btn_Sunday.selected)
        [ary addObject:@"Sun"];
    if (self.btn_Monday.selected)
        [ary addObject:@"Mon"];
    if (self.btn_Tuesday.selected)
        [ary addObject:@"Tue"];
    if (self.btn_Wednesday.selected)
        [ary addObject:@"Wed"];
    if (self.btn_Thursday.selected)
        [ary addObject:@"Thu"];
    if (self.btn_Friday.selected)
        [ary addObject:@"Fri"];
    if (self.btn_Saturday.selected)
        [ary addObject:@"Sat"];
    
    self.str_SpecificDaysValue = [ary componentsJoinedByString:@","];
    NSLog(@"%@",self.str_SpecificDaysValue);
    self.lbl_SpecificDays.text = self.str_SpecificDaysValue;
}

-(IBAction)DaysIntervalClicked
{
    [self.btn_EveryDay setImage:[UIImage imageNamed:@"UnSelected.png"] forState:UIControlStateNormal];
    [self.btn_SpecificDays setImage:[UIImage imageNamed:@"UnSelected.png"] forState:UIControlStateNormal];
    [self.btn_DaysInterval setImage:[UIImage imageNamed:@"Selected.png"] forState:UIControlStateNormal];
    self.view_Gradient.hidden=FALSE;
    self.view_NumberOfDays.hidden=FALSE;
    self.str_FlagNDorDI = @"DI";
}
-(IBAction)BackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UIPickerView Delegates
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    if ([pickerView isEqual:pv_Frequency]) {
        txt_Frequency.text = [NSString stringWithFormat:@"%@",[ary_Frequency objectAtIndex:row]];
        [txt_Frequency resignFirstResponder];
        if (row<=12)
            [self FrequencyCalculater:[[ary_ReminderValues objectAtIndex:row] intValue] mReminderType:@"FREQUENCY"];
        else
            [self FrequencyCalculater:[[ary_ReminderValues objectAtIndex:row] intValue] mReminderType:@"INTERVAL"];
        }
    else {
        self.txt_PillsReminder.text = [NSString stringWithFormat:@"%@",[ary_PillsReminder objectAtIndex:row]];
        [self.txt_PillsReminder resignFirstResponder];
    }
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:pv_Frequency])
        return [ary_Frequency count];
    else
        return [ary_PillsReminder count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
     if ([pickerView isEqual:pv_Frequency])
         return [ary_Frequency objectAtIndex:row];
    else
        return [ary_PillsReminder objectAtIndex:row];
}


#pragma mark MedicationView Methods
-(IBAction)PictureClicked
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take photo", @"Choose Existing", nil];
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imagePicker setDelegate: self];
            [imagePicker setAllowsEditing:NO];
            [self presentModalViewController:imagePicker animated:YES];
            
            NSLog(@"Has camera");
        } else {
            NSLog(@"Has no camera");
        }
    }
    else {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [imagePicker setDelegate: self];
            [imagePicker setAllowsEditing:NO];
            
            [self presentModalViewController:imagePicker animated:YES];
            
            NSLog(@"Has camera");
        } else {
            NSLog(@"Has no camera");
        }
    }
}
#pragma mark UIImagePickerController Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _btn_Picture.imageView.layer.cornerRadius = 30.0f;
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_btn_Picture setImage:img forState:UIControlStateNormal];
    [self dismissModalViewControllerAnimated:YES];
    
}



-(IBAction)DHACheckClicked
{
    
}

#pragma mark RechulderView Methods
-(IBAction)CancelClicked
{
    self.view_Gradient.hidden=TRUE;
    self.view_Rescheduler.hidden=TRUE;
}
-(IBAction)SetClicked
{
    self.view_Gradient.hidden=TRUE;
    self.view_Rescheduler.hidden=TRUE;
    NSMutableDictionary *mdic_UpdatedTimeAndDose = [NSMutableDictionary dictionary];
    [mdic_UpdatedTimeAndDose setValue:self.TimeToUpdate forKey:@"Time"];
    [mdic_UpdatedTimeAndDose setValue:self.txt_Dose.text forKey:@"Dose"];
    [self.TimeToUpdate stringByReplacingOccurrencesOfString:@":" withString:@"."];
    float TimeToUpdate = [self.TimeToUpdate floatValue];
    TimeToUpdate*=60;
    [mdic_UpdatedTimeAndDose setValue:[NSString stringWithFormat:@"%f",TimeToUpdate] forKey:@"TimeForDB"];
    [ary_TimesDB replaceObjectAtIndex:_TimeDose_IndexToUpdate withObject:mdic_UpdatedTimeAndDose];
    NSLog(@"%@",ary_TimesDB);
    [self UpdateTimeAndDose];
}
-(void)UpdateTimeAndDose
{
    for (UIView *subview in self.view_Reminders.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
    int x=8,y=84;
    for (int i=0; i<ary_TimesDB.count; i++) {
        UIButton *btn_Time = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_Time setFrame:CGRectMake(x, y, 90, 21)];
        [btn_Time setTitle:[[ary_TimesDB objectAtIndex:i] valueForKey:@"Time"] forState:UIControlStateNormal];
        btn_Time.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [btn_Time setTitleColor:[UIColor colorWithRed:(25.0/255.0) green:(169.0/255.0) blue:(191.0/255.0) alpha:1.0] forState:UIControlStateNormal];
        btn_Time.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn_Time.tag = i;
        [btn_Time addTarget:self action:@selector(ChangeTimeDose:) forControlEvents:UIControlEventTouchUpInside];
        [self.view_Reminders addSubview:btn_Time];
        
        
        UIButton *btn_Dose = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_Dose setFrame:CGRectMake(self.view_Reminders.frame.size.width-103, y, 95, 21)];
        [btn_Dose setTitle:[NSString stringWithFormat:@"Take %@",[[ary_TimesDB objectAtIndex:i] valueForKey:@"Dose"]] forState:UIControlStateNormal];
        btn_Dose.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btn_Dose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn_Dose setTitleColor:[UIColor colorWithRed:(25.0/255.0) green:(169.0/255.0) blue:(191.0/255.0) alpha:1.0] forState:UIControlStateNormal];
        btn_Dose.tag = i;
        [btn_Dose addTarget:self action:@selector(ChangeTimeDose:) forControlEvents:UIControlEventTouchUpInside];
        [self.view_Reminders addSubview:btn_Dose];
        
        y+=30;
    }
}
-(IBAction)PlusClicked
{
    _Dose+=0.25;
    self.txt_Dose.text = [NSString stringWithFormat:@"%.2f",_Dose];
}
-(IBAction)MinusClicked
{
    _Dose-=0.25;
    self.txt_Dose.text = [NSString stringWithFormat:@"%.2f",_Dose];
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
