//
//  AppDelegate.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/17/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "CKCalendarViewControllerInternal.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    prefs = [NSUserDefaults standardUserDefaults];
    /*NSData *data = [prefs valueForKey:LOGGEDINUSERPROFILEDATA];
    NSLog(@"%lu",(unsigned long)data.length);
    NSString *user_id=@"";
    if (data.length>0) {
        id json = [NSJSONSerialization JSONObjectWithData:[prefs valueForKey:LOGGEDINUSERPROFILEDATA] options:0 error:nil];
        NSLog(@"%@",json);
        user_id = [NSString stringWithFormat:@"%@",[json valueForKey:@"UserId"]];
        
    }
    */
    id json;
    @try {
        json = [NSJSONSerialization JSONObjectWithData:[prefs valueForKey:LOGGEDINUSERDATA] options:0 error:nil];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    NSString *AUTH_TOKEN = [NSString stringWithFormat:@"%@",[json valueForKey:@"Token"]];
    if (AUTH_TOKEN.length==0||[AUTH_TOKEN isEqualToString:@"(null)"]||[AUTH_TOKEN isEqual:[NSNull null]]) {
        /// open it deval chauhan
        ViewController *obj_ViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:obj_ViewController];
    }
    else {
        self.flag_IsLoggedIn=TRUE;
        HomeViewController *obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:obj_HomeViewController];
    }
    ///Temp close it deval chauhan
    /*CKCalendarViewControllerInternal *obj_CKCalendarViewControllerInternal = [CKCalendarViewControllerInternal new];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:obj_CKCalendarViewControllerInternal];*/
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    self.ary_Menu = [NSMutableArray array];
    
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:self.HUD];
    [self.HUD bringSubviewToFront:self.window];
    self.HUD.delegate = self;
    /*NSString *str_Langauge = [NSString stringWithFormat:@"%@",[prefs valueForKey:@"Language"]];
    if([str_Langauge rangeOfString:@"ar"].location != NSNotFound)
        self.HUD.labelText = @"Loading.....";
    else
        self.HUD.labelText = @"تحميل .....";*/
    
    [self GETandSetLaungaugeCode];
    [self GETAndSetUID];
    [self copyDatabaseIntoDocumentsDirectory];
    
    locationManager = [[CLLocationManager alloc] init];
    if (IS_OS_8_OR_LATER)
        [locationManager requestWhenInUseAuthorization];
    
   
    UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    
    
    [locationManager startUpdatingLocation];
    locationManager.delegate = self;
    [self getUTCFormateDate:[NSDate date]];
    return YES;

}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    tokenAsString = [[[[deviceToken description]
                       stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                      stringByReplacingOccurrencesOfString:@" " withString:@""] copy];
    self.deviceToken = [NSString stringWithString:tokenAsString];
    
    NSLog(@"\n DeviceToken :%@",self.deviceToken);
    
    [[NSUserDefaults standardUserDefaults] setObject:self.deviceToken forKey:@"REGISTRATION_ID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *deviceTokenString1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"REGISTRATION_ID"];
    NSLog(@"My token is: %@", deviceTokenString1);
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    //NSLog(@"Failed to get token, error: %@", error);
    //self.viewController.deviceId = @"naeem";
}



-(void)LogoutClicked
{
    //[self LOGOUTServiceCall];
    [self AfterLOGOUTSetLoginViewController];
}
-(void)AfterLOGOUTSetLoginViewController
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self GETAndSetUID];
    [self GETandSetLaungaugeCode];
    ViewController *obj_ViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:obj_ViewController];
    self.window.rootViewController = self.navigationController;
}
/*-(void)LOGOUTServiceCall
{
    [self.HUD show:YES];
    NSString *uid = [prefs valueForKey:@"UID"];
    NSString *deviceType = @"IPhone";//,*IsLinking = @"N";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        deviceType=@"IPhone";
    }
    else
    {
        deviceType=@"IPad";
    }
    NSString *encryptedString = [CommonFunctions EnctyrptToken:uid];
    __block ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,LOGOUT]]];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [CommonFunctions AddRequestHeaders:request token:encryptedString uid:uid];
    [request setDidFinishSelector:@selector(LOGOUTRequestFinished:)];
    [request setDidFailSelector:@selector(LOGOUTRequestFailed:)];
    [request startAsynchronous];
    
}*/
- (void)LOGOUTRequestFinished:(ASIHTTPRequest *)request{
    [self.HUD hide:YES];
    NSData *responseData = [request responseData];
    NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str_Response);
    if ([str_Response isEqualToString:@"\"true\""]) {
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"ar"]) {
            str_AlertTitle = @"Success" ;
            str_AlertMessage = @"LOGOUT Successfully" ;
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = @"Success" ;
            str_AlertMessage = @"LOGOUT Successfully" ;
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
        
        //[self.navigationController popToRootViewControllerAnimated:YES];
        [self AfterLOGOUTSetLoginViewController];
    }
    else {
        NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
        if ([str_Language isEqualToString:@"ar"]) {
            str_AlertTitle = @"FAILURE" ;
            str_AlertMessage = @"Something went wrong" ;
            str_AlertButton = @"OK";
        }
        else {
            str_AlertTitle = @"FAILURE" ;
            str_AlertMessage = @"Something went wrong" ;
            str_AlertButton = @"حسنا";
        }
        [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    }
    
}

- (void)LOGOUTRequestFailed:(ASIHTTPRequest *)request {
    [self.HUD hide:YES];
    NSData *responseData = [request responseData];
    NSString *str_Response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str_Response);
    
    id json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    NSLog(@"JSON %@",json);
    
    NSString *str_AlertTitle,*str_AlertMessage,*str_AlertButton;
    if ([str_Language isEqualToString:@"ar"]) {
        str_AlertTitle = [json valueForKey:@"Status"] ;
        str_AlertMessage = [json valueForKey:@"Message"] ;
        str_AlertButton = @"OK";
    }
    else {
        str_AlertTitle = [json valueForKey:@"Status"] ;
        str_AlertMessage = [json valueForKey:@"Message"] ;
        str_AlertButton = @"حسنا";
    }
    [CommonFunctions ShowAlertMessage:str_AlertTitle MessageText:str_AlertMessage ButtonText:str_AlertButton];
    
    
}


-(void)getUTCFormateDate:(NSDate *)localDate
{
    double timestamp = [[NSDate date] timeIntervalSince1970];
    double milliseconds = timestamp*1000;
    NSLog(@"dateString :%.0f",milliseconds);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(milliseconds / 1000.0)];
    NSLog(@"date :%@",date);
}


#pragma mark DB Creadtion and Connection


#pragma mark -
#pragma mark LOCATION-METHOD

-(void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation
{
    self.currentLatitude = newLocation.coordinate.latitude;
    self.currentLongitude = newLocation.coordinate.longitude;
    //NSLog(@"currentLatitude%f",self.currentLatitude);
    //NSLog(@"currentLatitude%f",self.currentLatitude);
}


- (id)init
{
    self = [super init];
    if (self != nil)
    {
        NSString *remoteHostName = @"www.google.com";
        self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
        [self.hostReachability startNotifier];
        
        self.internetReachability = [Reachability reachabilityForInternetConnection];
        [self.internetReachability startNotifier];
        
        self.wifiReachability = [Reachability reachabilityForLocalWiFi];
        [self.wifiReachability startNotifier];
    }
    return self;
}
-(void)GETandSetLaungaugeCode
{
    NSString *languageCode = [prefs valueForKey:@"Language"];
    if (languageCode.length==0) {
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if ([language rangeOfString:@"ar"].location == NSNotFound) {
            [prefs setValue:@"en" forKey:@"Language"];
        } else {
            [prefs setValue:@"ar" forKey:@"Language"];
        }
        //[prefs setValue:language forKey:@"Language"];
        [prefs synchronize];
    }
}
-(void)GETAndSetUID
{
    
    uid = [prefs stringForKey:@"UID"];
    
    if([uid length]==0)
    {
        NSString* uniqueIdentifier = nil;
        if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)] ) { // >=iOS 7
            uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        } else { //<=iOS6, Use UDID of Device
            CFUUIDRef uuid = CFUUIDCreate(NULL);
            //uniqueIdentifier = ( NSString*)CFUUIDCreateString(NULL, uuid);- for non- ARC
            uniqueIdentifier = ( NSString*)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));// for ARC
            CFRelease(uuid);
        }
        uid=uniqueIdentifier;
        // for developement purpose only , please remove below link beofre submitting and open above line.
        //uid = [NSString stringWithFormat:@"516240B7-0A4E-4DCD-817E-0FF78F813F19"];
        uid = [uid stringByAppendingString:[NSString stringWithFormat:@"-SEHHATI"]];
        ////////NSLog(@"%@",uid);
        [prefs setValue:uid forKey:@"UID"];
        [prefs synchronize];
    }
    uid = [prefs stringForKey:@"UID"];
    NSLog(@"%@",uid);
}
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    UIApplication* application = [UIApplication sharedApplication];
    //NSArray* scheduledNotifications = application.scheduledLocalNotifications;
    //for (UILocalNotification* notification in scheduledNotifications) {
    
    NSDate* today = [NSDate date];
    
    
    NSDate* endDate = notif.userInfo[@"end_date"];
    if (![endDate isEqual:[NSNull null]]) {
        if ([today earlierDate:endDate] == endDate) {
            //Cancel the notification
            [application cancelLocalNotification:notif];
        }
        else {
        }
    }
    int days_interval = [notif.userInfo[@"days_interval"] intValue];
    if (days_interval>0) {
        int day = 24*60*60;
        NSTimeInterval interval = day * days_interval;
        notif.fireDate = [NSDate dateWithTimeInterval:interval sinceDate:today];
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
}

-(void)copyDatabaseIntoDocumentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentsDirectory = [paths objectAtIndex:0];
    self.databaseFilename = @"dawaee.sqlite";
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    self.databasePath = destinationPath;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
