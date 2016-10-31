//
//  FAQsTableViewCell.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 6/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VaccinationCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *lbl_ChildName,*lbl_ChildAge;
@property (nonatomic,strong) IBOutlet UIImageView *iv_ChildImage,*iv_ChildGender;
@end
