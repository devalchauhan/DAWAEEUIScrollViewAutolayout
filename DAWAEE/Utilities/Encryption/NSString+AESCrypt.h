//
//  NSString+AESCrypt.h
//  DHAHealth
//
//  Created by Muhammad Ahsan on 11/25/14.
//  Copyright (c) 2014 DHA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+AESCrypt.h"

@interface NSString (AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;

@end