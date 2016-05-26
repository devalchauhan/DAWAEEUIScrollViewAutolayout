//
//  ProfileTableViewCell.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 4/26/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *iv_ProfileImage;
@property (nonatomic,strong) IBOutlet UILabel *lbl_ProfileName;
@property (nonatomic,strong) IBOutlet UIButton *btn_Delete,*btn_Edit;

-(IBAction)DeleteProfileClicked;
-(IBAction)EditProfileClicked;
@end
