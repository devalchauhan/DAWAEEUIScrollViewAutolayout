//
//  ListInterfaceController.m
//  DHADoctors
//
//  Created by Syed Fahad Anwar on 8/20/15.
//  Copyright (c) 2015 DHA. All rights reserved.
//

#import "FacilityListInterfaceController.h"
#import "ListRowController.h"

@interface FacilityListInterfaceController ()

@end

@implementation FacilityListInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    //NSLog(@"%@",context);
    self.str_Context = context;
    NSLog(@"context : %@",context);
    [self setTitle:@"Back"];
    
    self.listArray = [NSMutableArray array];
    [self.listArray addObject:@"My Personal Health Center"];
    [self.listArray addObject:@"Nearby Facilites"];
    [self.listArray addObject:@"Nearby Pharmacies"];
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
            if (i==0) {
                [row.image_Category setImage:[UIImage imageNamed:[NSString stringWithFormat:@"phc_icon.png"]]];
            }
            else if (i==1) {
                [row.image_Category setImage:[UIImage imageNamed:[NSString stringWithFormat:@"facility_icon_small.png"]]];
            }
            else if (i==2) {
                [row.image_Category setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pharmacy_icon.png"]]];
            }
            [row.lbl_Category setText:[NSString stringWithFormat:@"%@",[self.listArray objectAtIndex:i]]];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}
- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    
    @try {
        if (rowIndex==0)
            [self presentControllerWithName:@"FacilityDetailInterfaceController" context:@"PHCDetails"];
        else if (rowIndex==1)
            [self presentControllerWithName:@"FacilityDetailListInterfaceController" context:@"Facility"];
        else if (rowIndex==2)
            [self presentControllerWithName:@"FacilityDetailListInterfaceController" context:@"Phamracy"];
        
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



