//
//  VaccinationDetailViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/9/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VaccinationDetailViewController : UIViewController
{
    NSUserDefaults *prefs;
    NSString *str_Language;
    AppDelegate *appDelegate;
    IBOutlet NSLayoutConstraint *ViewHeightConstraint;
    float height_tableview;
}
@property (nonatomic,weak) IBOutlet UIView *view_SCRLContainer;
@property (nonatomic, strong) IBOutlet UIScrollView *scrl_Main;


@property (nonatomic,strong) NSMutableDictionary *dic_ChildDetails;
@property (nonatomic,strong) IBOutlet UILabel *lbl_ChildName,*lbl_ChildAge;
@property (nonatomic,strong) IBOutlet UIImageView *iv_ChildImage;
@property (nonatomic,strong) IBOutlet UITableView *tbl_VaccinationList;
@property (nonatomic,strong) NSMutableArray *ary_VaccinationList;
-(IBAction)Back;
@end
