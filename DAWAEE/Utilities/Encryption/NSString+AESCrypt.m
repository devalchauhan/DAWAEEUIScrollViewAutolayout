//
//  NSString+AESCrypt.m
//  DHAHealth
//
//  Created by Muhammad Ahsan on 11/25/14.
//  Copyright (c) 2014 DHA. All rights reserved.
//

#import "NSString+AESCrypt.h"
#import "Base64.h"

@implementation NSString (AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key
{
    //key = @"r8li9SQw6BmU5iSB8dwYxg==";
    key = @"mI5cojV7vCWW4Y63BhV9hA==";
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData* dataKey = [[NSData alloc] initWithBase64EncodedString:key];
    NSUInteger size = 100;
    const char iv[16] = { 0x40, 0x24, 0x26, 0x7, 0x7A, 0x23, 0x2B, 0x2F, 0x69, 0x7D, 0x73, 0x28, 0x5C, 0x48, 0x19, 0x25 };
    NSData* dataIV = [NSData dataWithBytes:(const void *)iv length:sizeof(unsigned char)*size];
    
    NSData *plaindata1 = [[NSData alloc] init];
    if(IS_IPAD){
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"5" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        //[alert3 show];
    }
    plaindata1 = [plaindata1 encryptData:plainData :dataKey :dataIV];
    
    NSString *encryptedString = [plaindata1 base64EncodedString];
    
    return encryptedString;
}
- (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
- (NSString*) escapeUnicodeString:(NSString*)string
{
    NSString *strScrembled = @"";
    for (int i=0,l=0; i<[string length]; i++) {
        l = [string characterAtIndex:i];
        l = (char)(l & 0xFFFF);
        l ^= i;
        l --;
        char charc = ((char)l);
        ////NSLog(@"%c",charc);
        strScrembled = [strScrembled stringByAppendingString:[NSString stringWithFormat:@"%c",charc]];
    }
    return strScrembled;
}




@end
