//
//  ViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/17/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIGNINViewController.h"

@interface ViewController : UIViewController
{
    SIGNINViewController *obj_SIGNINViewController;
}
@property (nonatomic,weak) IBOutlet UILabel *lbl_OR,*lbl_HWYLS;
@property (nonatomic,weak) IBOutlet UIScrollView *scrl;
@property (nonatomic,weak) IBOutlet UIView *view_SCRLContainer;
@property (nonatomic,weak) IBOutlet UIButton *btn_CreateAccount;
-(IBAction)SIGNINClicked;
-(IBAction)SIGNINWITHDHAIDClicked;
-(IBAction)SIGNINWITHEMIRATESIDClicked;
-(IBAction)CREATEACCOUNTClicked;
-(IBAction)LANGUAGECHANGEDClicked;
@end

