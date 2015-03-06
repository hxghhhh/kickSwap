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


- (IBAction)sendToParse:(id)sender // takePhoto();
{
    //initWithObjectClass >> Timeline
    PFObject *post = [PFObject objectWithClassName:@"Timeline"];
    
    /*
    //intializing imageData
    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
    PFFile *imageFile = [PFFile fileWithName: @"image.png" data:imageData];
 
    //initWithObjectClass >> Timeline
    PFObject *post = [PFObject objectWithClassName:@"Timeline"];
    
    */
    
    //ConnectUImage
    if (self.imageView.image != nil) {
        
        //intializing imageData
        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
        PFFile *imageFile = [PFFile fileWithName: @"image.png" data:imageData];
    
        //postPicture = UserChosenImage
        post[@"picture"] = imageFile;
    }
    
    else
    {
        //write message error (toast)
        UIAlertView *emptyField = [[UIAlertView alloc]
                                   initWithTitle:@"Error"
                                   message:@"No picture selected"
                                   delegate:nil
                                   cancelButtonTitle:@"Ok"
                                   otherButtonTitles: nil
                                   
                                   ];
    
        
    [emptyField show]; // display message
    
    }
    
    //Parse text field for empty inputs
    NSString *rawString = self.textField.text;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    
    NSString *rawSizeString = self.sizeTextField.text;
    NSCharacterSet *sizeWhiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *sizetrimmed = [rawSizeString stringByTrimmingCharactersInSet:sizeWhiteSpace];
    

    //set fields entry fields in the object class
    post[@"text"] = self.textField.text;
    post[@"size"] = self.sizeTextField.text;
    
    //Add Extra Fields HERE/////////////////////////////////
    
    ////////////////////////////////////////////////////////
    
    //Check if user has wrtiten something in text field
    if ([trimmed length] != 0 || [sizetrimmed length] != 0){
        
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
        
        //write message error (toast)
        UIAlertView *emptyField = [[UIAlertView alloc]
                                   initWithTitle:@"Error"
                                   message:@"Empty text field please input something"
                                   delegate:nil
                                   cancelButtonTitle:@"Ok"
                                   otherButtonTitles: nil
                                   
                                   ];
        
        [emptyField show]; // display message
    }
    
    
}

- (IBAction)selectPhoto:(id)sender { // access to photo library as a selection
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    //resize Image
    // Resize the image to be square (what is shown in the preview)
    UIImage *resizedImage = [chosenImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit
                                                          bounds:CGSizeMake(560.0f, 560.0f)  
                                            interpolationQuality:kCGInterpolationHigh];

    
    //UIImage *scaledImage = [chosenImage resizedImageWithContentMode:UIViewContentModeScaleToFill interpolationQuality:kCGInterpolationHigh];
    
    
    // Create a thumbnail and add a corner radius for use in table views
    UIImage *thumbnailImage = [chosenImage thumbnailImage:86.0f
                                    transparentBorder:0.0f
                                         cornerRadius:10.0f
                                 interpolationQuality:kCGInterpolationDefault];

    
    [self.imageView setImage:resizedImage]; // set picture to imageView

    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL]; // dismiss library viewing controller
    
}


@end


