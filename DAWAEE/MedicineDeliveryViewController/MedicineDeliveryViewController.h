//
//  MedicineDeliveryViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 4/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MedicineDeliveryViewController : UIViewController


@property (nonatomic,weak) IBOutlet UIScrollView *scrl;
@property (nonatomic,weak) IBOutlet UIView *view_SCRLContainer,*view_PatientInfo,*view_AppointmentInfo,*view_CustomerInfo;


// For menu
@property (nonatomic, strong) IBOutlet UIView *view_Menu,*view_Gradient;
@property (nonatomic, strong) NSMutableArray *ary_Menu;
@property (nonatomic, strong) IBOutlet UITableView *tbl_Menu,*tbl_MedicineDelivery;
@property (nonatomic, strong) IBOutlet UIButton *btn_Langauge;

-(IBAction)HomeClicked;
-(IBAction)BackClicked;
-(IBAction)LangaugeClicked;
@end
