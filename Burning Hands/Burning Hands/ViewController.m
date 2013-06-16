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

- (void) addLoader;
- (void) initBluetooth;
@end

@implementation ViewController

//@synthesize userName = _userName;
//@synthesize ble = _ble;
//@synthesize connectBtn = _connectBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initBluetooth];
    [self addLoader];    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectToDevice:(id)sender
{
    if (_ble.activePeripheral)
        if(_ble.activePeripheral.isConnected)
        {
            [[_ble CM] cancelPeripheralConnection:[_ble activePeripheral]];
            
            [_connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
            return;
        }
    
    if (_ble.peripherals)
        _ble.peripherals = nil;
    
    [_connectBtn setEnabled:false];
    [_connectBtn setTitle:@"Connecting" forState:UIControlStateNormal];
    [_ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    [loader startAnimating];

    [loader setHidden:FALSE];
    
//    NSString *greeting = @"Connecting";
//    
//    self.greetingLabel.text = greeting;
    
}

- (IBAction)toggleLED:(id)sender
{
    if ([sender isOn])
    {
        [self sendDigitalOut:0x01];
        NSLog(@"Switch is ON");
        
    }
    else
    {
        [self sendDigitalOut:0x00];
        NSLog(@"Switch is OFF");

    }
}

- (IBAction)updateColor:(id)sender {
    //[self colorTextField]
}

-(void) sendDigitalOut:(UInt8)value
{
    
    UInt8 buf[1] = {value};
    NSData *data = [[NSData alloc] initWithBytes:buf length:1];
    [_ble write:data];
}


-(void) connectionTimer:(NSTimer *)timer
{
    [_connectBtn setEnabled:true];
    [_connectBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
    
    if (_ble.peripherals.count > 0)
    {
        [_ble connectPeripheral:[_ble.peripherals objectAtIndex:0]];
    }
    else
    {
        self.greetingLabel.text = @"Disconnected";

        [_connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
        [loader stopAnimating];
    }
}

-(void) bleDidConnect
{
    NSLog(@"->Connected");
    
    self.greetingLabel.text = @"   Connected";
    
    [loader stopAnimating];    
    
}

-(void) bleDidDisconnect
{
    NSLog(@"->Disconnected");
    
    [_connectBtn setTitle:@"Connect" forState:UIControlStateNormal];

    [loader stopAnimating];
}

-(void) bleDidUpdateRSSI:(NSNumber *) rssi
{
    //lblRSSI.text = rssi.stringValue;
}

-(void) bleDidReceiveData:(unsigned char *) data length:(int) length
{
    NSLog(@"Length: %d", length);
    
    // parse data, all commands are in 3-byte
    for (int i = 0; i < length; i+=3)
    {
        NSLog(@"0x%02X, 0x%02X, 0x%02X", data[i], data[i+1], data[i+2]);
        
        if (data[i] == 0x0A)
        {
           // if (data[i+1] == 0x01)
                //swDigitalIn.on = true;
           // else
                //swDigitalIn.on = false;
        }
        else if (data[i] == 0x0B)
        {
           // UInt16 Value;
            
            //Value = data[i+2] | data[i+1] << 8;
            //lblAnalogIn.text = [NSString stringWithFormat:@"%d", Value];
        }
    }

}


- (void)addLoader
{
    
    loader = [[Loader alloc] initWithFrame:self.view.bounds];
    
    
    [loader startAnimating];
    [loader setHidden:TRUE];
    loader.frame = CGRectMake(390, 165, 64, 64);
    [self.view addSubview: loader];
}

-(void)initBluetooth
{
    NSLog(@"Initializing Bluetooth!");
    _ble = [[BLE alloc] init];
    [_ble controlSetup:1];
    _ble.delegate = self;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
////    if (theTextField == self.nameTextField) {
////        [theTextField resignFirstResponder];
////    }
//    return YES;
//}


- (IBAction)ledSwitch:(id)sender {
}
@end
