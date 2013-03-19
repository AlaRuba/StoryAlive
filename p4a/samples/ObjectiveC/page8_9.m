//
//  page8-9.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page8_9.h"
#import "GlobalModel.h"
#import "LeapObjectiveC.h"

@interface page8_9 () {
    LeapController *controller;
    BOOL touchingFranny1;
    BOOL touchingFranny2;
    BOOL touchedFranny1;
    BOOL touchedFranny2;
    BOOL instructionsPlayed;
}
@property (nonatomic, strong) NSImageView *cursor2;
@end

@implementation page8_9
@synthesize page8_9_ellery;
@synthesize page8_9_franny;
@synthesize page8_9_josie;
@synthesize page8_9_martin;
@synthesize sound;
@synthesize cursor2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (void)actualViewDidAppear {
    [super loadView];
    NSLog(@"Initialized");
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page8_9_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
    touchedFranny1 = NO;
    touchedFranny2 = NO;
    instructionsPlayed = NO;
    NSRect rect = NSMakeRect(100, 100, 100, 100);
    cursor2 = [[NSImageView alloc] initWithFrame:rect];
    [cursor2 setImage: [NSImage imageNamed:@"pointing_finger"]];
    [self.view addSubview: cursor2];
    
    [self run];
}

- (void)run
{
    controller = [[LeapController alloc] init];
    [controller addListener:self];
    NSLog(@"running");
}

- (void)onInit:(NSNotification *)notification
{
    NSLog(@"Initialized");
}

- (void)onConnect:(NSNotification *)notification;
{
    NSLog(@"Connected");
    LeapController *aController = (LeapController *)[notification object];
    //   [aController enableGesture:LEAP_GESTURE_TYPE_CIRCLE enable:YES];
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
    LeapController *aController = (LeapController *)[notification object];
    LeapFrame *frame = [aController frame:0];

    if([frame pointables].count > 1) {
        [cursor2 setHidden:NO];
        
        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable2 = [[frame pointables] objectAtIndex:1];
        LeapPointable *pointable1 = [[frame pointables] objectAtIndex:0];
        
        LeapVector *normalizedCoordinates1 = [screen intersect:pointable1 normalize:YES clampRatio:1];
        int xPixel1 = (int)(normalizedCoordinates1.x * [screen widthPixels]);
        int yPixel1 = (int)(normalizedCoordinates1.y * [screen heightPixels]); //screen heightPixels] -
        
        LeapVector *normalizedCoordinates2 = [screen intersect:pointable2 normalize:YES clampRatio:1];
        int xPixel2 = (int)(normalizedCoordinates2.x * [screen widthPixels]);
        int yPixel2 = (int)(normalizedCoordinates2.y * [screen heightPixels]); //screen heightPixels] -
        
        [cursor2 setFrameOrigin:NSMakePoint(xPixel2, yPixel2)];
        if (!touchedFranny1 && !touchedFranny2) {
            if (xPixel1 > 450 && xPixel1 < 530 && yPixel1 > 200 && yPixel1 < 300) {
                touchingFranny1 = YES;
            } else {
                touchingFranny1 = NO;
            }
            if (xPixel2 > 450 && xPixel2 < 530 && yPixel2 > 200 && yPixel2 < 300) {
                touchingFranny2 = YES;
            } else {
                touchingFranny2 = NO;
            }
            if (touchingFranny1 && touchingFranny2) {
                NSLog(@"touching and move to next page");
                touchingFranny1 = NO;
                touchedFranny1 = YES;
                touchingFranny2 = NO;
                touchedFranny2 = YES;
            }
        }
    }
    else {
        [cursor2 setHidden:YES];
    }
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    if (!instructionsPlayed) {
        if (![model.sound isPlaying]) {
            [model.sound pause];
            model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pg8_9_instructions" ofType:@"m4a"] byReference:NO];
            [model.sound play];
            instructionsPlayed = YES;
        }
    }
}

- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
}

@end
