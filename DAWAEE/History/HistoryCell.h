//
//  FAQsTableViewCell.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 6/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *lbl_Date,*lbl_Line,*lbl_Year;
@property (nonatomic,strong) IBOutlet UIImageView *iv_YearBG,*iv_CategoryBG;
@property (nonatomic,strong) IBOutlet UILabel *lbl_CategoryStatic,*lbl_ReportDetails;
@end
