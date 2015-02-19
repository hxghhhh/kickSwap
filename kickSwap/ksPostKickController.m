//
//  ksPostKickController.m
//  kickSwap
//
//  Created by Hugh A. Miles on 2/18/15.
//  Copyright (c) 2015 HAMtech. All rights reserved.
//

#import "ksPostKickController.h"
#import <Parse/Parse.h>

@interface ksPostKickController ()

@end


@implementation ksPostKickController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
};


- (IBAction)sendToParse:(id)sender {
    
    //initWithObjectClass >> Timeline
    PFObject *post = [PFObject objectWithClassName:@"Timeline"];
    
    
    NSString *text = self.textField.text;
    
    NSLog(@"%@" ,text);
    
    //set fields entry fields in the object class
    post[@"text"] = self.textField.text;
    
    //Check if user has wrtiten something in text field
    if (self.textField.text != nil ) {
        
        [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
                NSLog(@"Sending to Parse");
            } else {
                // There was a problem, check error.description
                NSLog(@"Error in sending");
            }
        }];
    }
    
    else
    {
        NSLog(@"enter values");
    }
 
    
    
}


@end


