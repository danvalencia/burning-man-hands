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
    UIView *colorPatch;
}

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
    self.handsGrid =  [[HandsGrid alloc] init];
    self.handsGrid.delegate = self;
    [self.view addSubview:self.handsGrid];
    
    ColorSelector* colorSelector = [[ColorSelector alloc] init];
    [self.view addSubview:colorSelector];
    
    colorPatch = [[UIView alloc] initWithFrame:CGRectMake(160, 380.0, 150, 30.0)];
	[self.view addSubview:colorPatch];

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
