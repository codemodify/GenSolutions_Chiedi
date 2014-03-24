//
//  SettingsViewController.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/24/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated
{
    // Read settings
    self.Email.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    
    //
    self.Email.delegate = self;
    [self.Email becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Save settings
    NSUserDefaults*
        userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:self.Email.text
                        forKey:@"email"];

    //
    [self.Email resignFirstResponder];

    [self dismissViewControllerAnimated:YES completion:nil];

    if( self.Delegate != nil )
    {
        [self.Delegate SettingsFinished];
    }
    
    return NO;
}

@end
