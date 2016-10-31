//
//  VaccinationViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/6/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VaccinationViewController : UIViewController
{
    NSUserDefaults *prefs;
    NSString *str_Language;
    AppDelegate *appDelegate;
    IBOutlet NSLayoutConstraint *ViewHeightConstraint;
    float height_tableview;
}
@property (nonatomic,weak) IBOutlet UIView *view_SCRLContainer;
@property (nonatomic, strong) IBOutlet UIScrollView *scrl_Main;
@property (nonatomic,strong) IBOutlet UIButton *btn_AddChild,*btn_Left,*btn_Right;
@property (nonatomic,strong) IBOutlet UITableView *tbl_ChildList;
@property (nonatomic,strong) NSMutableArray *ary_ChildList;
-(IBAction)AddChildClicked;
-(IBAction)Back;
@end
