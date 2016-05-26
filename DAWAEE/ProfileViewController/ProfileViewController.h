//
//  ProfileViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 4/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

// For menu
@property (nonatomic, strong) IBOutlet UIView *view_Menu,*view_Gradient;
@property (nonatomic, strong) NSMutableArray *ary_Menu;
@property (nonatomic, strong) IBOutlet UITableView *tbl_Menu,*tbl_Profiles;
@property (nonatomic, strong) IBOutlet UIButton *btn_Langauge;

-(IBAction)HomeClicked;
-(IBAction)BackClicked;
-(IBAction)LangaugeClicked;
-(IBAction)AddProfileClicked;
@end
