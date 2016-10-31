//
//  ViewController.h
//  SEHHATY
//
//  Created by Syed Fahad Anwar on 9/29/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property (nonatomic,strong) IBOutlet UIButton *btn_LWUAP,*btn_LWHCN,*btn_LWMID,*btn_CWOL;
@property (nonatomic,strong) IBOutlet UIScrollView *scrl;
@property (nonatomic,strong) IBOutlet UIView *view_SCRLContainer;
-(IBAction)LoginWithUserIDClicked;
-(IBAction)LoginWithHCNumberClicked;
-(IBAction)LoginWithMYIDClicked;
-(IBAction)ContinueWOLClicked;
@end

