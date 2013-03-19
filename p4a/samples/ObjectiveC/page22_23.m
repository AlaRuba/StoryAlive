//
//  page22_23.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page22_23.h"
#import "GlobalModel.h"

@interface page22_23 (){
    LeapController *controller;
    BOOL touchingCricket;
    BOOL touched;
}

@end

@implementation page22_23
@synthesize page22_23_franny;
@synthesize page22_23_cricket;
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
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page22_23_voice" ofType:@"m4a"] byReference:NO];
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
        touchingCricket = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),page22_23_cricket.frame);
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
