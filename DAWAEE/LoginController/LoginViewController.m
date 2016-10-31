//
//  LoginViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/23/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgotPasswordViewController.h"
#import "HomeViewController.h"
#import "IQKeyboardManager.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    prefs = [NSUserDefaults standardUserDefaults];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSAttributedString *str_ForgotPassword = [[NSAttributedString alloc] initWithString:@"Forgot Password?"
                                                             attributes:underlineAttribute];
    
    [self.btn_ForgotPassword setAttributedTitle:str_ForgotPassword forState:UIControlStateNormal];
    
    [self.btn_Login.layer setCornerRadius:25.0f];
    [self.btn_Login.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.btn_Login.layer setShadowOpacity:0.5];
    [self.btn_Login.layer setShadowRadius:2.0];
    [self.btn_Login.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    [self.btn_Register.layer setCornerRadius:25.0f];
    [self.btn_Register.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.btn_Register.layer setShadowOpacity:0.5];
    [self.btn_Register.layer setShadowRadius:2.0];
    [self.btn_Register.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont fontWithName:@"Arial" size:16.0],
                               NSForegroundColorAttributeName : [UIColor whiteColor]
                               };
    _placeholder_userid = [[NSAttributedString alloc] initWithString:@"User ID" attributes:attrDict];
    _txt_UserID.attributedPlaceholder = _placeholder_userid;
    _placeholder_password = [[NSAttributedString alloc] initWithString:@"Password" attributes:attrDict];
    _txt_Password.attributedPlaceholder = _placeholder_password;
    
    _txt_UserID.text = @"anwarnkhan";
    _txt_Password.text = @"password";
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)RegisteClicked
{
    RegisterViewController *obj_RegisterViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:obj_RegisterViewController animated:YES];
}
-(IBAction)ForgotPasswordClicked
{
    ForgotPasswordViewController *obj_ForgotPasswordViewController = [[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:obj_ForgotPasswordViewController animated:YES];
}
-(IBAction)LoginClicked
{
    if (_txt_UserID.text.length==0) {
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"en"]) {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter User ID" ;
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter User ID" ;
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    }
    else if (_txt_Password.text.length==0) {
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"en"]) {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter Password" ;
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter Password" ;
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    }
    else {
        NSString *url = WEBAPI_AUTHENTICATION_ADDRESS;
        [self LOGINServiceCall:url UserId:_txt_UserID.text Password:_txt_Password.text UserLinking:@"N"];
    }
}

-(void)LOGINServiceCall:(NSString*)url UserId:(NSString*)userId Password:(NSString*)password UserLinking:(NSString*)userlinking
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
    
    post = [NSString stringWithFormat:@"UserId=%@&Password=%@&DeviceId=%@&DeviceType=%@&APIKey=%@&AppId=SEHHATI&IsUserProfileLinking=%@", userId, password, uid, deviceType,deviceToken,userlinking];
    
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
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *connectionError;
    [appDelegate.HUD hide:YES];
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
                str_AlertTitle = @"Message" ;
                str_AlertMessage = @"Please enter valid User ID and Password" ;
                str_AlertButton = @"OK";
            }
            else {
                str_AlertTitle = @"Message" ;
                str_AlertMessage = @"Please enter valid User ID and Password" ;
                str_AlertButton = @"حسنا";
            }
            [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
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




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
