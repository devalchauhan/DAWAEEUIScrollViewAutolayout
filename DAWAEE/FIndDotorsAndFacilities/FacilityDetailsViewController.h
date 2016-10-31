//
//  FacilityDetailsViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/12/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface FacilityDetailsViewController : UIViewController
@property (nonatomic,strong) IBOutlet UIScrollView *scrl_Main;
@property (nonatomic,strong) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) IBOutlet UILabel *lbl_Title,*lbl_HospitalName,*lbl_Time,*lbl_OpenStatus;
@property (nonatomic,strong) IBOutlet UIButton *btn_FacilityDetails,*btn_Specilities;
@property (nonatomic,strong) IBOutlet UIView *view_FacilityDetails,*view_Specialities;

@property (nonatomic,strong) IBOutlet UILabel *lbl_AddHosName,*lbl_AddStreet,*lbl_PostCode,*lbl_Link;
@property (nonatomic,strong) IBOutlet UIButton *btn_DrivingDirection,*btn_Call,*btn_Fax;

-(IBAction)Back;
-(IBAction)FavoriteClicked;
-(IBAction)ShareClicked;
-(IBAction)FacilityDetailsClicked;
-(IBAction)SpecialitiesCliked;
@end
