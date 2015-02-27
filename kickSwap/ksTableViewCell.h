//
//  UITableViewCell+ksTableViewCell.h
//  kickSwap
//
//  Created by Hugh A. Miles on 1/30/15.
//  Copyright (c) 2015 HAMtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ksTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end