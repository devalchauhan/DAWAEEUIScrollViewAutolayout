//
//  Constants.m
//  IPhoneApp
//
//  Created by Muhammad Ahsan on 7/24/13.
//  Copyright (c) 2013 Dubai Health Authority. All rights reserved.
//

//10.1.249.94
////// i have replaced 10.1.249.94 to 10.1.249.94
//httttps://eservices.dha.gov.ae/SmartPhoneWebMVC////
//httttps://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItestTest///
#import "Constants.h"

@implementation Constants

NSString *const LOGGEDINUSERDATA = @"LOGGEDINUSERDATA";
NSString *const REGISTATION_CODE = @"SmartPhoneApp=EServiceRegistration";
NSString *const HC_REGISTATION_CODE = @"SmartPhoneApp=HISRegistration";
NSString *const REGISTRATION_URL = @"https://eservicesstg.dha.gov.ae:8080/DHAWeb/Account/UserRegistration.aspx";
NSString *const HC_REGISTRATION_URL = @"http://eservice.dohms.gov.ae/pservices/CreatePIDO.aspx";

NSString *const WEBSERVICE_URL = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebMVC/en/Route?";
NSString *const WEBSERVICE_URL_AR = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebMVC/ar/Route?";
//NSString *const WEBSERVICE_URL = @"http://10.1.249.94/SmartPhoneWebMVC/en/Route?";
//NSString *const WEBSERVICE_URL_AR = @"http://10.1.249.94/SmartPhoneWebMVC/ar/Route?";

//NSString *const WEBAPI_HC_AUTHENTICATION_ADDRESS = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HealthCardVerification/GenerateVerificationCode";
//NSString *const WEBAPI_HC_CODE_AUTHENTICATION_ADDRESS = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HealthCardVerification/VerifyHealthCardCode";
NSString *const WEBAPI_HC_AUTHENTICATION_ADDRESS = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HealthCardVerification/GenerateVerificationCode";
//NSString *const WEBAPI_HC_AUTHENTICATION_ADDRESS = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HealthCardVerification/GenerateVerificationCode";
NSString *const WEBAPI_HC_CODE_AUTHENTICATION_ADDRESS = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HealthCardVerification/VerifyHealthCardCode";
//NSString *const WEBAPI_HC_CODE_AUTHENTICATION_ADDRESS = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HealthCardVerification/VerifyHealthCardCode";

//NSString *const WEBAPI_AUTHENTICATION_ADDRESS = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/Authentication/AuthenticateUser"; // live
NSString *const WEBAPI_AUTHENTICATION_ADDRESS = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/Authentication/AuthenticateUser"; // stagging 
//NSString *const WEBAPI_AUTHENTICATION_ADDRESS = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Authentication/AuthenticateUser";

//// in appdelegate please change the same logout static url
//NSString *const WEBAPI_LOGOUT_ADDRESS = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Authentication/Logout";
NSString *const WEBAPI_LOGOUT_ADDRESS = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/Authentication/Logout";
NSString *const WEBAPI_USERID = @"smartapiuser";
NSString *const WEBAPI_PASSWORD = @"smartapipassword";

NSString *const ERROR_PAGE_URL = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebMVC/en/Route?";
//NSString *const ERROR_PAGE_URL = @"http://10.1.249.94/SmartPhoneWebMVC/en/Route?";
NSString *const ERROR_PAGE_URL_AR = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebMVC/ar/Route?";
//NSString *const ERROR_PAGE_URL_AR = @"http://10.1.249.94/SmartPhoneWebMVC/ar/Route?";

NSString *const GETSESSIONTOKEN = @"http://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/s/gt";
//NSString *const GETSESSIONTOKEN = @"http://10.1.10.46/SmartPhoneExternalWebAPI/s/gt";



NSString *const GetChildrenForSehathy = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/SehathyVaccination/GetChildrenForSehathy";

NSString *const GetChildVaccinationForSehathy = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/SehathyVaccination/GetChildVaccinationForSehathy";


NSString *const AddChild = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/SehathyVaccination/AddChild";




NSString *const GetEmergencyContacts = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/ContactDirectory/GetEmergencyContacts";


NSString *const GetAppointmentsByHealthCard = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HIS/GetAppointments";

NSString *const GetNextAvailableAppointments = @"http://10.1.249.175/SmartPhoneExternalWebAPI/HIS/GetNextAvailableAppointments";



NSString *const GETHCINFORMATION = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HIS/GetHCInformation";
//NSString *const GETHCINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HIS/GetHCInformation";

NSString *const GETPATIENTINFORMATION = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HIS/GetPatientInformation";
//NSString *const GETPATIENTINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HIS/GetPatientInformation";

NSString *const GETFACILITYINFORMATION = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/Facility/GetFacilities";
//NSString *const GETFACILITYINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Facility/GetFacilities";

NSString *const GETFACILITYINFORMATIONBYSAMNAME = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/Facility/GetFacilityBySamName";
//NSString *const GETFACILITYINFORMATIONBYSAMNAME = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Facility/GetFacilityBySamName";

NSString *const GETLABRESULTSINFORMATION = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HIS/GetTopLabOrderResults";
//NSString *const GETLABRESULTSINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HIS/GetTopLabOrderResults";

NSString *const GETAPPOINTMENTSINFORMATION = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/HIS/GetAppointments";
//NSString *const GETAPPOINTMENTSINFORMATION = @"http://10.1.249.94/SmartPhoneExternalWebAPI/HIS/GetAppointments";

NSString *const LINKUSER = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/UserProfileLinking/LinkUserProfile";
//NSString *const LINKUSER = @"http://10.1.249.94/SmartPhoneExternalWebAPI/UserProfileLinking/LinkUserProfile";

NSString *const UNLINKUSER = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/UserProfileLinking/UnLinkUserProfile";
//NSString *const UNLINKUSER = @"http://10.1.249.94/SmartPhoneExternalWebAPI/UserProfileLinking/UnLinkUserProfile";

NSString *const GETNEARESTFACILITY = @"https://eservicesstg.dha.gov.ae:8080/SmartPhoneWebAPItest/Facility/GetNearestFacilites";
//NSString *const GETNEARESTFACILITY = @"http://10.1.249.94/SmartPhoneExternalWebAPI/Facility/GetNearestFacilites";


@end
