//
//  UserInputViewController.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/3/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>
#import "UserInputViewController.h"
#import "DataStructures.h"
#import "ConfirmationViewController.h"

@interface UserInputViewController ()
{
    NSMutableArray* _imagesAsAttachment;
    NSMutableArray* _customButtons;
    NSArray* _originalButtons;
}
@end

@implementation UserInputViewController

-(void)SetupButtons
{
    NSMutableArray*
        buttons = [[NSMutableArray alloc] initWithArray:_customButtons];
        [buttons addObjectsFromArray:_originalButtons];
    
    self.PhotoBar.items = buttons;
}

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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    _imagesAsAttachment = [NSMutableArray new];
    _customButtons = [NSMutableArray new];
    _originalButtons = self.PhotoBar.items;
    
    self.title = @"Messaggio";
    
    [self.PhotoBar setBackgroundImage:[UIImage imageNamed:@"UIToolBarHelper_bg"]
                   forToolbarPosition:UIToolbarPositionAny
                           barMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.UserQuestion.delegate = self;    
    [self.UserQuestion becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveTextViewForKeyboard:(NSNotification*)aNotification up:(BOOL)up
{
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect
        keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
     
    CGRect
        newFrame = self.UserQuestion.frame;
        newFrame.size.height -= keyboardFrame.size.height * (up?1:-1);
    
    self.UserQuestion.frame = newFrame;
    
    [UIView commitAnimations];
}

- (void)keyboardWillShown:(NSNotification*)aNotification
{
    [self moveTextViewForKeyboard:aNotification up:YES];
}

- (IBAction)TakePhoto:(id)sender
{
    if( _customButtons.count >= 4 )
        return;
    
    if( [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] )
    {
        UIImagePickerController*
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = @[(NSString*) kUTTypeImage];
            imagePicker.allowsEditing = YES;
        
        [self presentViewController:imagePicker
                           animated:YES
                         completion:nil];
    }
}

- (IBAction)ChoosePhoto:(id)sender
{
    if( _customButtons.count >= 4 )
        return;

    if( [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] )
    {
        UIImagePickerController*
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString*) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        
        [self presentViewController:imagePicker
                           animated:YES
                         completion:nil];
    }    
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Add button
    UIButton*
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake( 0, 0, 36, 36 );
        [button setImage:[UIImage imageNamed:@"IPhoto_Icon"] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(RemoveImage:)
         forControlEvents:UIControlEventTouchUpInside];
         button.tag = _imagesAsAttachment.count;
    
    UIBarButtonItem*
        photoButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        photoButton.width = 36;
    
    [_imagesAsAttachment addObject:image];
    [_customButtons addObject:photoButton];
    [self SetupButtons];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)RemoveImage:(id)sender
{
    UIButton* button = (UIButton*) sender;
    
    [_imagesAsAttachment removeObjectAtIndex:button.tag];
    [_customButtons removeObjectAtIndex:button.tag];
    [self SetupButtons];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        // update data
        [SearchCriteria SetText:self.UserQuestion.text];
        [SearchCriteria SetPhotos:_imagesAsAttachment];

        [textView resignFirstResponder];
        
        ConfirmationViewController*
            viewController = [[ConfirmationViewController alloc] init];
            viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self.navigationController pushViewController:viewController
                                             animated:YES];

        return NO;
    }
    
    return YES;
}

@end
