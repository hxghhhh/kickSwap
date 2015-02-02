//
//  UITableViewCell+ksTableViewCell.m
//  kickSwap
//
//  Created by Hugh A. Miles on 1/30/15.
//  Copyright (c) 2015 HAMtech. All rights reserved.
//

#import "ksTableViewCell.h"

@implementation ksTableViewCell

@synthesize cellTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
