//
//  HandsViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsViewController.h"
#import "ColorSelector.h"
#import "BLEManager.h"
#import "ColorUpdateCommand.h"
#import "HandsModel.h"
#import "Constants.h"

@interface HandsViewController () {
    ColorSelector *colorSelector;
    HandsGrid *rightHandGrid;
    HandsGrid *leftHandGrid;
    HandsGrid *visibleView;
    HandsGrid *backView;
}

@end

@implementation HandsViewController

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
    leftHandGrid = [[HandsGrid alloc] initWithHand:[[HandsModel sharedInstance] leftHand] transX:WIDTH transY:HEIGHT scaleX:-1.0 scaleY:-1.0];
    [leftHandGrid setAlpha:0.0];
    leftHandGrid.delegate = self;
    [self.view addSubview:leftHandGrid];

    rightHandGrid =  [[HandsGrid alloc] initWithHand:[[HandsModel sharedInstance] rightHand] transX:0.0 transY:HEIGHT scaleX:1.0 scaleY:-1.0];
    rightHandGrid.delegate = self;
    [self.view addSubview:rightHandGrid];
    
    
    visibleView = rightHandGrid;
    backView = leftHandGrid;
    
    colorSelector = [[ColorSelector alloc] init];
    [self.view addSubview:colorSelector];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(flipView:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"flip" forState:UIControlStateNormal];
    button.frame = CGRectMake(260.0, 360.0, 40.0, 40.0);
    [self.view addSubview:button];
}

-(void)flipView:(id)sender
{
    
    [UIView transitionWithView:backView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [visibleView setAlpha:0.0];
            [backView setAlpha:1.0];
        } completion:^(BOOL finished){
            HandsGrid *tempView = visibleView;
            visibleView = backView;
            backView = tempView;
        }];
//    
//    [UIView transitionWithView:self.btnCardFront duration:1.5
//      options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionCurveEaseInOut
//      animations:^{
//     } completion:^(BOOL finished){}];
//}
}

- (void)cellTouched:(HandsCell*)cell
{
    cell.parentHandsGrid.currentColor =colorSelector.selectedColor;
    //rightHandGrid.currentColor = colorSelector.selectedColor;
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ColorUpdateCommand* command = [[ColorUpdateCommand alloc] initWithCell:cell];
        [[BLEManager sharedInstance] executeCommand:command onHand:cell.parentHandsGrid.hand];
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
