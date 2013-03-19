//
//  page24_25.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page24_25.h"
#import "GlobalModel.h"

@interface page24_25 () {
    LeapController *controller;
    BOOL touchingCricket;
    BOOL touched;
}

@end

@implementation page24_25
@synthesize page24_25_cricket;
@synthesize page24_25_franny;
@synthesize cricket;
@synthesize cursor;
@synthesize sound;

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
    [cricket setHidden:YES];
    
}

- (void)actualViewDidAppear {
    [cricket setHidden:NO];
    [cricket start];
    
    NSLog(@"Initialized");
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page24_25_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
    touched = NO;
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

- (void)onFrame:(NSNotification *)notification;
{
    LeapController *aController = (LeapController *)[notification object];
    LeapFrame *frame = [aController frame:0];
    
    if([frame pointables].count > 0 )
    {
        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable = [[frame pointables] objectAtIndex:0];
        
        LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:1];
        int xPixel = (int)(normalizedCoordinates.x * [screen widthPixels]);
        int yPixel = (int)(normalizedCoordinates.y * [screen heightPixels]); //screen heightPixels] -
        
        [cursor setFrameOrigin:NSMakePoint(xPixel, yPixel)];
        
        if (!touched) {
        touchingCricket = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),cricket.frame);
        GlobalModel *model = [GlobalModel sharedGlobalModel];
        if (touchingCricket && ![model.sound isPlaying]) {
            model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cricket" ofType:@"mp3"] byReference:NO];
            [model.sound play];
            touched = YES;
        }
        }
        
        // NSLog(@"%d %d",[screen widthPixels],[screen heightPixels]);
        // NSLog(@"X: %d Y: %d",xPixel,yPixel);
    }
    
}

@end
