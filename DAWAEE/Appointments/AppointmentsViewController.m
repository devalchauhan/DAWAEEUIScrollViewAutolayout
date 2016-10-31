//
//  AppointmentsViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/17/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "AppointmentsViewController.h"
#import "AppointmentCell.h"
#import "CKCalendarViewControllerInternal.h"
@interface AppointmentsViewController ()

@end

@implementation AppointmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    prefs = [NSUserDefaults standardUserDefaults];
    self.tbl_Appointments.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tbl_Appointments.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tbl_Appointments.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideRescheduleView)];
    [self.view_Gradient addGestureRecognizer:gestureRecognizer];
    
    
    
    [self.btn_RescheduleAppointments.layer setCornerRadius:25.0f];
    [self.btn_RescheduleAppointments.layer setBorderColor:[UIColor colorWithRed:(31.0/255.0) green:(143.0/255.0) blue:(155.0/255.0) alpha:1.0].CGColor];
    [self.btn_RescheduleAppointments.layer setBorderWidth:1.0f];
    
    
    [self.btn_CancelAppointments.layer setCornerRadius:25.0f];
    [self.btn_CancelAppointments.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.btn_CancelAppointments.layer setBorderWidth:1.0f];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self GetAppointmentsByHealthCardWSCall];
}

#pragma mark service callls
-(void)GetAppointmentsByHealthCardWSCall
{
    //appDelegate.flagForIsWSCalled = TRUE;
    id json = [NSJSONSerialization JSONObjectWithData:[prefs valueForKey:LOGGEDINUSERDATA] options:0 error:nil];
    
    NSString *AUTH_TOKEN = [NSString stringWithFormat:@"%@",[json valueForKey:@"Token"]];
    NSString *deviceType = @"IPhone";//,*IsLinking = @"N";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        deviceType=@"IPhone";
    }
    else
    {
        deviceType=@"IPad";
    }
    NSString *encryptedString = [CommonFunctions EnctyrptToken:AUTH_TOKEN];
    
    NSArray *PARAMS = [NSArray  arrayWithObjects:@"?hcNumber=",nil];
    NSString *str_HCNumber;
    str_HCNumber = [NSString stringWithFormat:@"%@",[json valueForKey:@"HCNumber"]];
    
    NSString *hcNumber = [NSString stringWithFormat:@"%@%@",[PARAMS objectAtIndex:0],str_HCNumber];
    NSString *urlAddress = [NSString stringWithFormat:@"%@%@",GetAppointmentsByHealthCard,hcNumber];
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    [request setRequestMethod:@"GET"];
    request.delegate = self;
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"uid" value:[prefs stringForKey:@"UID"]];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetAppointmentsByHealthCardRequestFinished:)];
    [request setDidFailSelector:@selector(GetAppointmentsByHealthCardRequestFailed:)];
    @try {
        [request startAsynchronous];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
- (void)GetAppointmentsByHealthCardRequestFinished:(ASIHTTPRequest *)request{
    id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    self.ary_Appointments = [NSMutableArray arrayWithArray:json];
    NSLog(@"%@",self.ary_Appointments);
    if (json!=nil) {
        [self.tbl_Appointments reloadData];
    }
    
    
}
- (void)GetAppointmentsByHealthCardRequestFailed:(ASIHTTPRequest *)request {
    NSData *responseData = [request responseData];
    NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
}


-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)RescheduleAppointmentClicked
{
    [self HideRescheduleView];
    CKCalendarViewControllerInternal *obj_CKCalendarViewControllerInternal = [CKCalendarViewControllerInternal new];
    //obj_CKCalendarViewControllerInternal.date = self.date_ToPass;
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration: 0.5];
    [self.navigationController pushViewController:obj_CKCalendarViewControllerInternal animated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}
#pragma mark UITableView Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"CURRENT APPOINTMENTS";
            break;
        case 1:
            sectionName = @"PAST APPOINTMENTS";
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.ary_Appointments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    AppointmentCell *cell = (AppointmentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"AppointmentCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.shadowOpacity = 0.5;
        cell.layer.shadowRadius = 2;
        cell.layer.shadowOffset = CGSizeMake(0, 2);
        cell.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.backgroundColor = [UIColor clearColor];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSTimeZone *currentTimeZone = [NSTimeZone defaultTimeZone];
        [dateFormatter setTimeZone:currentTimeZone];
        NSDate *str_DateTemp = [dateFormatter dateFromString:[[self.ary_Appointments objectAtIndex:indexPath.row] valueForKey:@"AppointmentDate"]];
        self.date_ToPass = str_DateTemp;
        [dateFormatter setDateFormat:@"EEEE, dd MMM yyyy"];
        NSString *str_Date = [dateFormatter stringFromDate:str_DateTemp];
        NSArray *ary_DateCompo = [str_Date componentsSeparatedByString:@" "];
        cell.lbl_Day.text = [NSString stringWithFormat:@"%@",[[ary_DateCompo objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""]];
        cell.lbl_Date.text = [NSString stringWithFormat:@"%i",[[ary_DateCompo objectAtIndex:1] intValue]];;
        cell.lbl_Month.text = [NSString stringWithFormat:@"%@",[ary_DateCompo objectAtIndex:2]];
        cell.lbl_Year.text = [NSString stringWithFormat:@"%@",[ary_DateCompo objectAtIndex:3]];
        cell.lbl_Speciality.text = [[self.ary_Appointments objectAtIndex:indexPath.row] valueForKey:@"Specialty"];
        cell.lbl_Location.text = [[self.ary_Appointments objectAtIndex:indexPath.row] valueForKey:@"Location"];
        cell.lbl_Time.text = [[self.ary_Appointments objectAtIndex:indexPath.row] valueForKey:@"AppointmentTime"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.view_Gradient.hidden=FALSE;
    //self.view_RescheduleAppointments.hidden=FALSE;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSTimeZone *currentTimeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:currentTimeZone];
    NSDate *str_DateTemp = [dateFormatter dateFromString:[[self.ary_Appointments objectAtIndex:indexPath.row] valueForKey:@"AppointmentDate"]];
    [dateFormatter setDateFormat:@"EEEE, dd MMM yyyy"];
    NSString *str_Date = [dateFormatter stringFromDate:str_DateTemp];
    NSArray *ary_DateCompo = [str_Date componentsSeparatedByString:@" "];
    NSString *str_daySuffix = [self daySuffixForDate:str_DateTemp];
    self.lbl_Day.text = [NSString stringWithFormat:@"%@",[ary_DateCompo objectAtIndex:0]];
    self.lbl_Date.text = [NSString stringWithFormat:@"%i%@",[[ary_DateCompo objectAtIndex:1] intValue],str_daySuffix];
    self.lbl_Month.text = [NSString stringWithFormat:@"%@",[ary_DateCompo objectAtIndex:2]];
    self.lbl_Year.text = [NSString stringWithFormat:@"%@",[ary_DateCompo objectAtIndex:3]];
    self.lbl_Speciality.text = [[self.ary_Appointments objectAtIndex:indexPath.row] valueForKey:@"Specialty"];
    self.lbl_Location.text = [[self.ary_Appointments objectAtIndex:indexPath.row] valueForKey:@"Location"];
    self.lbl_Time.text = [[self.ary_Appointments objectAtIndex:indexPath.row] valueForKey:@"AppointmentTime"];
    
    
    appDelegate.dic_SelectedAppointmentDetails = [NSMutableDictionary dictionary];
    
    appDelegate.dic_SelectedAppointmentDetails = [self.ary_Appointments objectAtIndex:indexPath.row];
    //NSLog(@"%@",appDelegate.dic_SelectedAppointmentDetails);
    CGRect basketTopFrame = self.view_RescheduleAppointments.frame;
    basketTopFrame.origin.y = self.view.frame.size.height-420;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.view_RescheduleAppointments.frame = basketTopFrame; } completion:^(BOOL finished){ }];
    
}
-(void)HideRescheduleView
{
    self.view_Gradient.hidden=TRUE;
    //self.view_RescheduleAppointments.hidden=TRUE;
    CGRect basketTopFrame = self.view_RescheduleAppointments.frame;
    basketTopFrame.origin.y = self.view.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.view_RescheduleAppointments.frame = basketTopFrame; } completion:^(BOOL finished){ }];
}

- (NSString *)daySuffixForDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger dayOfMonth = [calendar component:NSCalendarUnitDay fromDate:date];
    switch (dayOfMonth) {
        case 1:
        case 21:
        case 31: return @"st";
        case 2:
        case 22: return @"nd";
        case 3:
        case 23: return @"rd";
        default: return @"th";
    }
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
