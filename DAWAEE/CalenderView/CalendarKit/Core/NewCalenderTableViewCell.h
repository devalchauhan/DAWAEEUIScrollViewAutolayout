//
//  NewCalenderTableViewCell.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 5/26/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCalenderTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *lbl_Title,*lbl_Time,*lbl_DaySection;
@property (nonatomic, weak) IBOutlet UIImageView *iv_DaySection,*iv_CellBackground;
@property (nonatomic, weak) IBOutlet UIButton *btn_Date;

@property (nonatomic, weak) IBOutlet UIButton *btn_TakeTime,*btn_TakenTime,*btn_skip,*btn_instruction,*btn_later,*btn_take;
@property (nonatomic, weak) IBOutlet UILabel *lbl_doseQuantity;
@end
