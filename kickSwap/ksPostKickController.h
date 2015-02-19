//
//  ksPostKickController.h
//  kickSwap
//
//  Created by Hugh A. Miles on 2/18/15.
//  Copyright (c) 2015 HAMtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ksPostKickController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;


@property (weak, nonatomic) IBOutlet UIButton *takePhoto;
@property (weak, nonatomic) IBOutlet UIButton *selectPhoto;


@end
