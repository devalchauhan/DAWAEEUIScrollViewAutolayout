//
//  NotificationsViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/16/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsViewController : UIViewController
@property (nonatomic,strong) IBOutlet UITableView *tbl_Notificaitons;
-(IBAction)Back;
-(IBAction)ManageNotificaitonsClicked;
@end
