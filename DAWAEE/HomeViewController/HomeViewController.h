//
//  HomeViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/24/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HomeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSUserDefaults *prefs;
    NSString *str_Language;
    AppDelegate *appDelegate;
    IBOutlet NSLayoutConstraint *ViewHeightConstraint,*footerWidth;
    float height_collectionview;
    NSString *w1,*w2,*w3,*w4,*w5;
    NSAttributedString *placeholder_SearchForDAndF;
    BOOL flag_HistoryOff,flag_WeatherOff;
    IBOutlet UIImageView *iv_FooterImage;
}
@property (nonatomic,weak) IBOutlet UIView *view_SCRLContainer;

@property (nonatomic, strong) IBOutlet UIScrollView *scrl_Main;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *ary_collectionItems;

@property (nonatomic, strong) IBOutlet UIButton *btn_Logout,*btn_LoginToContinue,*btn_AddUser,*btn_SwitchProfile;
@property (nonatomic, strong) IBOutlet UILabel *lbl_ProfileName,*lbl_GenderAge,*lbl_HCStatic,*lbl_HCNumber,*lbl_HCExpire;

@property (nonatomic, strong) IBOutlet UIButton *btn_SeeDirection;
@property (nonatomic, strong) IBOutlet UIButton *btn_PHC,*btn_NearestFacility,*btn_NearPharamcy;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UIView *view_HospitalDirection,*view_FacilitySelection,*view_SearchForDAndF,*view_Footer,*view_FooterShadow;

@property (nonatomic,strong) IBOutlet UITextField *txt_SearchForDAndF;

@property (nonatomic,strong) IBOutlet UIImageView *iv_PHCArrow,*iv_FacilityArrow,*iv_PharmacyArrow;

@property (nonatomic,strong) IBOutlet UILabel *lbl_TimeToReachCenter,*lbl_DistanceToCenter,*lbl_FacilityName;
@property (readwrite) float facilityLongitude,facilityLatitude;
@property (nonatomic,strong) NSString *str_PHCCode;
// For menu
@property (nonatomic, strong) IBOutlet UIView *view_Menu,*view_Gradient;
@property (nonatomic, strong) NSMutableArray *ary_Menu;

-(IBAction)HomeClicked;
-(IBAction)BackClicked;
-(IBAction)LangaugeClicked;
-(IBAction)ManageItemsClicked;
-(IBAction)LogoutClicked;
-(void)GotoVaccination;
-(IBAction)SearchForDAndFClicked;
-(IBAction)SwitchUserClicked;
-(IBAction)NotifiationCenterClicked;
-(IBAction)EmergencyContactsClicked;

-(IBAction)FacilityClicked;
-(IBAction)Pharmacyclicked;
-(IBAction)SeeDirectionClicked;
-(IBAction)GetPHCDetails:(NSString*)str;

-(IBAction)LinkChildClicked;
// Happiness Meter
-(IBAction)actionLog:(id)sender;

@end
