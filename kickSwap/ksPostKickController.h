//
//  ksPostKickController.h
//  kickSwap
//
//  Created by Hugh A. Miles on 2/18/15.
//  Copyright (c) 2015 HAMtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Resize.h"

@interface ksPostKickController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

///////////////////////////////////////////////////////////
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *sizeTextField;
////////////////////////////////////////////////////////////

@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UIButton *takePhoto;
@property (weak, nonatomic) IBOutlet UIButton *selectPhoto;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;


@end
