//
//  page26_27.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page26_27.h"
#import "GlobalModel.h"

@interface page26_27 () {
    LeapController *controller;
    BOOL touchingCricket;
    BOOL instructionsPlayed;
    BOOL touchedCricket;
}

@end

@implementation page26_27
@synthesize page26_27_cricket;
@synthesize page26_27_franny;
@synthesize note1;
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
    
}

- (void)actualViewDidAppear{
    NSLog(@"Initialized");
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page26_27_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
    instructionsPlayed = NO;
    touchedCricket = NO;
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
        if (!touchedCricket) {
            touchingCricket = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),cricket.frame);
            GlobalModel *model = [GlobalModel sharedGlobalModel];
    
            if (touchingCricket && ![model.sound isPlaying]) {
                model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cricket" ofType:@"mp3"] byReference:NO];
                [model.sound play];
            }
        }
        
        // NSLog(@"%d %d",[screen widthPixels],[screen heightPixels]);
        // NSLog(@"X: %d Y: %d",xPixel,yPixel);
    }
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    if (!instructionsPlayed) {
        if (![model.sound isPlaying]) {
            [model.sound pause];
            model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pg26_27_instructions" ofType:@"m4a"] byReference:NO];
            [model.sound play];
            instructionsPlayed = YES;
        }
    }
}

@end
