//
//  CommonFunctions.h
//  DGApp
//
//  Created by Deval Chauhan on 2/8/16.
//  Copyright © 2016 Syed Fahad Anwar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunctions : NSObject

/* AppDelegate object */
#define APP_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])

+(BOOL) IsInternetAvailable;
+(void) ShowAlertMessage:(NSString*)title MessageText:(NSString*)message ButtonText:(NSString*)button;

@end
