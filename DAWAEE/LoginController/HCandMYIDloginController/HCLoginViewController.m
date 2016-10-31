//
//  HCLoginViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "HCLoginViewController.h"
#import "IQKeyboardManager.h"
#import "HomeViewController.h"
@interface HCLoginViewController ()

@end

@implementation HCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    prefs = [NSUserDefaults standardUserDefaults];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [self.btn_Login.layer setCornerRadius:25.0f];
    [self.btn_Login.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.btn_Login.layer setShadowOpacity:0.5];
    [self.btn_Login.layer setShadowRadius:2.0];
    [self.btn_Login.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont fontWithName:@"Arial" size:16.0],
                               NSForegroundColorAttributeName : [UIColor whiteColor]
                               };
    _placeholder_yob = [[NSAttributedString alloc] initWithString:@"Select Year of Birth" attributes:attrDict];
    _txt_YOB.attributedPlaceholder = _placeholder_yob;
    _placeholder_healthcard = [[NSAttributedString alloc] initWithString:@"Health Card" attributes:attrDict];
    _txt_HealthCard.attributedPlaceholder = _placeholder_healthcard;
    _placeholder_sms = [[NSAttributedString alloc] initWithString:@"SMS Code" attributes:attrDict];
    _txt_SMS.attributedPlaceholder = _placeholder_sms;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int i2  = [[formatter stringFromDate:[NSDate date]] intValue];
    years = [[NSMutableArray alloc] init];
    for (int i=1900; i<=i2; i++) {
        [years addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.backgroundColor = [UIColor whiteColor];
    [pickerView selectRow:[years count]-21 inComponent:0 animated:YES];
    self.txt_YOB.inputView = pickerView;
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    _txt_HealthCard.text = @"12158186";
    _txt_YOB.text = @"1996";
}
-(IBAction)AllLoginClicked
{
    if (_btn_ALLLogin.selected==FALSE) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        _btn_ALLLogin.selected=FALSE;
        _btn_Login.selected=FALSE;
        
        _lbl_HealthCardStatic.hidden=FALSE;
        _txt_HealthCard.hidden=FALSE;
        _txt_YOB.hidden=FALSE;
        _lbl_HealthCardLine.hidden=FALSE;
        _lbl_YOBLine.hidden=FALSE;
        _txt_SMS.hidden=TRUE;
        _lbl_SMSLine.hidden=TRUE;
    }
}
-(IBAction)Loginclicked
{
    if(_btn_Login.selected==FALSE){
        
        NSString *url = WEBAPI_HC_AUTHENTICATION_ADDRESS;
        
        NSString *birthDate = [NSString stringWithFormat:@"01/01/%@",_txt_YOB.text];
        NSString *firstName = @"";
        NSString *apiKey = [prefs stringForKey:@"REGISTRATION_ID"];
        
        [self LOGINServiceCall:url UserId:@"" Password:@"" HCNumber:_txt_HealthCard.text BirthDate:birthDate FirstName:firstName APIKey:apiKey IsLinking:@"N"];
        
    }
    else {
        /*_btn_Login.selected=FALSE;
        _btn_ALLLogin.selected=FALSE;
        
        _lbl_HealthCardStatic.hidden=FALSE;
        _txt_HealthCard.hidden=FALSE;
        _txt_YOB.hidden=FALSE;
        _lbl_HealthCardLine.hidden=FALSE;
        _lbl_YOBLine.hidden=FALSE;
        _txt_SMS.hidden=TRUE;
        _lbl_SMSLine.hidden=TRUE;*/
        
        NSString *url = WEBAPI_HC_CODE_AUTHENTICATION_ADDRESS;
        
        NSString *birthDate = [NSString stringWithFormat:@"01/01/%@",_txt_YOB.text];
        NSString *firstName = @"";
        NSString *apiKey = [prefs stringForKey:@"REGISTRATION_ID"];
        
        [self LoginWithAccessCode:url AccessCode:_txt_SMS.text HCNumber:_txt_HealthCard.text BirthDate:birthDate FirstName:firstName APIKey:apiKey IsLinking:@"N"];
        
    }
}



-(void)LOGINServiceCall:(NSString*)url UserId:(NSString*)userId Password:(NSString*)password HCNumber:(NSString*)hcNumber BirthDate:(NSString*)birthDate FirstName:(NSString*)firstName APIKey:(NSString*)apiKey IsLinking:(NSString*)isLinking
{
    NSString *post = nil;
    [appDelegate.HUD show:YES];
    NSString *uid = [prefs valueForKey:@"UID"];
    NSString *deviceType = @"IPhone";//,*IsLinking = @"N";
    NSString *deviceToken = [prefs stringForKey:@"REGISTRATION_ID"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        deviceType=@"IPhone";
    }
    else
    {
        deviceType=@"IPad";
    }
    
     post = [NSString stringWithFormat:@"HCNumber=%@&APIKey=%@&DOB=%@&FirstName=%@&DeviceId=%@&DeviceType=%@&AppId=SEHHATI&IsUserProfileLinking=%@", hcNumber, apiKey, birthDate, firstName, uid, deviceType,isLinking];
    
    NSString *encryptedString = [CommonFunctions EnctyrptToken:uid];
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSString *base64HeaderData = [NSString stringWithFormat:@"Basic %@", encryptedString];
    
    
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:nsUrl];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"2.0" forHTTPHeaderField:@"APIVERSION"];
    [theRequest setValue:uid forHTTPHeaderField:@"uid"];
    [theRequest setValue:base64HeaderData forHTTPHeaderField:@"Authorization"];
    [theRequest setHTTPBody:postData];
    self.flag_HCLogin = TRUE;
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    [conn start];
    
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *connectionError;
    [appDelegate.HUD hide:YES];
    if (self.flag_HCLogin==TRUE) {
    if([data length] > 0 && connectionError == nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"json %@",json);
        if ([[json valueForKey:@"AuthMessage"] isEqualToString:@"SUCCESS"]) {
            /*[prefs setValue:data forKey:LOGGEDINUSERDATA];
            [prefs synchronize];*/
            /*HomeViewController *obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
            [self.navigationController pushViewController:obj_HomeViewController animated:YES];*/
            
            _btn_Login.selected=TRUE;
            _btn_ALLLogin.selected=TRUE;
            
            _lbl_HealthCardStatic.hidden=TRUE;
            _txt_HealthCard.hidden=TRUE;
            _txt_YOB.hidden=TRUE;
            _lbl_HealthCardLine.hidden=TRUE;
            _lbl_YOBLine.hidden=TRUE;
            _txt_SMS.hidden=FALSE;
            _lbl_SMSLine.hidden=FALSE;
            
        }
        else {
            
            _btn_Login.selected=TRUE;
            _btn_ALLLogin.selected=TRUE;
            
            _lbl_HealthCardStatic.hidden=TRUE;
            _txt_HealthCard.hidden=TRUE;
            _txt_YOB.hidden=TRUE;
            _lbl_HealthCardLine.hidden=TRUE;
            _lbl_YOBLine.hidden=TRUE;
            _txt_SMS.hidden=FALSE;
            _lbl_SMSLine.hidden=FALSE;
            
            
            NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
            if ([str_Language isEqualToString:@"en"]) {
                str_AlertTitle = [json valueForKey:@"Status"];
                str_AlertMessage = [json valueForKey:@"Message"];
                str_AlertButton = @"OK";
            }
            else {
                str_AlertTitle = [json valueForKey:@"Status"];
                str_AlertMessage = [json valueForKey:@"Message"];
                str_AlertButton = @"حسنا";
            }
            [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
        }
    }
    else if([data length] == 0 && connectionError == nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"json %@",json);
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"en"]) {
            str_AlertTitle = [json valueForKey:@"Status"];
            str_AlertMessage = [json valueForKey:@"Message"];
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = [json valueForKey:@"Status"];
            str_AlertMessage = [json valueForKey:@"Message"];
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    }
    else if(connectionError != nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"json %@",json);
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"en"]) {
            str_AlertTitle = [json valueForKey:@"Status"];
            str_AlertMessage = [json valueForKey:@"Message"];
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = [json valueForKey:@"Status"];
            str_AlertMessage = [json valueForKey:@"Message"];
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    }
        self.flag_HCLogin=FALSE;
    }
    else {
        if([data length] > 0 && connectionError == nil)
        {
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json %@",json);
            if ([[json valueForKey:@"AuthMessage"] isEqualToString:@"SUCCESS"]) {
                [prefs setValue:data forKey:LOGGEDINUSERDATA];
                [prefs synchronize];
                HomeViewController *obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
                 [self.navigationController pushViewController:obj_HomeViewController animated:YES];
            }
            else {
                NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
                if ([str_Language isEqualToString:@"en"]) {
                    str_AlertTitle = [json valueForKey:@"Status"];
                    str_AlertMessage = [json valueForKey:@"Message"];
                    str_AlertButton = @"OK";
                }
                else {
                    str_AlertTitle = [json valueForKey:@"Status"];
                    str_AlertMessage = [json valueForKey:@"Message"];
                    str_AlertButton = @"حسنا";
                }
                [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
            }
        }
        else if([data length] == 0 && connectionError == nil)
        {
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json %@",json);
            NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
            if ([str_Language isEqualToString:@"en"]) {
                str_AlertTitle = [json valueForKey:@"Status"];
                str_AlertMessage = [json valueForKey:@"Message"];
                str_AlertButton = @"OK";
            }
            else {
                str_AlertTitle = [json valueForKey:@"Status"];
                str_AlertMessage = [json valueForKey:@"Message"];
                str_AlertButton = @"حسنا";
            }
            [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
        }
        else if(connectionError != nil)
        {
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json %@",json);
            NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
            if ([str_Language isEqualToString:@"en"]) {
                str_AlertTitle = [json valueForKey:@"Status"];
                str_AlertMessage = [json valueForKey:@"Message"];
                str_AlertButton = @"OK";
            }
            else {
                str_AlertTitle = [json valueForKey:@"Status"];
                str_AlertMessage = [json valueForKey:@"Message"];
                str_AlertButton = @"حسنا";
            }
            [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
        }
    }
    
}



-(void)LoginWithAccessCode:(NSString*)url AccessCode:(NSString*)accessCode HCNumber:(NSString*)hcNumber BirthDate:(NSString*)birthDate FirstName:(NSString*)firstName APIKey:(NSString*)apiKey IsLinking:(NSString*)isLinking
{
    NSString *post = nil;
    [appDelegate.HUD show:YES];
    NSString *uid = [prefs valueForKey:@"UID"];
    NSString *deviceType = @"IPhone";//,*IsLinking = @"N";
    NSString *deviceToken = [prefs stringForKey:@"REGISTRATION_ID"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        deviceType=@"IPhone";
    }
    else
    {
        deviceType=@"IPad";
    }
    
    post = [NSString stringWithFormat:@"Code=%@&HCNumber=%@&APIKey=%@&DOB=%@&FirstName=%@&DeviceId=%@&DeviceType=%@&AppId=SEHHATI&IsUserProfileLinking=%@", accessCode, hcNumber, apiKey, birthDate, firstName, uid, deviceType,isLinking];
    
    NSString *encryptedString = [CommonFunctions EnctyrptToken:uid];
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSString *base64HeaderData = [NSString stringWithFormat:@"Basic %@", encryptedString];
    
    
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:nsUrl];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"2.0" forHTTPHeaderField:@"APIVERSION"];
    [theRequest setValue:uid forHTTPHeaderField:@"uid"];
    [theRequest setValue:base64HeaderData forHTTPHeaderField:@"Authorization"];
    [theRequest setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    [conn start];
}



#pragma mark UITextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.txt_YOB]) {
        self.view_PickerTool.hidden=FALSE;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
#pragma mark UIPIckerView Delegate
- (NSInteger)numberOfComponentsInPickerView: (UIPickerView*)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [years count];
}
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [years objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.txt_YOB.text = [years objectAtIndex:row];
}
- (void)datePickerValueChanged:(id)sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    NSString *dateString = [formatter stringFromDate:[picker date]];
    [self.txt_YOB setText:dateString];
    
}
#pragma mark ScheduleView Methods
-(IBAction)CancelDatePicker
{
    self.view_PickerTool.hidden=TRUE;
    self.txt_YOB.text=@"";
    [self.txt_YOB resignFirstResponder];
}
-(IBAction)DoneDatePickerClicked
{
    self.view_PickerTool.hidden=TRUE;
    [self.txt_YOB resignFirstResponder];
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
