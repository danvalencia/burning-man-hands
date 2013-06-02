//
//  ViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 2/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "ViewController.h"
#import "Loader.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize userName = _userName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    loader = [[Loader alloc] initWithFrame:self.view.bounds];
    
    [loader startAnimating];
    [loader setHidden:TRUE];
    loader.frame = CGRectMake(390, 165, 64, 64);
    [self.view addSubview: loader];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectToDevice:(id)sender
{    
    [loader setHidden:FALSE];
    
    NSString *greeting = @"Connecting";
    self.greetingLabel.text = greeting;
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
////    if (theTextField == self.nameTextField) {
////        [theTextField resignFirstResponder];
////    }
//    return YES;
//}


@end
