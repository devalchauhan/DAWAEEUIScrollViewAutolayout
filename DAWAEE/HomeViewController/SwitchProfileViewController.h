//
//  SwitchProfileViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchProfileViewController : UIViewController
@property (nonatomic,strong) IBOutlet UITableView *tbl_Profiles;
@property (nonatomic,strong) IBOutlet UIButton *btn_AddNewUser;
@property (nonatomic,strong) NSMutableArray *ary_Profiles;
-(IBAction)Back;
@end
