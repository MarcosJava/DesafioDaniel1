//
//  GestureViewController.m
//  DesafioDaniel
//
//  Created by Marcos Felipe Souza on 02/04/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "GestureViewController.h"
#import "AFNetworking.h"


@interface GestureViewController ()

@end

@implementation GestureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Gesture Recogize";
    
    [self getJson];
    //[self getXML];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        NSLog(@"called");
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        if (self.isGreen == FALSE){
            [self putGreen];
            self.isGreen = true;
        } else {
            [self putBlack];
            self.isGreen = FALSE;
        }
        
    }
}

-(void) putGreen {
    [self.view setBackgroundColor:[UIColor greenColor]];
    self.messageLabel.text = @"Shake Movition\nPull Movition for Music\nJSON com AFNetworking";
    self.messageLabel.textColor = [UIColor whiteColor];
}

-(void) putBlack {
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.messageLabel.text = @"BUUUUHHH !!!";
    self.messageLabel.textColor = [UIColor redColor];
}

-(void) putBlue {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.messageLabel.text = @"Eh pro outro lado  ;)";
    self.messageLabel.textColor = [UIColor blueColor];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    self.isGreen = FALSE;
    self.goMusic = false;
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); //vibrando
    
    [self startMotionManager];
    
}


- (void) getJson {
    NSString *urlJson = @"http://api.geonames.org/citiesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&lang=de&username=demo";
   
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlJson parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void) getXML {
    //http://servicos.cptec.inpe.br/XML/listaCidades
    
    NSString *urlXml = @"http://api.geonames.org/cities?north=44.1&south=-9.9&east=-22.4&west=55.2&username=demo";
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlXml parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"goMusic"]) {
        
    }
}




- (void)startMotionManager{
    if (self.motionManager == nil) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    
    self.motionManager.deviceMotionUpdateInterval = 1/100.0;
    if (self.motionManager.deviceMotionAvailable) {
        
        NSLog(@"Device Motion Available");
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                           withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                               //CMAttitude *attitude = motion.attitude;
                                               //NSLog(@"rotation rate = [%f, %f, %f]", attitude.pitch, attitude.roll, attitude.yaw);
                                               [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
                                               
                                           }];
        //[motionManager startDeviceMotionUpdates];
        
        
    } else {
        NSLog(@"No device motion on device.");
        [self setMotionManager:nil];
    }
}

- (void)handleDeviceMotion:(CMDeviceMotion*)motion{
    CMAttitude *attitude = motion.attitude;
    
    float accelerationThreshold = 0.2; // or whatever is appropriate - play around with different values
    CMAcceleration userAcceleration = motion.userAcceleration;
    
    float rotationRateThreshold = 7.0;
    CMRotationRate rotationRate = motion.rotationRate;
    
    
    if ((rotationRate.x) > rotationRateThreshold) {
        
        if (fabs(userAcceleration.x) > accelerationThreshold || fabs(userAcceleration.y) > accelerationThreshold || fabs(userAcceleration.z) > accelerationThreshold) {
            
            NSLog(@"rotation rate = [Pitch: %f, Roll: %f, Yaw: %f]", attitude.pitch, attitude.roll, attitude.yaw);
            NSLog(@"motion.rotationRate X= %f", rotationRate.x);
            NSLog(@"motion.rotationRate Y= %f", rotationRate.y);
            NSLog(@"motion.rotationRate Z= %f", rotationRate.z);
            NSLog(@"FRENTE -- PUXA");
            
            if (self.goMusic == false) {
                self.goMusic = true;
                [self performSegueWithIdentifier:@"goMusic" sender:nil];
            }
            
            //[self showMenuAnimated:YES];
        }
    
    }else if ((-rotationRate.x) > rotationRateThreshold) {
        if (fabs(userAcceleration.x) > accelerationThreshold || fabs(userAcceleration.y) > accelerationThreshold || fabs(userAcceleration.z) > accelerationThreshold) {
            
            NSLog(@"rotation rate = [Pitch: %f, Roll: %f, Yaw: %f]", attitude.pitch, attitude.roll, attitude.yaw);
            NSLog(@"motion.rotationRate X = %f", rotationRate.x);
            NSLog(@"motion.rotationRate Y= %f", rotationRate.y);
            NSLog(@"motion.rotationRate Z= %f", rotationRate.z);
            NSLog(@"TRAZ -- JOGA");
           
            [self putBlue];
           // [self dismissMenuAnimated:YES];
        }
    }
}
@end
