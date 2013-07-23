//
//  HandsViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsViewController.h"
#import "ColorSelector.h"

@interface HandsViewController () {
    ColorSelector *colorSelector;
    HandsGrid *handsGrid;
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
    handsGrid =  [[HandsGrid alloc] init];
    handsGrid.delegate = self;
    [self.view addSubview:handsGrid];
    
    colorSelector = [[ColorSelector alloc] init];
    [self.view addSubview:colorSelector];
}

- (void)cellTouched:(HandsCell*)cell
{
    handsGrid.currentColor = colorSelector.selectedColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
