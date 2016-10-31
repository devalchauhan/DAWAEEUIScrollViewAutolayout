//
//  InterfaceController.h
//  Sehhaty Watch Extension
//
//  Created by Syed Fahad Anwar on 10/19/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (strong, nonatomic) NSMutableArray *listArray;
@property (strong, nonatomic) NSString *str_Context;
-(IBAction)AppointmentClicked;
-(IBAction)VaccinationClicked;
-(IBAction)FacilitiesClicked;
-(IBAction)ContactsClicked;
-(IBAction)HCClicked;
@end
