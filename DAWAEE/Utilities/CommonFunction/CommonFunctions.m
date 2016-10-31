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
+(void) ShowAlertMessage:(NSString*)title MessageText:(NSString*)message ButtonText:(NSString*)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:button otherButtonTitles:nil];
    [alert show];
}
+(void) ShowAlertMessage:(NSString*)title MessageText:(NSString*)message ButtonText:(NSString*)button CancelButtonText:(NSString*)cancelbutton {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelbutton otherButtonTitles:button,nil];
    [alert show];
}


+(NSString *)GetAuthTokenWithDateTimeString:(NSString *)uid
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy HH-mm-ss"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Dubai"];
    [dateFormat setTimeZone:timeZone];
    NSString *dateString = [dateFormat stringFromDate:today];
    ////NSLog(@"%@",dateString);
    
    return (([uid  isEqual: @""] || uid == nil)? @"": [NSString stringWithFormat:@"%@:%@", uid, dateString]);
}

+(NSString*)EnctyrptToken:(NSString*)st
{
    NSString *token= [self GetAuthTokenWithDateTimeString:st];
    NSData* dataToEncrypt = [token dataUsingEncoding:NSUTF8StringEncoding];
    //NSString *key = @"r8li9SQw6BmU5iSB8dwYxg==";
    NSString *key = @"mI5cojV7vCWW4Y63BhV9hA==";
    NSData* dataKey = [[NSData alloc] initWithBase64EncodedString:key];
    NSUInteger size = 100;
    const char iv[16] = { 0x40, 0x24, 0x26, 0x7, 0x7A, 0x23, 0x2B, 0x2F, 0x69, 0x7D, 0x73, 0x28, 0x5C, 0x48, 0x19, 0x25 };
    NSData* dataIV = [NSData dataWithBytes:(const void *)iv length:sizeof(unsigned char)*size];
    
    NSData *plaindata = [[NSData alloc] init];
    plaindata = [plaindata encryptData:dataToEncrypt :dataKey :dataIV];
    NSString *encryptedString = [plaindata base64EncodedString];
    return encryptedString;
}
+(void)AddRequestHeaders :(ASIFormDataRequest*)request token:(NSString*)encryptedString uid:(NSString*)uid deviceType:(NSString*)deviceType
{
    //[request addRequestHeader:@"AppId" value:@"DAWAEE"];
    [request addRequestHeader:@"uid" value:uid];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
    
    [request setPostValue:uid forKey:@"DeviceId"];
    [request setPostValue:deviceType forKey:@"DeviceType"];
    [request setPostValue:@"SEHHATI" forKey:@"AppId"];
}
+(void)AddRequestHeaders :(ASIFormDataRequest*)request token:(NSString*)encryptedString uid:(NSString*)uid
{
    [request addRequestHeader:@"AppId" value:@"SEHHATI"];
    [request addRequestHeader:@"uid" value:uid];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
    
    [request setPostValue:uid forKey:@"DeviceId"];
    
}

+(void)AddRequestHeadersForGETMethod :(ASIFormDataRequest*)request token:(NSString*)encryptedString uid:(NSString*)uid
{
    [request addRequestHeader:@"AppId" value:@"SEHHATI"];
    [request addRequestHeader:@"uid" value:uid];
    [request addRequestHeader:@"APIVERSION" value:@"2.0"];
    [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",encryptedString]];
}

@end
