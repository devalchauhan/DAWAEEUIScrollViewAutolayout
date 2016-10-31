//
//  CKViewController.h
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CKCalendarDelegate.h"
#import "CKCalendarDataSource.h"
#import "AppDelegate.h"
#import "FMDB.h"
@interface CKCalendarViewControllerInternal : UIViewController
{
    AppDelegate *appDelegate;
    FMDatabase *database;
    NSString *name_english,*name_arabic;
}
@property (nonatomic, assign) id<CKCalendarViewDataSource> dataSource;
@property (nonatomic, assign) id<CKCalendarViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *ary_EventFromDB;
@property (nonatomic, strong) NSString *s_profile_id;
@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) NSDate *date;
- (CKCalendarView *)calendarView;
-(void)CreateEventsForCalender:(NSDate*)dateForSelectedMonth;
@end
