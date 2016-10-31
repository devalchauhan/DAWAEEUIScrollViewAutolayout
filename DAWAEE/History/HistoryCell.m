//
//  FAQsTableViewCell.m
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 6/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lbl_CategoryStatic.layer.cornerRadius=2;
    self.lbl_CategoryStatic.clipsToBounds=YES;
    
    [self.lbl_ReportDetails.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.lbl_ReportDetails.layer setShadowOpacity:0.5];
    [self.lbl_ReportDetails.layer setShadowRadius:3.0];
    [self.lbl_ReportDetails.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
