//
//  ListInterfaceController.m
//  DHADoctors
//
//  Created by Syed Fahad Anwar on 8/20/15.
//  Copyright (c) 2015 DHA. All rights reserved.
//

#import "FacilityDetailListInterfaceController.h"
#import "ListRowController.h"

@interface FacilityDetailListInterfaceController ()

@end

@implementation FacilityDetailListInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    //NSLog(@"%@",context);
    self.str_Context = context;
    NSLog(@"context : %@",context);
    [self setTitle:@"Back"];
    
    self.listArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"Rashid Hospital" forKey:@"FacilityName"];
        [dic setValue:@"9 AM - 5 PM" forKey:@"FacilityTime"];
        [dic setValue:@"CLOSE NOW" forKey:@"FacilityStatus"];
        [self.listArray addObject:dic];
    }
    //   [self OpenParent];
    [self loadTableData];
}
/*-(void)OpenParent
 {
 NSDictionary *requst = @{@"request":self.str_Context};
 [ListInterfaceController openParentApplication:requst reply:^(NSDictionary *replyInfo, NSError *error) {
 
 if (error) {
 NSLog(@"%@", error);
 } else {
 NSData *objectData = replyInfo[@"response"];
 self.listArray = [NSKeyedUnarchiver unarchiveObjectWithData:objectData];
 [self loadTableData];
 }
 
 }];
 }*/
- (void)loadTableData {
    @try {
        
        
        [self.tbl setNumberOfRows:self.listArray.count withRowType:@"default"];
        for (int i = 0; i < self.tbl.numberOfRows; i++)
        {
            ListRowController *row = [self.tbl rowControllerAtIndex:i];
            [row.lbl_FacilityName setText:[NSString stringWithFormat:@"%@",[[self.listArray objectAtIndex:i] valueForKey:@"FacilityName"]]] ;
            [row.lbl_FacilityTime setText:[NSString stringWithFormat:@"%@",[[self.listArray objectAtIndex:i] valueForKey:@"FacilityTime"]]];
            [row.lbl_FacilityStatus setText:[NSString stringWithFormat:@"%@",[[self.listArray objectAtIndex:i] valueForKey:@"FacilityStatus"]]];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}
- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    
    @try {
        
        [self presentControllerWithName:@"FacilityDetailInterfaceController" context:[self.listArray objectAtIndex:rowIndex]];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



