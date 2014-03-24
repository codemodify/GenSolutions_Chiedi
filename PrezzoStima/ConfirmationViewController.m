//
//  ConfirmationViewController.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/7/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "DataStructures.h"
#import "Helpers.h"

@interface ConfirmationViewController ()
{
    UIImage* _captcha;
}
@end

@implementation ConfirmationViewController

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
    
    NSString* userMail = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    if( [userMail isEqualToString:@""] )
        userMail = @"e-Mail";
    
    self.UserEmail.text = userMail;
    self.Location.text = [SearchCriteria GetSubRegion];
    self.Service.text = [SearchCriteria GetServiceTypeLabel];
    self.PhotosCount.text = [NSString stringWithFormat:@"%d Immagini",[[SearchCriteria GetPhotos] count]];
    self.UserMessage.text = [SearchCriteria GetText];
    self.ProvidersNr.title = [NSString stringWithFormat:@"%d Impresa",[[SearchCriteria GetProviders] count]];
    
    self.CaptchaText.delegate = self;
    
    [self.navigationItem setTitle:@"Cresima"];
    

    // Set settings button
    UIButton* settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        settingsButton.userInteractionEnabled = YES;
        [settingsButton setFrame:CGRectMake(0.0,0.0, 33.0, 33. )];
        [settingsButton setImage:[UIImage imageNamed:@"misc_settings"]
                        forState:UIControlStateNormal];
        [settingsButton addTarget:self
                           action:@selector(ShowSettings:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];

    //
    UIButton* sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.userInteractionEnabled = YES;
        [sendButton setFrame:CGRectMake(0.0,0.0, 33.0, 33. )];
        [sendButton setImage:[UIImage imageNamed:@"misc_send_plane"]
                    forState:UIControlStateNormal];
        [sendButton addTarget:self
                       action:@selector(SendRequest:)
             forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableArray*
        currentItems = [[NSMutableArray alloc] initWithArray:self.BottomToolbar.items];
        [currentItems addObject:[[UIBarButtonItem alloc] initWithCustomView:sendButton]];
    
    self.BottomToolbar.items = currentItems;
    
    // load image in a thread    
    NSOperationQueue* operationQueue = [NSOperationQueue new];
    
    [operationQueue addOperationWithBlock:
     ^{
         NSURL* url = [NSURL URLWithString:[Helpers GetCaptchaUrl]];
         NSData* data = [NSData dataWithContentsOfURL:url];
         _captcha = [[UIImage alloc] initWithData:data];
        
         [[NSOperationQueue mainQueue] addOperationWithBlock:
          ^{
              self.CaptchaImage.image = _captcha;
          }];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSURLRequest*)PreparePostRequestWithURL:(NSString*)url
                                fileName1:(NSString*)fileName1
                             fileContent1:(NSData*)fileContent1
                                fileName2:(NSString*)fileName2
                             fileContent2:(NSData*)fileContent2
                                fileName3:(NSString*)fileName3
                             fileContent3:(NSData*)fileContent3
                                fileName4:(NSString*)fileName4
                             fileContent4:(NSData*)fileContent4
                                 textData:(NSString*)textData
{
    NSString* myboundary = @"---------------------------14737809831466499882746641449";
    NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",myboundary];
    
    NSMutableData *
        postData = [NSMutableData data];
        [postData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", myboundary] dataUsingEncoding:NSUTF8StringEncoding]];

    // add params (all params are strings)
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", myboundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"descriere"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"%@\r\n", @"abracadabra"] dataUsingEncoding:NSUTF8StringEncoding]];
    
        if( fileName1 != nil && fileContent1 != nil ) {
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file0\"; filename=\"--%@\"\r\n", fileName1] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[NSData dataWithData:fileContent1]];
        }

        if( fileName2 != nil && fileContent2 != nil ) {
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file1\"; filename=\"%@\"\r\n", fileName2] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[NSData dataWithData:fileContent2]];
        }
    
        if( fileName3 != nil && fileContent3 != nil ) {
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file2\"; filename=\"%@\"\r\n", fileName3] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[NSData dataWithData:fileContent3]];
        }
    
        if( fileName4 != nil && fileContent4 != nil ) {
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file3\"; filename=\"%@\"\r\n", fileName4] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[NSData dataWithData:fileContent4]];
        }
      
        [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", myboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
     NSMutableURLRequest*
        urlRequest = [NSMutableURLRequest new];
        [urlRequest setURL:[NSURL URLWithString:url]];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [urlRequest setHTTPBody:postData];
    
     return urlRequest;
    
    
    
    
    
    
    
    
//    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@",[txtUsername text],[txtPassword text]];
//    NSLog(@"PostData: %@",post);
//    
//    NSURL *url=[NSURL URLWithString:@"http://dipinkrishna.com/jsonlogin.php"];
//    
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    
//    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];

}

-(UIImage *)ScaledImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(IBAction)SendRequest:(id)sender
{
    @try
    {
        NSString* file0 = @"file0.png";
        NSData* file0Content = nil;
        if( [[SearchCriteria GetPhotos] count] > 0 )
        {
            UIImage* image = [self ScaledImageWithImage:(UIImage*)[[SearchCriteria GetPhotos] objectAtIndex:0] scaledToSize:CGSizeMake(480,320) ];
            file0Content = UIImagePNGRepresentation( image );
        }
                                
        NSString* file1 = @"file1.png";
        NSData* file1Content = nil;
        if( [[SearchCriteria GetPhotos] count] > 1 )
        {
            UIImage* image = [self ScaledImageWithImage:(UIImage*)[[SearchCriteria GetPhotos] objectAtIndex:1] scaledToSize:CGSizeMake(480,320) ];
            file1Content = UIImagePNGRepresentation( image );
        }
        
        NSString* file2 = @"file2.png";
        NSData* file2Content = nil;
        if( [[SearchCriteria GetPhotos] count] > 2 )
        {
            UIImage* image = [self ScaledImageWithImage:(UIImage*)[[SearchCriteria GetPhotos] objectAtIndex:2] scaledToSize:CGSizeMake(480,320) ];
            file2Content = UIImagePNGRepresentation( image );
        }
        
        NSString* file3 = @"file3.png";
        NSData* file3Content = nil;
        if( [[SearchCriteria GetPhotos] count] > 3 )
        {
            UIImage* image = [self ScaledImageWithImage:(UIImage*)[[SearchCriteria GetPhotos] objectAtIndex:3] scaledToSize:CGSizeMake(480,320) ];
            file3Content = UIImagePNGRepresentation( image );
        }

//        NSURLRequest* request = [self PreparePostRequestWithURL:[Helpers GetSendMailUrl]
//                                                      fileName1:file0
//                                                   fileContent1:file0Content
//                                    
//                                                      fileName2:file1
//                                                   fileContent2:file1Content
//                                
//                                                      fileName3:file2
//                                                   fileContent3:file2Content
//                                
//                                                      fileName4:file3
//                                                   fileContent4:file3Content
//                                 
//                                                       textData:@"qweasd"];

        NSString* boundary = @"aaaaaaaaaaaaaaa9876134687646546546546ssssssssssss";

        // create request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setHTTPShouldHandleCookies:NO];
        [request setTimeoutInterval:30];
        [request setHTTPMethod:@"POST"];
        
        // set Content-Type in HTTP header
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        // post body
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"SubRegion"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [SearchCriteria GetSubRegion]] dataUsingEncoding:NSUTF8StringEncoding]];

        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"ServiceType"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [SearchCriteria GetServiceType]] dataUsingEncoding:NSUTF8StringEncoding]];


        NSString* providers = [[SearchCriteria GetProviders] componentsJoinedByString:@";"];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"Providers"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", providers] dataUsingEncoding:NSUTF8StringEncoding]];

        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"Text"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [SearchCriteria GetText]] dataUsingEncoding:NSUTF8StringEncoding]];

        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"Captcha"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"xy4c"] dataUsingEncoding:NSUTF8StringEncoding]];

        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"UserMail"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"user@domain.com"] dataUsingEncoding:NSUTF8StringEncoding]];

        // add image data 
        if (file0Content) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image0.png\"\r\n", @"file0"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:file0Content];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        if (file1Content) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image1.png\"\r\n", @"file1"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:file1Content];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        if (file2Content) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image2.png\"\r\n", @"file2"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:file2Content];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        if (file3Content) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image3.png\"\r\n", @"file3"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:file3Content];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // setting the body of the post to the reqeust
        [request setHTTPBody:body];
        
        // set the content-length
        NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        // set URL
        [request setURL: [NSURL URLWithString:[Helpers GetSendMailUrl]]  ];
        
        

        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSLog(@"Response code: %d", [response statusCode]);
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            

        } else
        {
            if (error)
                NSLog(@"Error: %@", error);
        }
    }
    @catch( NSException * e)
    {
        NSLog(@"Exception: %@", e);
    }
}

-(IBAction)ShowSettings:(id)sender
{
    SettingsViewController*
        viewController = [[SettingsViewController alloc] init];
        viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        viewController.Delegate = self;

    [self presentViewController:viewController
                       animated:YES
                     completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.CaptchaText resignFirstResponder];
    
    return NO;
}

-(void)SettingsFinished
{
    NSString* userMail = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    if( [userMail isEqualToString:@""] )
        userMail = @"e-Mail";
    
    self.UserEmail.text = userMail;
}

@end
