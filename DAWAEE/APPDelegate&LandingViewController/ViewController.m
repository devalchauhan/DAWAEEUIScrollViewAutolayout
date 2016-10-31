//
//  ViewController.m
//  SEHHATY
//
//  Created by Syed Fahad Anwar on 9/29/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "HCLoginViewController.h"
#import "MYIDLoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=TRUE;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [self.btn_LWUAP.layer setCornerRadius:25.0f];
    [self.btn_LWUAP.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.btn_LWUAP.layer setShadowOpacity:0.5];
    [self.btn_LWUAP.layer setShadowRadius:2.0];
    [self.btn_LWUAP.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [self.btn_LWHCN.layer setCornerRadius:25.0f];
    [self.btn_LWHCN.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.btn_LWHCN.layer setShadowOpacity:0.5];
    [self.btn_LWHCN.layer setShadowRadius:2.0];
    [self.btn_LWHCN.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [self.btn_LWMID.layer setCornerRadius:25.0f];
    [self.btn_LWMID.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.btn_LWMID.layer setShadowOpacity:0.5];
    [self.btn_LWMID.layer setShadowRadius:2.0];
    [self.btn_LWMID.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [self.btn_CWOL.layer setCornerRadius:25.0f];
    [self.btn_CWOL.layer setBorderColor:[UIColor colorWithRed:(162.0/255.0) green:(166.0/255.0) blue:(161.0/255.0) alpha:1.0].CGColor];
    [self.btn_CWOL.layer setBorderWidth:1.0f];


}
-(void)viewWillAppear:(BOOL)animated
{
    //[self ManageScrollView:self.view.frame.size.height+150];
}
-(void)ManageScrollView:(int)i
{
    
    [self.scrl setContentSize:CGSizeMake(0, i)];
    self.scrl.translatesAutoresizingMaskIntoConstraints  = NO;
    
    CGRect frame = self.view_SCRLContainer.frame;
    frame.size.height = i;
    self.view_SCRLContainer.frame = frame;
    
    self.view_SCRLContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrl addSubview:self.view_SCRLContainer];
    
    NSDictionary *views = @{@"beeView":self.view_SCRLContainer};
    if (IS_IPHONE_5) {
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @320};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6){
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @375};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6Plus){
        NSDictionary *metrics = @{@"height" : @(i), @"width" : @414};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
}

-(IBAction)LoginWithUserIDClicked
{
    appDelegate.flag_IsLoggedIn=TRUE;
    /*HomeViewController *obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:obj_HomeViewController animated:YES];*/
    LoginViewController *obj_LoginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:obj_LoginViewController animated:YES];
}
-(IBAction)LoginWithHCNumberClicked
{
    appDelegate.flag_IsLoggedIn=TRUE;
    /*HomeViewController *obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:obj_HomeViewController animated:YES];*/
    HCLoginViewController *obj_HCLoginViewController = [[HCLoginViewController alloc] initWithNibName:@"HCLoginViewController" bundle:nil];
    [self.navigationController pushViewController:obj_HCLoginViewController animated:YES];
}
-(IBAction)LoginWithMYIDClicked
{
    appDelegate.flag_IsLoggedIn=TRUE;
    MYIDLoginViewController *obj_MYIDLoginViewController = [[MYIDLoginViewController alloc] initWithNibName:@"MYIDLoginViewController" bundle:nil];
    [self.navigationController pushViewController:obj_MYIDLoginViewController animated:YES];
    /*HomeViewController *obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:obj_HomeViewController animated:YES];*/
}
-(IBAction)ContinueWOLClicked
{
    appDelegate.flag_IsLoggedIn=FALSE;
    HomeViewController *obj_HomeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:obj_HomeViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
