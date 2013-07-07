//
//  HandsViewController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandsGrid.h"

@interface HandsViewController : UIViewController <HandsGridDelegate>

@property (strong, nonatomic) IBOutlet UILabel *coordinateUpdateLabel;

@end
