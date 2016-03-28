//
//  Constants.m
//  IPhoneApp
//
//  Created by Muhammad Ahsan on 7/24/13.
//  Copyright (c) 2013 Dubai Health Authority. All rights reserved.
//

//10.1.249.94
////// i have replaced 10.1.249.94 to 10.1.249.94

#import "Constants.h"

@implementation Constants

NSString *const REGISTATION_CODE = @"SmartPhoneApp=EServiceRegistration";
NSString *const HC_REGISTATION_CODE = @"SmartPhoneApp=HISRegistration";
NSString *const REGISTRATION_URL = @"https://eservices.dha.gov.ae/DHAWeb/Account/UserRegistration.aspx";
NSString *const HC_REGISTRATION_URL = @"http://eservice.dohms.gov.ae/pservices/CreatePIDO.aspx";

NSString *const WEBSERVICE_URL = @"https://eservices.dha.gov.ae/SmartPhoneWebMVC/en/Route?";
NSString *const WEBSERVICE_URL_AR = @"https://eservices.dha.gov.ae/SmartPhoneWebMVC/ar/Route?";
//NSString *const WEBSERVICE_URL = @"http://10.1.249.94/SmartPhoneWebMVC/en/Route?";
//NSString *const WEBSERVICE_URL_AR = @"http://10.1.249.94/SmartPhoneWebMVC/ar/Route?";

//NSString *const WEBAPI_HC_AUTHENTICATION_ADDRESS = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HealthCardVerification/GenerateVerificationCode";
//NSString *const WEBAPI_HC_CODE_AUTHENTICATION_ADDRESS = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HealthCardVerification/VerifyHealthCardCode";
NSString *const WEBAPI_HC_AUTHENTICATION_ADDRESS = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/HealthCardVerification/GenerateVerificationCode";
NSString *const WEBAPI_HC_CODE_AUTHENTICATION_ADDRESS = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/HealthCardVerification/VerifyHealthCardCode";


NSString *const WEBAPI_AUTHENTICATION_ADDRESS = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/Authentication/AuthenticateUser";
//NSString *const WEBAPI_AUTHENTICATION_ADDRESS = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Authentication/AuthenticateUser";

//// in appdelegate please change the same logout static url
//NSString *const WEBAPI_LOGOUT_ADDRESS = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Authentication/Logout";
NSString *const WEBAPI_LOGOUT_ADDRESS = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/Authentication/Logout";
NSString *const WEBAPI_USERID = @"smartapiuser";
NSString *const WEBAPI_PASSWORD = @"smartapipassword";

NSString *const ERROR_PAGE_URL = @"https://eservices.dha.gov.ae/SmartPhoneWebMVC/en/Route?";
//NSString *const ERROR_PAGE_URL = @"http://10.1.249.94/SmartPhoneWebMVC/en/Route?";
NSString *const ERROR_PAGE_URL_AR = @"https://eservices.dha.gov.ae/SmartPhoneWebMVC/ar/Route?";
//NSString *const ERROR_PAGE_URL_AR = @"http://10.1.249.94/SmartPhoneWebMVC/ar/Route?";

NSString *const GETSESSIONTOKEN = @"http://eservices.dha.gov.ae/SmartPhoneWebAPI/s/gt";
//NSString *const GETSESSIONTOKEN = @"http://10.1.10.46/SmartPhoneExternalWebAPI/s/gt";


NSString *const GETHCINFORMATION = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/HIS/GetHCInformation";
//NSString *const GETHCINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HIS/GetHCInformation";

NSString *const GETPATIENTINFORMATION = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/HIS/GetPatientInformation";
//NSString *const GETPATIENTINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HIS/GetPatientInformation";

NSString *const GETFACILITYINFORMATION = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/Facility/GetFacilities";
//NSString *const GETFACILITYINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Facility/GetFacilities";

NSString *const GETFACILITYINFORMATIONBYSAMNAME = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/Facility/GetFacilityBySamName";
//NSString *const GETFACILITYINFORMATIONBYSAMNAME = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Facility/GetFacilityBySamName";

NSString *const GETLABRESULTSINFORMATION = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/HIS/GetTopLabOrderResults";
//NSString *const GETLABRESULTSINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HIS/GetTopLabOrderResults";

NSString *const GETAPPOINTMENTSINFORMATION = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/HIS/GetAppointments";
//NSString *const GETAPPOINTMENTSINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HIS/GetAppointments";

NSString *const LINKUSER = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/UserProfileLinking/LinkUserProfile";
//NSString *const LINKUSER = @"http://10.1.249.94/SmartPhoneExternalWebAPI/UserProfileLinking/LinkUserProfile";

NSString *const UNLINKUSER = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/UserProfileLinking/UnLinkUserProfile";
//NSString *const UNLINKUSER = @"http://10.1.249.94/SmartPhoneExternalWebAPI/UserProfileLinking/UnLinkUserProfile";

NSString *const GETNEARESTFACILITY = @"https://eservices.dha.gov.ae/SmartPhoneWebAPI/Facility/GetNearestFacilites";
//NSString *const GETNEARESTFACILITY = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Facility/GetNearestFacilites";


@end
