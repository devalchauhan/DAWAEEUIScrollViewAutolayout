//
//  Constants.h
//  IPhoneApp
//
//  Created by Muhammad Ahsan on 7/24/13.
//  Copyright (c) 2013 Dubai Health Authority. All rights reserved.
//


#ifndef DHASehati_Constants_h
#define DHASehati_Constants_h

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6Plus (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])


#endif


#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern NSString *const LOGGEDINUSERDATA;

extern NSString *const GetChildrenForSehathy;
extern NSString *const GetChildVaccinationForSehathy;
extern NSString *const AddChild;
extern NSString *const GetEmergencyContacts;
extern NSString *const GetNextAvailableAppointments;
extern NSString *const GetAppointmentsByHealthCard;
extern NSString *const HC_REGISTATION_CODE;
extern NSString *const REGISTATION_CODE;
extern NSString *const REGISTRATION_URL;
extern NSString *const HC_REGISTRATION_URL;
extern NSString *const WEBSERVICE_URL;
extern NSString *const WEBSERVICE_URL_AR;

extern NSString *const WEBAPI_HC_AUTHENTICATION_ADDRESS;
extern NSString *const WEBAPI_HC_CODE_AUTHENTICATION_ADDRESS;
extern NSString *const WEBAPI_AUTHENTICATION_ADDRESS;
extern NSString *const WEBAPI_LOGOUT_ADDRESS;
extern NSString *const WEBAPI_USERID;
extern NSString *const WEBAPI_PASSWORD;
extern NSString *const GETSESSIONTOKEN;
extern NSString *const GETHCINFORMATION;
extern NSString *const GETPATIENTINFORMATION;
extern NSString *const GETFACILITYINFORMATION;
extern NSString *const GETFACILITYINFORMATIONBYSAMNAME;
extern NSString *const GETLABRESULTSINFORMATION;
extern NSString *const GETAPPOINTMENTSINFORMATION;
extern NSString *const LINKUSER;
extern NSString *const UNLINKUSER;


@end
