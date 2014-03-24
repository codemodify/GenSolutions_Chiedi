//
//  ConfirmationViewController.h
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/7/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface ConfirmationViewController : UIViewController<UITextFieldDelegate,SettingsDelegate>

    @property (weak, nonatomic) IBOutlet UILabel *UserEmail;
    @property (weak, nonatomic) IBOutlet UILabel *Location;
    @property (weak, nonatomic) IBOutlet UILabel *Service;
    @property (weak, nonatomic) IBOutlet UILabel *PhotosCount;
    @property (weak, nonatomic) IBOutlet UITextView *UserMessage;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *ProvidersNr;
    @property (weak, nonatomic) IBOutlet UIToolbar *BottomToolbar;

    @property (weak, nonatomic) IBOutlet UIImageView *CaptchaImage;
    @property (weak, nonatomic) IBOutlet UITextField *CaptchaText;
    
    -(IBAction)SendRequest:(id)sender;

@end
