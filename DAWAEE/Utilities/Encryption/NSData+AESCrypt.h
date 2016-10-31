//
//  NSData+AESCrypt.h
//  DHAHealth
//
//  Created by Muhammad Ahsan on 11/25/14.
//  Copyright (c) 2014 DHA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AESCrypt)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
- (NSData*)encryptData:(NSData*)data :(NSData*)key :(NSData*)iv;
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (id)initWithBase64EncodedString:(NSString *)string;

- (NSString *)base64Encoding;
- (NSString *)base64EncodingWithLineLength:(NSUInteger)lineLength;

- (BOOL)hasPrefixBytes:(const void *)prefix length:(NSUInteger)length;
- (BOOL)hasSuffixBytes:(const void *)suffix length:(NSUInteger)length;

@end