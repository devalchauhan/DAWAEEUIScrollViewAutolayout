//
//  AppDelegate.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/17/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>
{
    NSString *uid;
    NSUserDefaults *prefs;
    NSString *str_Language;
    
    CLLocationCoordinate2D cordi;
    CLLocationManager *locationManager;
    CLLocation *newlocation;
    
    NSString *deviceToken,*tokenAsString;
    
}
@property (strong, nonatomic) NSString *deviceToken;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) NSString *databaseName,*databasePath;
@property (readwrite) float currentLatitude, currentLongitude;

@property (nonatomic, strong) Reachability *hostReachability;
@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic, strong) Reachability *wifiReachability;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *ary_Menu;
@property (readwrite) BOOL flag_IsLoggedIn,flag_FromSU,*flag_LinkChild;

// For Appointment Reschedule
@property (nonatomic, strong) NSMutableDictionary *dic_SelectedAppointmentDetails;
-(void)copyDatabaseIntoDocumentsDirectory;
-(void)LogoutClicked;
@end

