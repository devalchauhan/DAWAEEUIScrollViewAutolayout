//
//  ListRowController.h
//  DHADoctors
//
//  Created by Syed Fahad Anwar on 8/20/15.
//  Copyright (c) 2015 DHA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
@interface ListRowController : NSObject
@property (nonatomic, strong) IBOutlet WKInterfaceLabel *lbl_HospitalName,*lbl_Date,*lbl_Time;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *btn_Line;


//for vaccination
@property (nonatomic, strong) IBOutlet WKInterfaceLabel *lbl_PatientName,*lbl_VaccinationName,*lbl_VaccinationDate;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *btn_LineVaccination;

//for facilites
@property (nonatomic, strong) IBOutlet WKInterfaceLabel *lbl_Category;
@property (nonatomic, strong) IBOutlet WKInterfaceLabel *lbl_FacilityName,*lbl_FacilityTime,*lbl_FacilityStatus;
@property (nonatomic, strong) IBOutlet WKInterfaceImage *image_Category;

//for Emergency Contacts
@property (nonatomic, strong) IBOutlet WKInterfaceLabel *lbl_EmergencyFacilityName,*lbl_EmergencyFacilityNumber;
@property (nonatomic, strong) IBOutlet WKInterfaceImage *image_Call_icon_small;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *rowGroup;
@end
