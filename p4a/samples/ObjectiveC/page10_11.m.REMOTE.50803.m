//
//  page10-11.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page10_11.h"
#import "GlobalModel.h"

@interface page10_11 ()
{
    LeapController *controller;
    BOOL touchingFranny1;
    BOOL touchingFranny2;
    BOOL touchingCricket;
    BOOL touchedFranny;
    BOOL touchedCricket;
    BOOL touched;
}
@end

@implementation page10_11
@synthesize page10_11_cricket;
@synthesize page10_11_ellery;
@synthesize page10_11_fart;
@synthesize page10_11_franny;
@synthesize page10_11_josie;
@synthesize page10_11_martin;
@synthesize cursor1;
@synthesize cursor2;
@synthesize animated_fart;

@synthesize sound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (void)loadView{
    [super loadView];
    NSLog(@"Initialized");
    [animated_fart setHidden:NO];
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page10_11_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fartReal" ofType:@"mp3"] byReference:NO];
    [model.sound play];

    [self run];

}

- (void)run
{
    controller = [[LeapController alloc] init];
    [controller addListener:self];
    NSLog(@"running");
}

- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
}

#pragma mark - SampleListener Callbacks

- (void)onInit:(NSNotification *)notification
{
    NSLog(@"Initialized");
}

- (void)onConnect:(NSNotification *)notification;
{
    NSLog(@"Connected");
    LeapController *aController = (LeapController *)[notification object];
    [aController enableGesture:LEAP_GESTURE_TYPE_CIRCLE enable:YES];
    [aController enableGesture:LEAP_GESTURE_TYPE_KEY_TAP enable:YES];
    [aController enableGesture:LEAP_GESTURE_TYPE_SCREEN_TAP enable:YES];
    [aController enableGesture:LEAP_GESTURE_TYPE_SWIPE enable:YES];
}

- (void)onDisconnect:(NSNotification *)notification;
{
    NSLog(@"Disconnected");
}

- (void)onExit:(NSNotification *)notification;
{
    NSLog(@"Exited");
}



- (void)onFrame:(NSNotification *)notification;
{
    /*
    LeapController *aController = (LeapController *)[notification object];
    LeapFrame *frame = [aController frame:0];
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    if([frame pointables].count > 1)
    {
        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable = [[frame pointables] objectAtIndex:0];
        
        LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:1];
        int xPixel = (int)(normalizedCoordinates.x * [screen widthPixels]);
        int yPixel = (int)(normalizedCoordinates.y * [screen heightPixels]); //screen heightPixels] -
        
        [cursor1 setFrameOrigin:NSMakePoint(xPixel, yPixel)];
        //        [cursor setNeedsDisplay:YES];
        if (!touched) {
            touchingFranny1 = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),page10_11_franny.frame);

            touchingCricket = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),page10_11_cricket.frame);
            if (touchingCricket) {
                model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cricket" ofType:@"mp3"] byReference:NO];
                [model.sound play];
            }   
        }

        // NSLog(@"%d %d",[screen widthPixels],[screen heightPixels]);
        // NSLog(@"X: %d Y: %d",xPixel,yPixel);
    }
    if([frame pointables].count > 1 )
    {
        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable = [[frame pointables] objectAtIndex:1];
        
        LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:1];
        int xPixel = (int)(normalizedCoordinates.x * [screen widthPixels]);
        int yPixel = (int)(normalizedCoordinates.y * [screen heightPixels]); //screen heightPixels] -
        
        [cursor2 setFrameOrigin:NSMakePoint(xPixel, yPixel)];
        //        [cursor setNeedsDisplay:YES];
        if (!touched) {
        
            touchingFranny2 = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),page10_11_franny.frame);
            
            touchingCricket = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),page10_11_cricket.frame);
            if (touchingCricket) {
                model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cricket" ofType:@"mp3"] byReference:NO];
                [model.sound play];
            }
        }
        
    }
    if (touchingFranny1 && touchingFranny2) {
        if (!touched) {
            touched = YES;
            [animated_fart setHidden:NO];
            [model.sound pause];
            model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fartReal" ofType:@"mp3"] byReference:NO];
            [model.sound play];
            model.sound = nil;
        }
    }*/
    
}

- (void) viewDidAppear {
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
}

- (void) viewDidDisappear {
    touchedCricket = YES;
    touchedFranny = YES;
}

- (NSString *)stringForState:(LeapGestureState)state
{
    switch (state) {
        case LEAP_GESTURE_STATE_INVALID:
            return @"STATE_INVALID";
        case LEAP_GESTURE_STATE_START:
            return @"STATE_START";
        case LEAP_GESTURE_STATE_UPDATE:
            return @"STATE_UPDATED";
        case LEAP_GESTURE_STATE_STOP:
            return @"STATE_STOP";
        default:
            return @"STATE_INVALID";
    }
}


@end
