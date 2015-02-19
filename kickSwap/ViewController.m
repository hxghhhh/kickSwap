//
//  ViewController.m
//  kickSwap
//
//  Created by Hugh A. Miles on 12/25/14.
//  Copyright (c) 2014 HAMtech. All rights reserved.
//

#import "ViewController.h"
#import "ksDelegate.h"
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>

@interface ViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITextFieldDelegate>

@property id<ksDelegate> delegate;

@property (strong, nonatomic) PFLogInViewController *login;
@property (strong, nonatomic) PFUser *user;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userFullNameInput;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
}

 - (void)viewDidLoad
{
    [super viewDidLoad];

    if([PFUser currentUser])
    {
        self.user = [PFUser currentUser];
        
        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
            NSLog(@"User is currently at %f, %f", geoPoint.latitude, geoPoint.longitude);
            
            [self.user setObject:geoPoint forKey:@"currentLocation"];
            [self.user saveInBackground];
            [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude),MKCoordinateSpanMake(0.01, 0.01))];
            
            [self refreshMap:nil];
        }];
        
       self.userFullNameLabel.text = [self.user objectForKey:@"userFullName"];
        
    }
    
    self.userFullNameInput.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self presentLoginViewController];
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}


-(void)presentLoginViewController
{
    //Present login view controller if user not logged in
    if(![PFUser currentUser])
    {
        self.login = [[PFLogInViewController alloc] init];
        self.login.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton | PFLogInFieldsLogInButton;
        
        self.login.delegate = self;
        self.login.signUpController.delegate = self;
        
        [self presentViewController:self.login animated:YES completion:nil];
        
    }
}

- (IBAction)signOutButtonTapAction:(id)sender
{
    [PFUser logOut];
    
    [self presentLoginViewController];
}

- (IBAction)refreshMap:(id)sender
{
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.mapView.centerCoordinate.latitude longitude:self.mapView.centerCoordinate.longitude];
    PFQuery *query = [PFUser query];
    
    //query parse database for user
    [query whereKey:@"currentLocation" nearGeoPoint:geoPoint withinMiles:10.0f];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if(error)
         {
             NSLog(@"%@",error);
         }
         for (id object in objects)
         {
             
             MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
             annotation.title = [object objectForKey:@"userFullName"];
             PFGeoPoint *geoPoint= [object objectForKey:@"currentLocation"];
             annotation.coordinate = CLLocationCoordinate2DMake(geoPoint.latitude,geoPoint.longitude);
             
             [self.mapView addAnnotation:annotation];
             
         }
     }];
}



@end
