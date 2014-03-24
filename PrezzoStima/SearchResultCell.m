//
//  SearchResultCell.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/3/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)MakeCallOne:(id)sender
{
    NSString* phoneNumber = [NSString stringWithFormat:@"telprompt:%@",[self.TelOne.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    //NSString* phoneNumber = [NSString stringWithFormat:@"tel://12312412123123"];
    
    NSURL *url = [NSURL URLWithString: phoneNumber];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)MakeCallTwo:(id)sender
{
    NSString* phoneNumber = [NSString stringWithFormat:@"telprompt:%@",[self.TelTwo.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    //NSString* phoneNumber = [NSString stringWithFormat:@"tel://12312412123123"];
    
    NSURL *url = [NSURL URLWithString: phoneNumber];
    [[UIApplication sharedApplication] openURL:url];    
}
@end
