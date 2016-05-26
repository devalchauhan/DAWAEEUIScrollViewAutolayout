//
//  ProfileMedicineViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 5/15/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileMedicineViewController : UIViewController

@property(nonatomic,weak) IBOutlet UILabel *lbl_ALL,*lbl_DHA,*lbl_EXTERNAL;
-(IBAction)BackClicked;
-(IBAction)ALLClicked;
-(IBAction)DHAClicked;
-(IBAction)EXTERNALClicked;
@end
