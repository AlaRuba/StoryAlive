//
//  page1_2.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page1_2.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "NSImage-Extras.h"
#import "GlobalModel.h"
#import "CircleView.h"

@interface page1_2 ()
{
    LeapController *controller;
    NSMutableArray *trailArray;
    int maxImagesInTrail;
    int currentImageIndex;
    BOOL touching;
    BOOL touched;
}
@end

@implementation page1_2
@synthesize page1_2_cricket;
@synthesize page1_2_sun;
@synthesize sound;
@synthesize cursor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)createImageArray
{
    maxImagesInTrail = 600;
    currentImageIndex = 0;
    trailArray = [[NSMutableArray alloc] initWithCapacity:maxImagesInTrail];
    for (int i = 0; i < maxImagesInTrail; i++) {
//        NSRect rect = NSMakeRect(110, 110, 202, 203);
//        NSImageView *imageView = [[NSImageView alloc] initWithFrame:rect];
//        [imageView setImage: [NSImage imageNamed:@"page1_2_sun"]];
//        [self.view addSubview: imageView];
        CircleView *circle = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.view addSubview:circle];
        [trailArray addObject:circle];
    }
}

- (void)createSun:(NSArray *)point
{
    if (currentImageIndex >= trailArray.count) {
        currentImageIndex = 0;
    }
    NSPoint pt = NSMakePoint([[point objectAtIndex:0] floatValue], [[point objectAtIndex:1] floatValue]);
    CircleView *imageView = [trailArray objectAtIndex:currentImageIndex];
    [imageView setHidden:NO];
    [imageView setFrameOrigin:pt];
    currentImageIndex++;
    //[imageView.layer addAnimation:[self opacityAnimation] forKey:@"opacityPath"];
    [self performSelector:@selector(removeSun:) withObject:imageView afterDelay:1];
}

- (CAAnimation*)opacityAnimation

{
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    rotationAnimation.toValue = 0;
    rotationAnimation.duration = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.autoreverses      = NO;
    rotationAnimation.repeatCount       = 0;
    return rotationAnimation;
    
}

- (void)removeSun:(CircleView *)sun
{
    [sun setHidden:YES];
}

- (void)updateTrail:(NSArray *)point
{
    NSPoint pt = NSMakePoint([[point objectAtIndex:0] floatValue], [[point objectAtIndex:1] floatValue]);
    NSImageView *imageView = [trailArray lastObject];
    [trailArray insertObject:imageView atIndex:0];
    [imageView setFrameOrigin:pt];
}


//- (void)viewDidAppear
//{
//    NSLog(@"Initialized");
//    GlobalModel *model = [GlobalModel sharedGlobalModel];
//    [model.sound pause];
//    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cover_voice" ofType:@"m4a"] byReference:NO];
//    [model.sound play];;
//}

- (void)loadView
{
    [super loadView];
    
    NSLog(@"Successfully Overrode");
    
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    
    [page1_2_cricket setHidden:NO];
    [page1_2_sun setHidden:NO];
    [page1_2_sun start];
    [page1_2_cricket start];
    
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cover_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
}

- (void)actualViewDidAppear
{
    NSLog(@"Successfully Overrode");
    
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    
    [page1_2_cricket setHidden:NO];
    [page1_2_sun setHidden:NO];
    [page1_2_sun start];
    [page1_2_cricket start];
    
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cover_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
}

- (void)goToNextPage;
{
    touched = YES;
    NSLog(@"Exited");
    [sound stop];
}


- (void)run
{
   // controller = [[LeapController alloc] init];
   // [controller addListener:self];
    NSLog(@"running");
}

#pragma mark - SampleListener Callbacks
/*
- (void)onInit:(NSNotification *)notification
{
    NSLog(@"Initialized");
}

- (void)onConnect:(NSNotification *)notification;
{
    NSLog(@"Connected");
    LeapController *aController = (LeapController *)[notification object];
    [aController enableGesture:LEAP_GESTURE_TYPE_CIRCLE enable:YES];
}

- (void)onDisconnect:(NSNotification *)notification;
{
    NSLog(@"Disconnected");
}

- (void)onExit:(NSNotification *)notification;
{
    NSLog(@"Exited");
    touched = YES;
}

- (void)onFrame:(NSNotification *)notification;
{
    LeapController *aController = (LeapController *)[notification object];
    LeapFrame *frame = [aController frame:0];
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    NSInteger num = [frame pointables].count;
    if(!touched && num > 0 )
    {
        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable = [[frame pointables] objectAtIndex:0];
        
        LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:1];
        int xPixel = (int)(normalizedCoordinates.x * [screen widthPixels]);
        int yPixel = (int)(normalizedCoordinates.y * [screen heightPixels]); //screen heightPixels] -
        //NSLog(@"HERE");
        [cursor setFrameOrigin:NSMakePoint(xPixel, yPixel)];
        NSNumber *p1 = [NSNumber numberWithInt:xPixel];
        NSNumber *p2 = [NSNumber numberWithInt:yPixel];

        [self performSelector:@selector(createSun:) withObject:[[NSArray alloc] initWithObjects:p1,p2, nil] afterDelay:0];
        //[self updateTrail:];
        if (!touched && ![model.sound isPlaying]) {
            touching = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),cricket.frame);
            if (touching) {
                [model.sound pause];
                model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cricket" ofType:@"mp3"] byReference:NO];
                [model.sound play];
                model.sound = nil;
                touching = NO;
                touched = YES;
            }
        }
    }
}
*/


@end
