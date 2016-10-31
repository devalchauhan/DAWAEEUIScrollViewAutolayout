//
//  FAQsTableViewCell.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 6/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmergencyContactCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *lbl_Title,*lbl_PhoneNumber;
@property (nonatomic,strong) IBOutlet UIButton *btn_Call;
@end
