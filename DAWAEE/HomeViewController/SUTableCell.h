//
//  FAQsTableViewCell.h
//  DAWAEE
//
//  Created by Syed Fahad Anwar on 6/13/16.
//  Copyright © 2016 Deval Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUTableCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *lbl_ItemName;
@property (nonatomic,strong) IBOutlet UIButton *btn_Active,*btn_Delete;
@property (nonatomic,strong) IBOutlet UIImageView *iv_ProfileImage;
@end
