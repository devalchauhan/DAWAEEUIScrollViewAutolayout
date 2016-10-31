//
//  ListInterfaceController.m
//  DHADoctors
//
//  Created by Syed Fahad Anwar on 8/20/15.
//  Copyright (c) 2015 DHA. All rights reserved.
//

#import "AppointmentDetailInterfaceController.h"
#import "ListRowController.h"

@interface AppointmentDetailInterfaceController ()

@end

@implementation AppointmentDetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    //NSLog(@"%@",context);
    self.str_Context = context;
    NSLog(@"context : %@",context);
    [self setTitle:@"Back"];
    
 //   [self OpenParent];
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

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



