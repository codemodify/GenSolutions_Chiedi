//
//  SettingsViewController.h
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/24/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsDelegate <NSObject>

    @optional
    -(void)SettingsFinished;

@end

@interface SettingsViewController : UIViewController<UITextFieldDelegate>

    @property (weak, nonatomic) IBOutlet UITextField *Email;
    @property (weak, nonatomic) id <SettingsDelegate> Delegate;

@end

