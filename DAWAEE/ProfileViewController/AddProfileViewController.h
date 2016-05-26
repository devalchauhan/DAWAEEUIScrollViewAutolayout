//
//  AddProfileViewController.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 5/9/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProfileViewController : UIViewController

@property (nonatomic,weak) IBOutlet UIScrollView *scrl;
@property (nonatomic,weak) IBOutlet UIView *view_SCRLContainer,*view_ContactInfo,*view_PersonalInfo,*view_OtherInfo;


-(IBAction)BackClicked;
@end
