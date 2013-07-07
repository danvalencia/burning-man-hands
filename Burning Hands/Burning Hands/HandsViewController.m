//
//  HandsViewController.m
//  Burning Hands
//
//  Created by Daniel Valencia on 7/4/13.
//  Copyright (c) 2013 Daniel Valencia Co. All rights reserved.
//

#import "HandsViewController.h"

@interface HandsViewController ()
@property (nonatomic, strong) HandsGrid *handsGrid;
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

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tapRecognizer.numberOfTapsRequired = 1;
    
    
    self.handsGrid =  [[HandsGrid alloc] init];
    [self.handsGrid addGestureRecognizer:tapRecognizer];
    self.handsGrid.delegate = self;
    [self.view addSubview:self.handsGrid];
    // Do any additional setup after loading the view from its nib.
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [recognizer locationInView:self.handsGrid];
        self.coordinateUpdateLabel.text = [NSString stringWithFormat:@"x: %f, y: %f", location.x, location.y];
        [self.handsGrid updateLocation:location];
    }
}

- (void)cellTouched:(HandsCell*)cell
{
    self.coordinateUpdateLabel.text = [NSString stringWithFormat:@"x: %d, y: %d", cell.x, cell.y];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
