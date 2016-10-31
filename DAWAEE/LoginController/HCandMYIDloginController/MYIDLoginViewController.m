//
//  MYIDLoginViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "MYIDLoginViewController.h"
#import "HomeViewController.h"
#import "IQKeyboardManager.h"
@interface MYIDLoginViewController ()

@end

@implementation MYIDLoginViewController

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
    _placeholder_myid = [[NSAttributedString alloc] initWithString:@"MYID" attributes:attrDict];
    _txt_MYID.attributedPlaceholder = _placeholder_myid;
    _placeholder_password = [[NSAttributedString alloc] initWithString:@"Password" attributes:attrDict];
    _txt_Password.attributedPlaceholder = _placeholder_password;
    
    _txt_MYID.text = @"john.smith";
    _txt_Password.text = @"123456";
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
}
-(IBAction)Back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)LoginClicked
{
    if (_txt_MYID.text.length==0) {
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"en"]) {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter MYID" ;
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter MYID" ;
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    }
    else if (_txt_Password.text.length==0) {
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"en"]) {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter MYID Password" ;
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = @"Message" ;
            str_AlertMessage = @"Please enter MYID Password" ;
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    }
    else {
        NSString *url = WEBAPI_AUTHENTICATION_ADDRESS;
        [self LOGINServiceCall:url UserId:_txt_MYID.text Password:_txt_Password.text MyIDUserId:_txt_MYID.text MyIDPassword:_txt_Password.text IsMyId:@"Y" IsLinking:@"N"];
    }
}

-(void)LOGINServiceCall:(NSString*)url UserId:(NSString*)userId Password:(NSString*)password MyIDUserId:(NSString*)myIDUserId MyIDPassword:(NSString*)myIDPassword IsMyId:(NSString*)isMyId IsLinking:(NSString*)isLinking
{
    NSString *post = nil;
    [appDelegate.HUD show:YES];
    NSString *uid = [prefs valueForKey:@"UID"];
    NSString *deviceType = @"IPhone";//,*IsLinking = @"N";
    NSString *deviceToken = [prefs stringForKey:@"REGISTRATION_ID"];
    NSString *appID = @"SEHHATI";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        deviceType=@"IPhone";
    }
    else
    {
        deviceType=@"IPad";
    }
    
    if([isLinking isEqualToString:@"Y"])
    {
        post = [NSString stringWithFormat:@"UserId=%@&Password=%@&DeviceId=%@&DeviceType=%@&IsMyID=%@&MyIdUserId=%@&MyIdPassword=%@&Linking=%@&AppId=%@", userId, password, uid, deviceType, isMyId, myIDUserId, myIDPassword, isLinking,appID];
    }
    else
    {
        post = [NSString stringWithFormat:@"UserId=%@&Password=%@&DeviceId=%@&DeviceType=%@&IsMyID=%@&MyIdUserId=%@&MyIdPassword=%@&AppId=%@", userId, password, uid, deviceType, isMyId, myIDUserId, myIDPassword,appID];
    }
    
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
                str_AlertMessage = @"Please enter valid MYID and MYID Password" ;
                str_AlertButton = @"OK";
            }
            else {
                str_AlertTitle = @"Message" ;
                str_AlertMessage = @"Please enter valid MYID and MYID Password" ;
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
