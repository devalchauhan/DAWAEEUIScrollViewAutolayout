//
//  HomeViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "HomeViewController.h"
#import "CVCell.h"
#import "Constants.h"
#import "CKCalendarViewControllerInternal.h"
#import "CKDemoViewController.h"

#import "ManageItemViewController.h"
#import "VaccinationViewController.h"
#import "FIndDotorsAndFacilitiesViewController.h"
#import "SLParallaxController.h"
#import "SwitchProfileViewController.h"
#import "HistoryViewController.h"
#import "NotificationsViewController.h"
#import "EmergencyContactsViewController.h"
#import "AppointmentsViewController.h"

// Happiness Meter
#import "NSString+DSGHappinessCrypto.h"
#import "Util.h"
#import "Header.h"
#import "User.h"
#import "Application.h"
#import "Transaction.h"
#import "VotingRequest.h"
#import "VotingManager.h"


@interface HomeViewController () {
    
    // Happiness Meter
    NSString *serviceProviderSecret;
    NSString *clientID;
    NSString *microApp;
    NSString *microAppDisplay;
    NSString *serviceProvider;
    NSString *lang;
    
    REQUEST_TYPE request_type;
    
}

@property(nonatomic , weak)IBOutlet UIWebView *webView;
@property(nonatomic , weak)IBOutlet UISegmentedControl *segmentedControl;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=TRUE;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    prefs = [NSUserDefaults standardUserDefaults];
    
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(HideMenu)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view_Menu addGestureRecognizer:swipeleft];
    
    
    /*id json = [NSJSONSerialization JSONObjectWithData:[prefs valueForKey:LOGGEDINUSERPROFILEDATA] options:0 error:nil];
     NSLog(@"%@",json);*/
    // For Menu
    self.view_Gradient.hidden=TRUE;
    self.view_Menu.hidden=TRUE;
    [self.view_Gradient addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideMenu)]];
    
    
    
    
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont fontWithName:@"Arial" size:16.0],
                               NSForegroundColorAttributeName : [UIColor colorWithRed:(64.0/255.0) green:(124.0/255.0) blue:(121.0/255.0) alpha:1.0]
                               };
    placeholder_SearchForDAndF = [[NSAttributedString alloc] initWithString:@"Search for Doctors and Facilities" attributes:attrDict];
    _txt_SearchForDAndF.attributedPlaceholder = placeholder_SearchForDAndF;
    
    
    [self.btn_Logout.layer setCornerRadius:25.0f];
    [self.btn_Logout.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.btn_Logout.layer setBorderWidth:1.0f];
    
    
    [self.btn_LoginToContinue.layer setCornerRadius:25.0f];
    [self.btn_LoginToContinue.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.btn_LoginToContinue.layer setBorderWidth:1.0f];
    
    
    [self.view_SearchForDAndF.layer setCornerRadius:2.0f];
    [self.view_SearchForDAndF.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.view_SearchForDAndF.layer setShadowOpacity:0.5];
    [self.view_SearchForDAndF.layer setShadowRadius:2.0];
    [self.view_SearchForDAndF.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [self.btn_SeeDirection.layer setCornerRadius:15.0f];
    [self.btn_SeeDirection.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.btn_SeeDirection.layer setBorderWidth:1.0f];
    
    
    [self.mapView.layer setCornerRadius:2.0f];
    [self.mapView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.mapView.layer setShadowOpacity:0.5];
    [self.mapView.layer setShadowRadius:2.0];
    [self.mapView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];

    [self.btn_PHC.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [self.btn_PHC setContentMode:UIViewContentModeCenter];
    
    [self.btn_NearPharamcy.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [self.btn_NearPharamcy setContentMode:UIViewContentModeCenter];
    
    [self.btn_NearestFacility.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [self.btn_NearestFacility setContentMode:UIViewContentModeCenter];
    
    /* uncomment this block to use subclassed cells */
    [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    /* end of subclass-based cells block */
    
    // Configure layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    if (IS_IPHONE_6Plus) {
        [flowLayout setItemSize:CGSizeMake(130, 130)];
        footerWidth.constant = 500;
    }
    else if (IS_IPHONE_6)
        [flowLayout setItemSize:CGSizeMake(120, 120)];
    else if (IS_IPHONE_5)
        [flowLayout setItemSize:CGSizeMake(100, 100)];
    
    // [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Happiness Meter
    
    //stop webview bouncing
    self.webView.scrollView.bounces = NO;
    
    //add tap gesture recignizer to stop webview loading if user taps any where outisde the webview durign loading
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(actionTapGesturePerformed:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
    
    //set parameters for webview request
    serviceProviderSecret   = @"3CB37A76911D3661";//To be replaced by one provided by DSG.
    clientID                = @"dhabeatuser";//To be replaced by one provided by DSG.
    microApp                = @"";//To be replaced by the name of your microapp.
    serviceProvider         = @"DHA";//To be replaced by the spName e.g. RTA, DEWA.
    //lang                    = @"en";
    
    self.webView.alpha = 0.0f;
}
-(void)PreapareCollectionview
{
    
    
    self.ary_Menu = [NSMutableArray array];
    
    [self.ary_Menu addObject:@"My History"];
    [self.ary_Menu addObject:@"Weather"];
    w1 =  [prefs valueForKey:@"w1"];
    w2 =  [prefs valueForKey:@"w2"];
    w3 =  [prefs valueForKey:@"w3"];
    w4 =  [prefs valueForKey:@"w4"];
    w5 =  [prefs valueForKey:@"w5"];
    w5 = @"1";
    if ([w1 isEqualToString:@""]||[w1 isEqualToString:@"0"]||w1==nil)
        flag_HistoryOff=FALSE;
    else
        flag_HistoryOff=TRUE;
    if ([w2 isEqualToString:@""]||[w2 isEqualToString:@"0"]||w2==nil)
        flag_WeatherOff=FALSE;
    else
        flag_WeatherOff=TRUE;
    
    if ([w3 isEqualToString:@""]||[w3 isEqualToString:@"0"]||w3==nil)
        [self.ary_Menu addObject:@"APPOINTMENTS"];
    if ([w4 isEqualToString:@""]||[w4 isEqualToString:@"0"]||w4==nil)
        [self.ary_Menu addObject:@"NEXT VACCINATION"];
    if ([w5 isEqualToString:@""]||[w5 isEqualToString:@"0"]||w5==nil)
        [self.ary_Menu addObject:@"DHA HEALTH BOOK"];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    prefs = [NSUserDefaults standardUserDefaults];
    switch (self.ary_Menu.count) {
        case 1:
            height_collectionview = 567;
            break;
        case 2:
            height_collectionview = 567*2+10;
            break;
        case 3:
            height_collectionview = 567*2+230;
            break;
        case 4:
            height_collectionview = 567*2+230;
            break;
        case 5:
            height_collectionview = 567*2+450;
            break;
            
        default:
            break;
    }
    
    if (flag_HistoryOff==TRUE) {
        height_collectionview -= 200;
    }
    
    if (flag_WeatherOff==TRUE) {
        height_collectionview -= 200;
    }
    
    [self.scrl_Main setContentOffset:CGPointMake(0, 0) animated:YES];
    NSLog(@"%@",self.ary_Menu);
    NSMutableArray *firstSection = [[NSMutableArray alloc] init];
    [firstSection addObject:[self.ary_Menu objectAtIndex:0]];
    
    NSMutableArray *secondSection = [[NSMutableArray alloc] init];
    [secondSection addObject:[self.ary_Menu objectAtIndex:1]];
    
    NSMutableArray *thirdSection = [[NSMutableArray alloc] init];
    for (int i=2; i<self.ary_Menu.count; i++) {
        [thirdSection addObject:[self.ary_Menu objectAtIndex:i]];
    }
    
    self.ary_collectionItems = [[NSArray alloc] initWithObjects:firstSection,secondSection,thirdSection, nil];
    NSLog(@"%@",self.ary_collectionItems);
    
    
   
    [self.collectionView reloadData];
    
}

- (NSInteger)ageFromBirthday:(NSDate *)birthdate {
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthdate
                                       toDate:today
                                       options:0];
    return ageComponents.year;
}
-(void)viewWillAppear:(BOOL)animated
{
    if (appDelegate.flag_FromSU==TRUE) {
        appDelegate.flag_FromSU=FALSE;
        [self.scrl_Main setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    else {
    [self PreapareCollectionview];
    [self ArrangeScrlViewContainer:height_collectionview];
    
    if (appDelegate.flag_IsLoggedIn==TRUE) {
        
        
        id json = [NSJSONSerialization JSONObjectWithData:[prefs valueForKey:LOGGEDINUSERDATA] options:0 error:nil];
        NSLog(@"%@",json);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self GetHCDetailWSCall];
        });
        
        self.lbl_ProfileName.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"DisplayNameEnglish"]];
        self.lbl_HCNumber.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"HCNumber"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeZone *currentTimeZone = [NSTimeZone defaultTimeZone];
        [dateFormatter setTimeZone:currentTimeZone];
        NSString *str_dateTemp = [NSString stringWithFormat:@"%@",[json valueForKey:@"DOB"]];
        NSArray *temp_DateArray = [str_dateTemp componentsSeparatedByString:@"T"];
        NSDate *birthdate = [dateFormatter dateFromString:[temp_DateArray objectAtIndex:0]];
        long age = [self ageFromBirthday:birthdate];
        NSString *str_gender = @"";
        NSString *str_genderTemp = [NSString stringWithFormat:@"%@",[json valueForKey:@"Gender"]];
        if ([str_genderTemp isEqualToString:@"M"])
            str_gender = @"Male";
        else
            str_gender = @"Female";
        self.lbl_GenderAge.text = [NSString stringWithFormat:@"%@, %li Years Old",str_gender,age];
        //DOB//Gender
        
        
        
        self.lbl_HCExpire.text = [NSString stringWithFormat:@"%@",[json valueForKey:@""]];
        
        
        self.btn_LoginToContinue.hidden=TRUE;
        
        self.lbl_ProfileName.hidden=FALSE;
        self.lbl_GenderAge.hidden=FALSE;
        self.lbl_HCStatic.hidden=FALSE;
        self.lbl_HCNumber.hidden=FALSE;
        self.lbl_HCExpire.hidden=FALSE;
        self.btn_AddUser.hidden=FALSE;
        self.btn_SwitchProfile.hidden=FALSE;
        self.btn_Logout.hidden=FALSE;
    }
    else {
        self.btn_LoginToContinue.hidden=FALSE;
        
        self.lbl_ProfileName.hidden=TRUE;
        self.lbl_GenderAge.hidden=TRUE;
        self.lbl_HCStatic.hidden=TRUE;
        self.lbl_HCNumber.hidden=TRUE;
        self.lbl_HCExpire.hidden=TRUE;
        self.btn_AddUser.hidden=TRUE;
        self.btn_SwitchProfile.hidden=TRUE;
        self.btn_Logout.hidden=TRUE;
    }
    }
}

#pragma mark service callls




-(void)GetHCDetailWSCall
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
    NSString *urlAddress = [NSString stringWithFormat:@"%@%@",GETHCINFORMATION,hcNumber];
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    [request setRequestMethod:@"GET"];
    request.delegate = self;
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"uid" value:[prefs stringForKey:@"UID"]];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetHCDetailRequestFinished:)];
    [request setDidFailSelector:@selector(GetHCDetailRequestFailed:)];
    @try {
        [request startAsynchronous];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
- (void)GetHCDetailRequestFinished:(ASIHTTPRequest *)request{
    //NSData *responseData = [request responseData];
    //NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    
    if (json!=nil) {
        self.lbl_HCExpire.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"Expiry"]];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self GetPatientInfoWSCall];
    });
}
- (void)GetHCDetailRequestFailed:(ASIHTTPRequest *)request {
    NSData *responseData = [request responseData];
    NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self GetPatientInfoWSCall];
    });
}


-(void)GetPatientInfoWSCall
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
    NSString *urlAddress = [NSString stringWithFormat:@"%@%@",GETPATIENTINFORMATION,hcNumber];
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    [request setRequestMethod:@"GET"];
    request.delegate = self;
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"uid" value:[prefs stringForKey:@"UID"]];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetPatientInfoRequestFinished:)];
    [request setDidFailSelector:@selector(GetPatientInfoRequestFailed:)];
    @try {
        [request startAsynchronous];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
- (void)GetPatientInfoRequestFinished:(ASIHTTPRequest *)request{
    //NSData *responseData = [request responseData];
    //NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    
    if (json!=nil) {
        self.str_PHCCode = [json valueForKey:@"PHCCode"];
        [self GetPHCDetails:self.str_PHCCode];
    }
    
}
- (void)GetPatientInfoRequestFailed:(ASIHTTPRequest *)request {
    NSData *responseData = [request responseData];
    NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}


-(IBAction)GetPHCDetails:(NSString*)str
{
    str = self.str_PHCCode;
    self.iv_PHCArrow.hidden=FALSE;
    self.iv_FacilityArrow.hidden=TRUE;
    self.iv_PharmacyArrow.hidden=TRUE;
    _btn_NearPharamcy.selected=FALSE;
    _btn_PHC.selected=TRUE;
    _btn_NearestFacility.selected=FALSE;
    
    
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
    NSArray *PARAMS = [NSArray  arrayWithObjects:@"?SamName=",nil];
    NSString *str_HCNumber;
    str_HCNumber = [NSString stringWithFormat:@"%@",[json valueForKey:@"HCNumber"]];
    
    NSString *hcNumber = [NSString stringWithFormat:@"%@%@",[PARAMS objectAtIndex:0],str];
    NSString *urlAddress = [NSString stringWithFormat:@"%@%@",GETFACILITYINFORMATIONBYSAMNAME,hcNumber];
    
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    [request setRequestMethod:@"GET"];
    request.delegate = self;
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"uid" value:[prefs stringForKey:@"UID"]];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetFacilityDetailsBySameNameRequestFinished:)];
    [request setDidFailSelector:@selector(GetFacilityDetailsBySameNameRequestFailed:)];
    @try {
        [request startAsynchronous];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}
- (void)GetFacilityDetailsBySameNameRequestFinished:(ASIHTTPRequest *)request{
    //NSData *responseData = [request responseData];
    //NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    self.lbl_FacilityName.text = [[json objectAtIndex:0] valueForKey:@"Name"];
    self.facilityLatitude = [[[json objectAtIndex:0] valueForKey:@"CordinateX"] floatValue];
    self.facilityLongitude = [[[json objectAtIndex:0] valueForKey:@"CordinateY"] floatValue];
    [self CalculateDistanceUsingGoogleCall:self.facilityLatitude longitude:self.facilityLongitude];
    
    /*dispatch_async(dispatch_get_main_queue(), ^{
        [self GetAppointmentDetailWSCall];
    });*/
}
- (void)GetFacilityDetailsBySameNameRequestFailed:(ASIHTTPRequest *)request {
    /*self.lbl_NearestHealthCenterValue.text = @"PHC details not available";
    self.lbl_TimeToReachCenter.text = @"N/A";
    self.lbl_DistanceToCenter.text = @"N/A";*/
}


-(void)CalculateDistanceUsingGoogleCall:(float)FacilityLatitude longitude:(float)FacilityLongitude
{
    NSString *urlAddress = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false&units=metric",appDelegate.currentLatitude,appDelegate.currentLongitude,FacilityLatitude,FacilityLongitude];
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    [request setRequestMethod:@"POST"];
    request.delegate = self;
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetNearestFacilityDetailRequestFinished:)];
    [request setDidFailSelector:@selector(GetNearestFacilityDetailRequestFailed:)];
    @try {
        [request startAsynchronous];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

- (void)GetNearestFacilityDetailRequestFinished:(ASIHTTPRequest *)request{
    //NSData *responseData = [request responseData];
    //NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:json];
        NSMutableArray *ary = [NSMutableArray arrayWithArray:[mdic valueForKeyPath:@"routes"]];
        NSMutableDictionary *mdic_Distance = [NSMutableDictionary dictionaryWithDictionary:[[[[ary objectAtIndex:0] valueForKey:@"legs"] objectAtIndex:0] valueForKey:@"distance"]];
        NSMutableDictionary *mdic_Duration = [NSMutableDictionary dictionaryWithDictionary:[[[[ary objectAtIndex:0] valueForKey:@"legs"] objectAtIndex:0] valueForKey:@"duration"]];
        ////////NSLog(@"%@", [mdic_Distance valueForKey:@"text"]);
        if (mdic_Duration.count>0)
            self.lbl_TimeToReachCenter.text = [NSString stringWithFormat:@"%@",[mdic_Duration valueForKey:@"text"]];
        else
            self.lbl_TimeToReachCenter.text = @"N/A";
        if (mdic_Distance.count>0)
            self.lbl_DistanceToCenter.text = [NSString stringWithFormat:@"%@",[mdic_Distance valueForKey:@"text"]];
        else
            self.lbl_DistanceToCenter.text = @"N/A";
        
        
    }
    @catch (NSException *exception) {
        self.lbl_TimeToReachCenter.text = @"N/A";
        self.lbl_DistanceToCenter.text = @"N/A";
        
    }
    @finally {
        
    }
    
}
- (void)GetNearestFacilityDetailRequestFailed:(ASIHTTPRequest *)request {
    self.lbl_TimeToReachCenter.text = @"N/A";
    self.lbl_DistanceToCenter.text = @"N/A";
    
}



-(void)ArrangeScrlViewContainer:(float)height
{
    [self.view setNeedsUpdateConstraints];
    float i= height;//self.scrl_Container.frame.size.height
    NSLog(@"%f",i);
    int width = self.view.frame.size.width;
    [self.scrl_Main setContentSize:CGSizeMake(0, i)];
    self.scrl_Main.translatesAutoresizingMaskIntoConstraints  = NO;
    ViewHeightConstraint.constant = i-700;
    CGRect frame_view_container = self.view_SCRLContainer.frame;
    frame_view_container.size.height = i;
    self.view_SCRLContainer.frame=frame_view_container;
    self.collectionView.frame = frame_view_container;
    self.view_SCRLContainer.translatesAutoresizingMaskIntoConstraints = NO;
    //[self.scrl_Container addSubview:self.view_Container];
    
    NSDictionary *views = @{@"beeView":self.view_SCRLContainer};
    if (IS_IPHONE_5) {
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @(width)};
        [self.scrl_Main addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        //[self.scrl_Container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6){
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @(width)};
        [self.scrl_Main addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        //[self.scrl_Container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6Plus){
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @(width)};
        [self.scrl_Main addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        //[self.scrl_Container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
}


-(IBAction)HomeClicked
{
    self.view_Gradient.hidden=FALSE;
    self.view_Menu.hidden=FALSE;
    CGRect basketTopFrame = self.view_Menu.frame;
    basketTopFrame.origin.x = 0;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.view_Menu.frame = basketTopFrame; } completion:^(BOOL finished){ }];
}
-(void)HideMenu
{
    CGRect napkinBottomFrame = self.view_Menu.frame;
    if (IS_IPHONE_6Plus)
        napkinBottomFrame.origin.x = -330;
    else
        napkinBottomFrame.origin.x = -291;
    [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{ self.view_Menu.frame = napkinBottomFrame; } completion:^(BOOL finished){/*done*/}];
    self.view_Gradient.hidden=TRUE;
    //self.view_Menu.hidden=TRUE;
    
    
}
-(IBAction)BackClicked
{
    [appDelegate LogoutClicked];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)LangaugeClicked
{
    
}
-(IBAction)ManageItemsClicked
{
    ManageItemViewController *obj_ManageItemViewController = [[ManageItemViewController alloc] initWithNibName:@"ManageItemViewController" bundle:nil];
    [self.navigationController pushViewController:obj_ManageItemViewController animated:YES];
}
-(IBAction)LogoutClickedMain
{
    self.view_Menu.hidden=TRUE;
    self.view_Gradient.hidden=TRUE;
    [appDelegate LogoutClicked];
    
}
-(IBAction)LogoutClicked
{
    self.view_Menu.hidden=TRUE;
    self.view_Gradient.hidden=TRUE;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)GotoVaccination:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    long sender_tag = btn.tag;
    if (sender_tag==2) {
        VaccinationViewController *obj_VaccinationViewController = [[VaccinationViewController alloc] initWithNibName:@"VaccinationViewController" bundle:nil];
        [self.navigationController pushViewController:obj_VaccinationViewController animated:YES];
    }
    
}
-(IBAction)SearchForDAndFClicked
{
    
}
-(IBAction)SwitchUserClicked
{
    [self HideMenu];
    appDelegate.flag_FromSU = TRUE;
    SwitchProfileViewController *obj_SwitchProfileViewController = [[SwitchProfileViewController alloc] initWithNibName:@"SwitchProfileViewController" bundle:nil];
    [self.navigationController pushViewController:obj_SwitchProfileViewController animated:YES];
}
-(IBAction)NotifiationCenterClicked
{
    NotificationsViewController *obj_NotificationsViewController = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
    [self.navigationController pushViewController:obj_NotificationsViewController animated:YES];
}
-(IBAction)EmergencyContactsClicked
{
    EmergencyContactsViewController *obj_EmergencyContactsViewController = [[EmergencyContactsViewController alloc] initWithNibName:@"EmergencyContactsViewController" bundle:nil];
    [self presentViewController:obj_EmergencyContactsViewController animated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    /*FIndDotorsAndFacilitiesViewController *obj_FIndDotorsAndFacilitiesViewController = [[FIndDotorsAndFacilitiesViewController alloc] initWithNibName:@"FIndDotorsAndFacilitiesViewController" bundle:nil];
    [self.navigationController pushViewController:obj_FIndDotorsAndFacilitiesViewController animated:YES];*/
    SLParallaxController *obj_SLParallaxController = [SLParallaxController new];
    [self.navigationController pushViewController:obj_SLParallaxController animated:YES];
    
    return YES;
    
}


CGFloat lastContentOffset;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (lastContentOffset > scrollView.contentOffset.y)
    {
        CGRect basketTopFrame = self.view_Footer.frame;
        basketTopFrame.origin.y = self.view.frame.size.height-47;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.view_Footer.frame = basketTopFrame; } completion:^(BOOL finished){ }];
        [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(ShowFooterImage) userInfo:nil repeats:NO];
    }
    else if (lastContentOffset < scrollView.contentOffset.y)
    {
        if(lastContentOffset>0) {
        CGRect basketTopFrame = self.view_Footer.frame;
        basketTopFrame.origin.y = self.view.frame.size.height;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ self.view_Footer.frame = basketTopFrame; } completion:^(BOOL finished){ }];
        }
        iv_FooterImage.hidden=true;
    }
    lastContentOffset = scrollView.contentOffset.y;
}
-(void)ShowFooterImage
{
    iv_FooterImage.hidden=false;
}


-(IBAction)FacilityClicked
{
    
    self.iv_PHCArrow.hidden=TRUE;
    self.iv_FacilityArrow.hidden=FALSE;
    self.iv_PharmacyArrow.hidden=TRUE;
    
    _btn_NearPharamcy.selected=FALSE;
    _btn_PHC.selected=FALSE;
    _btn_NearestFacility.selected=TRUE;
    
    
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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    ////NSLog(@"%f",appDelegate.currentLatitude);
    NSString *str_latitude = [NSString stringWithFormat:@"%f",appDelegate.currentLatitude];
    NSString *str_longitude = [NSString stringWithFormat:@"%f",appDelegate.currentLongitude];
    //NSString *urlAddress = [NSString stringWithFormat:@"https://eservices.dha.gov.ae/SmartPhoneWebAPI/SmartPhoneSyncData/GetArea"];
    NSString *urlAddress = [NSString stringWithFormat:@"https://eservices.dha.gov.ae/SmartPhoneWebAPI/Facility/GetNearestFacilites?latitude=%@&longitude=%@",str_latitude,str_longitude];
    __block ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    [request setRequestMethod:@"GET"];
    [request setDelegate:self];
    [self AddRequestHeaders:request token:encryptedString];
    [request setDidFinishSelector:@selector(NearestFacilityRequestFinished:)];
    [request setDidFailSelector:@selector(NearestFacilityRequestFailed:)];
    [request startSynchronous];
}
- (void)NearestFacilityRequestFinished:(ASIHTTPRequest *)request{
    id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    NSLog(@"%@",json);
    self.lbl_FacilityName.text = [NSString stringWithFormat:@"%@",[[json objectAtIndex:0] valueForKey:@"FacilityNameEn"]];
    self.facilityLatitude = [[[json objectAtIndex:0] valueForKey:@"Latitude"] floatValue];
    self.facilityLongitude = [[[json objectAtIndex:0] valueForKey:@"Longitude"] floatValue];
    
    [self CalculateDistanceUsingGoogleCall:self.facilityLatitude longitude:self.facilityLongitude];
}
- (void)NearestFacilityRequestFailed:(ASIHTTPRequest *)request {
    NSData *responseData = [request responseData];
    NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}
-(void)AddRequestHeaders :(ASIFormDataRequest*)request token:(NSString*)encryptedString
{
    NSString *uid = [prefs stringForKey:@"UID"];
    [request addRequestHeader:@"AppId" value:@"SEHHATY"];
    [request addRequestHeader:@"uid" value:uid];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
}


-(IBAction)Pharmacyclicked
{
    self.iv_PHCArrow.hidden=TRUE;
    self.iv_FacilityArrow.hidden=TRUE;
    self.iv_PharmacyArrow.hidden=FALSE;
    
    _btn_NearPharamcy.selected=TRUE;
    _btn_PHC.selected=FALSE;
    _btn_NearestFacility.selected=FALSE;
    
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
    NSString *urlAddress = [NSString stringWithFormat:@"https://eservices.dha.gov.ae/SmartPhoneWebAPI/Pharmacy/GetPharmacies?day=0"];
    __block ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlAddress]];
    [request setRequestMethod:@"GET"];
    
    
    [request setDelegate:self];
    [self AddRequestHeaders:request token:encryptedString];
    
    [request setDidFinishSelector:@selector(Pharmacy247RequestFinished:)];
    [request setDidFailSelector:@selector(Pharmacy247RequestFailed:)];
    [request startAsynchronous];
    
}

- (void)Pharmacy247RequestFinished:(ASIHTTPRequest *)request{
    id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    NSLog(@"%@",json);
    self.lbl_FacilityName.text = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"pharmacies"]objectAtIndex:0] valueForKey:@"nameEnglish"]];
    self.facilityLatitude = [[[[json valueForKey:@"pharmacies"]objectAtIndex:0] valueForKey:@"latitude"] floatValue];
    self.facilityLongitude = [[[[json valueForKey:@"pharmacies"]objectAtIndex:0] valueForKey:@"longitude"] floatValue];
    
    [self CalculateDistanceUsingGoogleCall:self.facilityLatitude longitude:self.facilityLongitude];
}
- (void)Pharmacy247RequestFailed:(ASIHTTPRequest *)request {
    NSData *responseData = [request responseData];
    NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",str_Response);
}


-(IBAction)SeeDirectionClicked
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/?daddr=%f,%f&saddr=%f,%f",self.facilityLatitude,self.facilityLongitude,appDelegate.currentLatitude,appDelegate.currentLongitude]]];
}
-(IBAction)LinkChildClicked
{
    [self HideMenu];
}
#pragma mark UICollectionView Delagates

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.ary_collectionItems count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [self.ary_collectionItems objectAtIndex:section];
    return [sectionArray count];
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (flag_HistoryOff==TRUE)
            return CGSizeMake(10, 10);
        else
            return CGSizeMake(self.view.frame.size.width-20, 220);
    }
    else if(indexPath.section==1)
    {
        if (flag_WeatherOff==TRUE)
            return CGSizeMake(10, 10);
        else
            return CGSizeMake(self.view.frame.size.width-20, 220);
    }
    else {
        return CGSizeMake((self.view.frame.size.width/2)-15, 220);
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"cvCell";
    
    /*  Uncomment this block to use nib-based cells */
    // UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    // UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    // [titleLabel setText:cellData];
    /* end of nib-based cell block */
    
    /* Uncomment this block to use subclass-based cells */
    CVCell *cell = (CVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSMutableArray *data = [self.ary_collectionItems objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];
    //[cell.titleLabel setText:cellData];
    if (indexPath.section==1) {
        cell.view_weather.hidden=FALSE;
        cell.view_History.hidden=TRUE;
        cell.view_Appointments.hidden=TRUE;
    }
    else if (indexPath.section==0){
        cell.view_weather.hidden=TRUE;
        cell.view_History.hidden=FALSE;
        if (appDelegate.flag_IsLoggedIn==TRUE) {
            cell.lbl_LoginStatic.hidden=TRUE;//temp hidden deval for logged in user
            cell.btn_ClickHereTL.hidden=TRUE;//temp hidden deval for logged in user
            cell.btn_CompleteHistory.hidden=FALSE;
            cell.view_HistoryForLoggedInUser.hidden=FALSE;//temp hidden deval for guest user
        }
        else {
            cell.lbl_LoginStatic.hidden=FALSE;//temp hidden deval for logged in user
            cell.btn_ClickHereTL.hidden=FALSE;//temp hidden deval for logged in user
            cell.btn_CompleteHistory.hidden=TRUE;
            cell.view_HistoryForLoggedInUser.hidden=TRUE;//temp hidden deval for guest user
        }
        [cell.btn_CompleteHistory addTarget:self action:@selector(ViewHistory) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_ClickHereTL addTarget:self action:@selector(LogoutClicked) forControlEvents:UIControlEventTouchUpInside];
        cell.view_Appointments.hidden=TRUE;
    }
    else if (indexPath.section==2){
        cell.view_weather.hidden=TRUE;
        cell.view_History.hidden=TRUE;
        cell.view_Appointments.hidden=FALSE;
        [cell.lbl_Appointments setText:cellData];
    }
    else {
        cell.view_weather.hidden=TRUE;
        cell.view_History.hidden=TRUE;
        [cell.lbl_Appointments setText:cellData];
    }
    if ([cellData isEqualToString:@"APPOINTMENTS"]) {
        [cell.lbl_Appointments setTextColor:[UIColor colorWithRed:(128.0/255.0) green:(150.0/255.0) blue:(235.0/255.0) alpha:1.0]];
        [cell.lbl_AppointmentDate setTextColor:[UIColor colorWithRed:(128.0/255.0) green:(150.0/255.0) blue:(235.0/255.0) alpha:1.0]];
        
        [cell.lbl_LoginStaticForAppointments setText:@"Please login to view appontments"];
        [cell.btn_LoginForAppointments setBackgroundColor:[UIColor colorWithRed:(128.0/255.0) green:(150.0/255.0) blue:(235.0/255.0) alpha:1.0]];
        [cell.btn_LoginForAppointments addTarget:self action:@selector(LogoutClicked) forControlEvents:UIControlEventTouchUpInside];
        cell.btn_AppointmentsDetails.tag=1;
        [cell.btn_AppointmentsDetails setTitle:@"ALL APPOINTMENTS" forState:UIControlStateNormal];
        [cell.btn_AppointmentsDetails setBackgroundColor:[UIColor colorWithRed:(128.0/255.0) green:(150.0/255.0) blue:(235.0/255.0) alpha:1.0]];
        [cell.lbl_LineForAppointment setBackgroundColor:[UIColor colorWithRed:(128.0/255.0) green:(150.0/255.0) blue:(235.0/255.0) alpha:1.0]];
        
        [cell.lbl_AppointmentPlace setTextColor:[UIColor colorWithRed:(128.0/255.0) green:(150.0/255.0) blue:(235.0/255.0) alpha:1.0]];
        
        if (appDelegate.flag_IsLoggedIn==TRUE) {
            cell.lbl_LoginStaticForAppointments.hidden=TRUE;
            cell.btn_LoginForAppointments.hidden=TRUE;
            cell.view_AppointmentsForLoggedInUser.hidden=FALSE;
        }
        else {
            cell.lbl_LoginStaticForAppointments.hidden=FALSE;
            cell.btn_LoginForAppointments.hidden=FALSE;
            cell.view_AppointmentsForLoggedInUser.hidden=TRUE;
        }
        
        [cell.iv_AppointmentImage setImage:[UIImage imageNamed:@"calendar_icon.png"]];
        [cell.btn_AppointmentsDetails addTarget:self action:@selector(ViewAppointments) forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([cellData isEqualToString:@"NEXT VACCINATION"]) {
        [cell.lbl_Appointments setTextColor:[UIColor colorWithRed:(88.0/255.0) green:(189.0/255.0) blue:(223.0/255.0) alpha:1.0]];
        [cell.lbl_AppointmentDate setTextColor:[UIColor colorWithRed:(88.0/255.0) green:(189.0/255.0) blue:(223.0/255.0) alpha:1.0]];
        [cell.lbl_LoginStaticForAppointments setText:@"Please login to view vaccination"];
        [cell.btn_LoginForAppointments setBackgroundColor:[UIColor colorWithRed:(88.0/255.0) green:(189.0/255.0) blue:(223.0/255.0) alpha:1.0]];
        [cell.iv_AppointmentImage setImage:[UIImage imageNamed:@"vaccination_icon.png"]];
        [cell.btn_LoginForAppointments addTarget:self action:@selector(LogoutClicked) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_AppointmentsDetails setTitle:@"VIEW DETAILS" forState:UIControlStateNormal];
        [cell.btn_AppointmentsDetails setBackgroundColor:[UIColor colorWithRed:(88.0/255.0) green:(189.0/255.0) blue:(223.0/255.0) alpha:1.0]];
        cell.btn_AppointmentsDetails.tag=2;
        [cell.btn_AppointmentsDetails addTarget:self action:@selector(GotoVaccination:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.lbl_LineForAppointment setBackgroundColor:[UIColor colorWithRed:(88.0/255.0) green:(189.0/255.0) blue:(223.0/255.0) alpha:1.0]];
        [cell.lbl_AppointmentPlace setTextColor:[UIColor colorWithRed:(88.0/255.0) green:(189.0/255.0) blue:(223.0/255.0) alpha:1.0]];
        
        if (appDelegate.flag_IsLoggedIn==TRUE) {
            cell.lbl_LoginStaticForAppointments.hidden=TRUE;
            cell.btn_LoginForAppointments.hidden=TRUE;
            cell.view_AppointmentsForLoggedInUser.hidden=FALSE;
        }
        else {
            cell.lbl_LoginStaticForAppointments.hidden=FALSE;
            cell.btn_LoginForAppointments.hidden=FALSE;
            cell.view_AppointmentsForLoggedInUser.hidden=TRUE;
        }
    }
    else if ([cellData isEqualToString:@"DHA HEALTH BOOK"]) {
        [cell.lbl_Appointments setTextColor:[UIColor colorWithRed:(200.0/255.0) green:(132.0/255.0) blue:(244.0/255.0) alpha:1.0]];
        [cell.lbl_AppointmentDate setTextColor:[UIColor colorWithRed:(200.0/255.0) green:(132.0/255.0) blue:(244.0/255.0) alpha:1.0]];
        [cell.lbl_AppointmentDate setText:@"View Videos and Articles"];
        [cell.lbl_LoginStaticForAppointments setHidden:TRUE];
        [cell.btn_LoginForAppointments setHidden:TRUE];
        [cell.iv_AppointmentImage setImage:[UIImage imageNamed:@"dha_health_book_icon.png"]];
        
        cell.btn_AppointmentsDetails.tag=3;
        [cell.btn_AppointmentsDetails setTitle:@"VIEW HEALTHBOOK" forState:UIControlStateNormal];
        [cell.btn_AppointmentsDetails setBackgroundColor:[UIColor colorWithRed:(200.0/255.0) green:(132.0/255.0) blue:(244.0/255.0) alpha:1.0]];
        
        
        cell.lbl_LoginStaticForAppointments.hidden=TRUE;
        cell.btn_LoginForAppointments.hidden=TRUE;
        
        cell.lbl_LineForAppointment.hidden=TRUE;
        cell.lbl_AppointmentPlace.hidden=TRUE;
    }
    
    // Return the cell
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // If you need to use the touched cell, you can retrieve it like so
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
}


-(void)ViewHistory
{
    HistoryViewController *obj_HistoryViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    [self.navigationController pushViewController:obj_HistoryViewController animated:YES];
}
-(void)ViewAppointments
{
    AppointmentsViewController *obj_AppointmentsViewController = [[AppointmentsViewController alloc] initWithNibName:@"AppointmentsViewController" bundle:nil];
    [self.navigationController pushViewController:obj_AppointmentsViewController animated:YES];
}


#pragma mark Happiness Meter Integration 


#pragma mark - gesture recognizer
-(IBAction)actionTapGesturePerformed:(id)sender {
    [self calcelWebviewRequest];
}


#pragma mark - gesture recognizer
-(IBAction)actionLog:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    request_type = tag;
    
    [self logRequestWithVotingManager];
}

-(void)logRequestWithVotingManager {
    
    //set your preferred language accordingly. e.g. ar, en
    lang = (self.segmentedControl.selectedSegmentIndex == 0) ? @"en" : @"ar";
    
    //To be replaced by the English/Arabic micro app display name.
    microAppDisplay = (self.segmentedControl.selectedSegmentIndex == 0) ? @"Micro App" : @"مايكرو أيب";
    
    //To be replaced by the credentials if present.
    User *user = [[User alloc] initWithPrams:@"ANONYMOUS" username:@"" email:@"" mobile:@""];
    
    //set themeColor as per your requirements e.g. #ff0000, #00ff00
    Header *header = [[Header alloc] initWithPrams:[Util currentTimestamp]
                                   serviceProvider:serviceProvider
                                      request_type:request_type
                                          microApp:microApp
                                   microAppDisplay:microAppDisplay
                                        themeColor:@"#00ff00"];
    
    //To be replaced by the credentials if present.
    Application *application = [[Application alloc] initWithPrams:@"Sehhaty"
                                                             type:@"SMARTAPP"
                                                         platform:@"ANDROID"
                                                              url:@"https://dha.gov.ae"
                                                            notes:@"MobileSDK Vote"];
    
    //To be replaced by the credentials if present.
    Transaction *transaction = [[Transaction alloc] initWithPrams:@"SAMPLE123-REPLACEWITHACTUAL!"
                                                      gessEnabled:@"false"
                                                      serviceCode:@""
                                               serviceDescription:@"demo transaction"
                                                          channel:@"WEB"];
    
    //create the voting request
    VotingRequest *votingRequest = [[VotingRequest alloc] initWithPrams:user
                                                                 header:header
                                                            application:application
                                                            transaction:transaction];
    
    //init voting manager to execute the request
    VotingManager *votingManager = [[VotingManager alloc] initWithPrams:serviceProviderSecret clientID:clientID lang:lang];
    
    [votingManager loadRequestWithWebView:self.webView usingVotignRequest:votingRequest];
    
    self.webView.alpha = 1.0f;
}

//calcel the webview request
-(void)calcelWebviewRequest {
    
    //load blank page
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    //hide webview
    self.webView.alpha = 0.0f;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if([[request.URL absoluteString] containsString:@"happiness://done"]) {
        [self calcelWebviewRequest];
    }
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError: %@", error);
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
