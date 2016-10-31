//
//  ListInterfaceController.h
//  DHADoctors
//
//  Created by Syed Fahad Anwar on 8/20/15.
//  Copyright (c) 2015 DHA. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface FacilityDetailListInterfaceController : WKInterfaceController
@property (nonatomic, weak) IBOutlet WKInterfaceTable *tbl;

@property (strong, nonatomic) NSMutableArray *listArray;
@property (strong, nonatomic) NSString *str_Context;
@end
