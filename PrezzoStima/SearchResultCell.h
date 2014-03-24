//
//  SearchResultCell.h
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/3/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell

    @property (weak, nonatomic) IBOutlet UIImageView *Separator;

    @property (weak, nonatomic) IBOutlet UILabel *Provider;

    @property (weak, nonatomic) IBOutlet UIButton *CallButtonOne;
    @property (weak, nonatomic) IBOutlet UILabel *TelOne;
    - (IBAction)MakeCallOne:(id)sender;

    @property (weak, nonatomic) IBOutlet UIButton *CallButtonTwo;
    @property (weak, nonatomic) IBOutlet UILabel *TelTwo;
    - (IBAction)MakeCallTwo:(id)sender;

@end
