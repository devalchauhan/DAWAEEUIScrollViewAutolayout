//
//  InterfaceController.m
//  Sehhaty Watch Extension
//
//  Created by Syed Fahad Anwar on 10/19/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setTitle:@"Appointmentssss"];
    // Configure interface objects here.
   // [self OpenParent];
}
- (void)setTitle:(NSString *)title
{
    
}
/*-(void)OpenParent
{
    NSDictionary *requst = @{@"request":self.str_Context};
    [InterfaceController openParentApplication:requst reply:^(NSDictionary *replyInfo, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSData *objectData = replyInfo[@"response"];
            self.listArray = [NSKeyedUnarchiver unarchiveObjectWithData:objectData];
        }
        
    }];
}?*/

-(IBAction)AppointmentClicked
{
    //[self presentControllerWithName:@"AppointmentListInterfaceController" context:@"Appointments"];
    [self pushControllerWithName:@"AppointmentListInterfaceController" context:@"Appointments"];
}
-(IBAction)VaccinationClicked
{
    //[self presentControllerWithName:@"VaccinationListInterfaceController" context:@"Vaccinations"];
    [self pushControllerWithName:@"VaccinationListInterfaceController" context:@"Vaccinations"];
}
-(IBAction)FacilitiesClicked
{
    //[self presentControllerWithName:@"FacilityListInterfaceController" context:@"Facilities"];
    [self pushControllerWithName:@"FacilityListInterfaceController" context:@"Facilities"];
}
-(IBAction)ContactsClicked
{
    //[self presentControllerWithName:@"ContactListInterfaceController" context:@"Contacts"];
    [self pushControllerWithName:@"ContactListInterfaceController" context:@"Contacts"];
}
-(IBAction)HCClicked
{
    //[self presentControllerWithName:@"HCController" context:@"HealthCard"];
    [self pushControllerWithName:@"HCController" context:@"HealthCard"];
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



