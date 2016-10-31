//
//  EmergencyContactsViewController.m
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/17/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "EmergencyContactsViewController.h"
#import "EmergencyContactCell.h"
@interface EmergencyContactsViewController ()

@end

@implementation EmergencyContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    prefs = [NSUserDefaults standardUserDefaults];
    self.tbl_EmergencyContacts.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tbl_EmergencyContacts.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self GetEmergencyContactsWSCall];
}

#pragma mark service callls
-(void)GetEmergencyContactsWSCall
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
    
    /*NSArray *PARAMS = [NSArray  arrayWithObjects:@"?hcNumber=",nil];
    NSString *str_HCNumber;
    str_HCNumber = [NSString stringWithFormat:@"%@",[json valueForKey:@"HCNumber"]];
    
    NSString *hcNumber = [NSString stringWithFormat:@"%@%@",[PARAMS objectAtIndex:0],str_HCNumber];*/
    NSString *urlAddress = [NSString stringWithFormat:@"%@",GetEmergencyContacts];
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    [request setRequestMethod:@"GET"];
    request.delegate = self;
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"uid" value:[prefs stringForKey:@"UID"]];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetEmergencyContactsRequestFinished:)];
    [request setDidFailSelector:@selector(GetEmergencyContactsRequestFailed:)];
    @try {
        [request startAsynchronous];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
- (void)GetEmergencyContactsRequestFinished:(ASIHTTPRequest *)request{
    id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    self.ary_EmergencyContacts = [NSMutableArray arrayWithArray:json];
    NSLog(@"%@",self.ary_EmergencyContacts);
    if (json!=nil) {
        [self.tbl_EmergencyContacts reloadData];
    }
    
    
}
- (void)GetEmergencyContactsRequestFailed:(ASIHTTPRequest *)request {
    NSData *responseData = [request responseData];
    NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str_Response);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    EmergencyContactCell *cell = (EmergencyContactCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"EmergencyContactCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lbl_Title.text = [[self.ary_EmergencyContacts objectAtIndex:indexPath.row] valueForKey:@"NameEnglish"];
        cell.lbl_PhoneNumber.text = [[self.ary_EmergencyContacts objectAtIndex:indexPath.row] valueForKey:@"Telephone1"];
        cell.btn_Call.tag = indexPath.row;
        [cell.btn_Call addTarget:self action:@selector(CallClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
-(void)CallClicked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    
    NSString *str_Number = [[self.ary_EmergencyContacts objectAtIndex:btn.tag] valueForKey:@"Telephone1"];
    NSString *phoneNumber = [@"tel://" stringByAppendingString:str_Number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];

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
