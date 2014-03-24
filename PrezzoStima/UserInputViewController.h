//
//  UserInputViewController.h
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/3/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInputViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate>

    @property (weak, nonatomic) IBOutlet UITextView *UserQuestion;
    @property (weak, nonatomic) IBOutlet UIToolbar *PhotoBar;

    - (IBAction)TakePhoto:(id)sender;
    - (IBAction)ChoosePhoto:(id)sender;


@end
