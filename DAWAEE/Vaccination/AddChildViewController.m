//
//  AddChildViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/9/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "AddChildViewController.h"
#import "IQKeyboardManager.h"
@interface AddChildViewController ()

@end

@implementation AddChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    prefs = [NSUserDefaults standardUserDefaults];
    
    btn_AddChild.layer.cornerRadius=25.0f;
    [btn_AddChild.layer setShadowColor:[UIColor blackColor].CGColor];
    [btn_AddChild.layer setShadowOpacity:0.5];
    [btn_AddChild.layer setShadowRadius:2.0];
    [btn_AddChild.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont fontWithName:@"Arial" size:16.0],
                               NSForegroundColorAttributeName : [UIColor whiteColor]
                               };
    _placeholder_childname = [[NSAttributedString alloc] initWithString:@"Enter Child Name" attributes:attrDict];
    _txt_ChildName.attributedPlaceholder = _placeholder_childname;
    _placeholder_childdob = [[NSAttributedString alloc] initWithString:@"Enter Child DOB" attributes:attrDict];
    _txt_ChildDOB.attributedPlaceholder = _placeholder_childdob;
    
    
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    _txt_ChildDOB.inputView = self.datePicker;
    
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *currentTimeZone = [NSTimeZone defaultTimeZone];
    [self.dateFormatter setTimeZone:currentTimeZone];
    
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    str_Gender = @"M";
}
-(IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)genderClicked:(id)sender {
    if ([str_Gender isEqualToString:@"M"]) {
        [btn_Gender setImage:[UIImage imageNamed:@"switch_female.png"] forState:UIControlStateNormal];
        str_Gender = @"F";
    }
    else {
        str_Gender = @"M";
        [btn_Gender setImage:[UIImage imageNamed:@"switch_male.png"] forState:UIControlStateNormal];
    }
}
-(IBAction)AddPhotoClicked;
{
    
}
-(IBAction)AddChildClicked
{
    if (_txt_ChildName.text.length<=0) {
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"en"]) {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter Child Name" ;
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter Child Name" ;
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    }
    else {
        if (_txt_ChildDOB.text.length<=0) {
            NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
            if ([str_Language isEqualToString:@"en"]) {
                str_AlertTitle = @"Message" ;
                str_AlertMessage = @"Please select Child DOB" ;
                str_AlertButton = @"OK";
            }
            else {
                str_AlertTitle = @"Message" ;
                str_AlertMessage = @"Please select Child DOB" ;
                str_AlertButton = @"حسنا";
            }
            [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
        }
        else {
            [self AddChildServiceCall];
        }
    }
    
}

-(void)AddChildServiceCall
{
    id json = [NSJSONSerialization JSONObjectWithData:[prefs valueForKey:LOGGEDINUSERDATA] options:0 error:nil];
    
    NSString *post = nil;
    [appDelegate.HUD show:YES];
    NSString *uid = [prefs valueForKey:@"UID"];
    NSString *userId = [NSString stringWithFormat:@"%@",[json valueForKey:@"HCNumber"]];
    NSString *deviceType = @"IPhone";//,*IsLinking = @"N";
    NSString *deviceToken = [prefs stringForKey:@"REGISTRATION_ID"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        deviceType=@"IPhone";
    }
    else
    {
        deviceType=@"IPad";
    }
    
    post = [NSString stringWithFormat:@"uid=%@&CreatedById=%@&Name=%@&Gender=%@&Dob=%@",uid,userId,_txt_ChildName.text,str_Gender,_txt_ChildDOB.text];
    NSString *encryptedString = [CommonFunctions EnctyrptToken:uid];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSString *base64HeaderData = [NSString stringWithFormat:@"Basic %@", encryptedString];
    
    
    NSURL *nsUrl = [NSURL URLWithString:AddChild];
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *connectionError;
    [appDelegate.HUD hide:YES];
    if([data length] > 0 && connectionError == nil)
    {
        NSString *str_Response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str_Response);
        if ([str_Response isEqualToString:@"true"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else if([data length] == 0 && connectionError == nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"json %@",json);
    }
    else if(connectionError != nil)
    {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"json %@",json);
    }
    
}


#pragma mark UITextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.txt_ChildDOB]) {
        self.view_PickerTool.hidden=FALSE;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    self.txt_ChildDOB.text = [self.dateFormatter stringFromDate:datePicker.date];
}

#pragma mark ScheduleView Methods
-(IBAction)CancelDatePicker
{
    self.view_PickerTool.hidden=TRUE;
    self.txt_ChildDOB.text=@"";
    [self.txt_ChildDOB resignFirstResponder];
}
-(IBAction)DoneDatePickerClicked
{
    self.view_PickerTool.hidden=TRUE;
    [self.txt_ChildDOB resignFirstResponder];
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
