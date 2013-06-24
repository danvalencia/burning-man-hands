//
//  ModeDetailViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 6/23/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ModeDetailViewController.h"
#import "Mode.h"

@interface ModeDetailViewController ()

@end

@implementation ModeDetailViewController

- (void) setMode:(Mode *)newMode
{
    if(_mode != newMode)
    {
        _mode = newMode;
        
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    Mode *theMode = self.mode;
    
    if (theMode) {
        self.title = theMode.name;
    }
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
	// Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
