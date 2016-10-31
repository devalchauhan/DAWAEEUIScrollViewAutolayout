//
//  HistoryViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/16/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController
{
    IBOutlet NSLayoutConstraint *ViewFilterHeightConstraint;
    IBOutlet UILabel *lbl_LabResultBG,*lbl_PriscriptionBG,*lbl_AppointmentBG,*lbl_AdmissionBG;
    IBOutlet UIButton *btn_LabResultBG,*btn_PriscriptionBG,*btn_AppointmentBG,*btn_AdmissionBG;
}
@property (nonatomic,strong) IBOutlet UITableView *tbl_History;
@property (nonatomic,strong) IBOutlet UIView *view_Filters,*view_Gradient,*view_filterButtons;

-(IBAction)Back;
-(IBAction)FilterExpand;
@end
