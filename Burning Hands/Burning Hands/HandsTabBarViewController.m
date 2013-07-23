//
//  HandsTabBarViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsTabBarViewController.h"

@interface HandsTabBarViewController ()

@end

@implementation HandsTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationPortraitUpsideDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
