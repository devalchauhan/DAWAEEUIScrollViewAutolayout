//
//  EmergencyContactsViewController.h
//  Sehhaty
//
//  Created by Syed Fahad Anwar on 10/17/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmergencyContactsViewController : UIViewController
{
    NSUserDefaults *prefs;
    NSString *str_Language;
    AppDelegate *appDelegate;
}
@property (nonatomic,strong) NSMutableArray *ary_EmergencyContacts;
@property (nonatomic,strong) IBOutlet UITableView *tbl_EmergencyContacts;
@end
