//
//  ViewController.h
//  kickSwap
//
//  Created by Hugh A. Miles on 12/25/14.
//  Copyright (c) 2014 HAMtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

- (IBAction)signOutButtonTapAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *signOut;

@end

