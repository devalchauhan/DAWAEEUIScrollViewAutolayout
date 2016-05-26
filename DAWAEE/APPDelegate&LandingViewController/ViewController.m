//
//  ViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 3/17/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
@interface ViewController ()

@end

@implementation ViewController


#pragma mark VIEWDelegates Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=TRUE;
    obj_SIGNINViewController = [[SIGNINViewController alloc] initWithNibName:@"SIGNINViewController" bundle:nil];
    
    [[self.btn_CreateAccount layer] setBorderWidth:1.0f];
    [[self.btn_CreateAccount layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    [self.scrl setContentSize:CGSizeMake(0, 300)];
    self.scrl.translatesAutoresizingMaskIntoConstraints  = NO;
    
    
    self.view_SCRLContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrl addSubview:self.view_SCRLContainer];
    
    NSDictionary *views = @{@"beeView":self.view_SCRLContainer};
    if (IS_IPHONE_5) {
        NSDictionary *metrics = @{@"height" : @300, @"width" : @320};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6){
        NSDictionary *metrics = @{@"height" : @300, @"width" : @375};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6Plus){
        NSDictionary *metrics = @{@"height" : @300, @"width" : @414};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    
    
}




#pragma mark UIBUTTONClicked Methods
-(IBAction)SIGNINClicked
{
    obj_SIGNINViewController.str_SignINorUP = @"SIGNIN";
    [self.navigationController pushViewController:obj_SIGNINViewController animated:YES];
}
-(IBAction)SIGNINWITHDHAIDClicked
{
    
}
-(IBAction)SIGNINWITHEMIRATESIDClicked
{
    
}
-(IBAction)CREATEACCOUNTClicked;
{
    obj_SIGNINViewController.str_SignINorUP = @"SIGNUP";
    [self.navigationController pushViewController:obj_SIGNINViewController animated:YES];
}
-(IBAction)LANGUAGECHANGEDClicked
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
