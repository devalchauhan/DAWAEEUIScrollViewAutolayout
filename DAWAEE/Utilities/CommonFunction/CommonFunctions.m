//
//  CommonFunctions.m
//  DGApp
//
//  Created by Deval Chauhan on 2/8/16.
//  Copyright © 2016 Syed Fahad Anwar. All rights reserved.
//

#import "CommonFunctions.h"
@implementation CommonFunctions

/*================================================================================================
 Check Internet Connectivity
 =================================================================================================*/
+(BOOL)IsInternetAvailable
{
    BOOL reachable = NO;
    NetworkStatus netStatus = [APP_DELEGATE.internetReachability currentReachabilityStatus];
    if(netStatus == ReachableViaWWAN || netStatus == ReachableViaWiFi)
    {
        reachable = YES;
    }
    else
    {
        reachable = NO;
    }
    return reachable;
}

+(void) ShowAlertMessage:(NSString*)title MessageText:(NSString*)message ButtonText:(NSString*)button {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:button otherButtonTitles:nil];
    [alert show];
}
@end
