//
//  NewCalenderTableViewCell.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 5/26/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "NewCalenderTableViewCell.h"

@implementation NewCalenderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btn_TakeTime.layer.cornerRadius = 10.0f;
    _btn_TakenTime.layer.cornerRadius = 10.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
