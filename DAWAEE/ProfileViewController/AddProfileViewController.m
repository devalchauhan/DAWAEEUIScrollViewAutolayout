//
//  AddProfileViewController.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 5/9/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "AddProfileViewController.h"
#import "Constants.h"
@interface AddProfileViewController ()

@end

@implementation AddProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.scrl setContentSize:CGSizeMake(10, 650)];
    self.scrl.translatesAutoresizingMaskIntoConstraints  = NO;
    
    
    self.view_SCRLContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrl addSubview:self.view_SCRLContainer];
    
    NSDictionary *views = @{@"beeView":self.view_SCRLContainer};
    if (IS_IPHONE_5) {
        NSDictionary *metrics = @{@"height" : @630, @"width" : @304};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6){
        NSDictionary *metrics = @{@"height" : @630, @"width" : @359};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    else if (IS_IPHONE_6Plus){
        NSDictionary *metrics = @{@"height" : @630, @"width" : @398};
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[beeView(height)]|" options:kNilOptions metrics:metrics views:views]];
        [self.scrl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[beeView(width)]|" options:kNilOptions metrics:metrics views:views]];
    }
    
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view_ContactInfo.bounds];
    self.view_ContactInfo.layer.masksToBounds = NO;
    self.view_ContactInfo.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_ContactInfo.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_ContactInfo.layer.shadowOpacity = 0.5f;
    self.view_ContactInfo.layer.shadowPath = shadowPath.CGPath;
    
    UIBezierPath *shadowPath1 = [UIBezierPath bezierPathWithRect:self.view_PersonalInfo.bounds];
    self.view_PersonalInfo.layer.masksToBounds = NO;
    self.view_PersonalInfo.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_PersonalInfo.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_PersonalInfo.layer.shadowOpacity = 0.5f;
    self.view_PersonalInfo.layer.shadowPath = shadowPath1.CGPath;
    
    
    UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRect:self.view_OtherInfo.bounds];
    self.view_OtherInfo.layer.masksToBounds = NO;
    self.view_OtherInfo.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view_OtherInfo.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.view_OtherInfo.layer.shadowOpacity = 0.5f;
    self.view_OtherInfo.layer.shadowPath = shadowPath2.CGPath;
    
    
}
-(IBAction)BackClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
