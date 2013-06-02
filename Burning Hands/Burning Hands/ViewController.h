//
//  ViewController.h
//  Burning Hands
//
//  Created by Daniel Valencia on 2/24/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loader.h"

@interface ViewController : UIViewController <UITextFieldDelegate>{
    Loader *loader;
}

@property (weak, nonatomic) IBOutlet UILabel *greetingLabel;
- (IBAction)connectToDevice:(id)sender;

@property (copy, nonatomic) NSString *userName;

@end
