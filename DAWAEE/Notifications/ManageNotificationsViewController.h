//
//  ManageNotificationsViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/16/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageNotificationsViewController : UIViewController
{
    AppDelegate *appDelegate;
    NSUserDefaults *prefs;
    NSString *w1,*w2,*w3,*w4,*w5;
}
@property (nonatomic,strong) NSMutableArray *ary_Items;
@property (nonatomic,strong) IBOutlet UITableView *tbl_Items;
-(IBAction)Back;
@end
