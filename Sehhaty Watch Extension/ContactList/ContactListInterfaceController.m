//
//  ListInterfaceController.m
//  DHADoctors
//
//  Created by Syed Fahad Anwar on 8/20/15.
//  Copyright (c) 2015 DHA. All rights reserved.
//

#import "ContactListInterfaceController.h"
#import "ListRowController.h"

@interface ContactListInterfaceController ()

@end

@implementation ContactListInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    //NSLog(@"%@",context);
    self.str_Context = context;
    NSLog(@"context : %@",context);
    [self setTitle:@"Back"];
    
    self.listArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"Hatta Hospital" forKey:@"EmergencyFacilityName"];
        [dic setValue:@"0436363636" forKey:@"EmergencyFacilityNumber"];
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
            [row.lbl_EmergencyFacilityName setText:[NSString stringWithFormat:@"%@",[[self.listArray objectAtIndex:i] valueForKey:@"EmergencyFacilityName"]]] ;
            [row.lbl_EmergencyFacilityNumber setText:[NSString stringWithFormat:@"%@",[[self.listArray objectAtIndex:i] valueForKey:@"EmergencyFacilityNumber"]]];
            
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}
- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    
    @try {
        
        
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



