//
//  CommonFunctions.h
//  DGApp
//
//  Created by Deval Chauhan on 2/8/16.
//  Copyright © 2016 Syed Fahad Anwar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunctions : NSObject
{
    NSUserDefaults *prefs;
    NSString *str_Language;
    
}
/* AppDelegate object */
#define APP_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])

+(BOOL) IsInternetAvailable;
+(void) ShowAlertMessage:(NSString*)title MessageText:(NSString*)message ButtonText:(NSString*)button;
+(void) ShowAlertMessage:(NSString*)title MessageText:(NSString*)message ButtonText:(NSString*)button CancelButtonText:(NSString*)cancelbutton;
+(NSString *)GetAuthTokenWithDateTimeString:(NSString *)uid;
+(NSString*)EnctyrptToken:(NSString*)st;
+(void)AddRequestHeaders :(ASIFormDataRequest*)request token:(NSString*)encryptedString uid:(NSString*)uid deviceType:(NSString*)deviceType;
+(void)AddRequestHeaders :(ASIFormDataRequest*)request token:(NSString*)encryptedString uid:(NSString*)uid;
+(void)AddRequestHeadersForGETMethod :(ASIFormDataRequest*)request token:(NSString*)encryptedString uid:(NSString*)uid;
@end
