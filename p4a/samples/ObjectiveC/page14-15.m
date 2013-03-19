//
//  page14-15.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page14-15.h"
#import "GlobalModel.h"

@interface page14_15 ()
{
    LeapController *controller;
    BOOL touchingFlashlight;
    BOOL touchingXmas;
    BOOL touchingTopFirefly;
    BOOL touchingBottomFirefly;
}
@end

@implementation page14_15
@synthesize page14_15_bottom_1;
@synthesize page14_15_bottom_2;
@synthesize page14_15_bottom_1_default;
@synthesize page14_15_flashlight;
@synthesize page14_15_top_1;
@synthesize page14_15_top_1_default;
@synthesize page14_15_top_2;
@synthesize page14_15_xmas;
@synthesize sound;


#define delay .3

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
    [page14_15_top_1 setHidden:YES];
    [page14_15_top_2 setHidden:YES];
    [page14_15_bottom_1 setHidden:YES];
    [page14_15_bottom_2 setHidden:YES];
    [page14_15_flashlight setHidden:YES];
    [page14_15_xmas setHidden:YES];
}


//loadView is declared in NSViewController, but awakeFromNib would work also
//this is preferred to doing things in initWithNibName:bundle: because
//views are loaded lazily, so you don't need to go loading the other nibs
//until your own nib has actually been loaded.
- (void)actualViewDidAppear
{
    [page14_15_flashlight setHidden:NO];
    [page14_15_xmas setHidden:NO];
    [page14_15_xmas start];
    [page14_15_flashlight start];
  
    NSLog(@"Initialized");
    
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page14_15_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
    
    [self run];
    
    //  contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentView" bundle:nil];
    // [[contentViewController view] setFrame:[contentView frame]];
    // [[self view] replaceSubview:contentView with:[contentViewController view]];
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


- (void)topProgression
{
    [page14_15_top_1 setHidden:NO];
    [self performSelector:@selector(topProgression1) withObject:nil afterDelay:delay];
}


- (void)topProgression1
{
    [page14_15_top_2 setHidden:NO];
}


- (void)bottomProgression
{
    [page14_15_bottom_1 setHidden:NO];
    [self performSelector:@selector(bottomProgression1) withObject:nil afterDelay:delay];
}


- (void)bottomProgression1
{
    [page14_15_bottom_2 setHidden:NO];
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
        
        //        [cursor setNeedsDisplay:YES];
        
        if (!touchingTopFirefly) {
            if (touchingFlashlight) {
                [page14_15_flashlight setFrameOrigin:NSMakePoint(xPixel, yPixel)];
                
                NSRect topFireflyRect = NSMakeRect(0, 500, 300, 400);
                touchingTopFirefly = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),topFireflyRect);
                if (touchingTopFirefly) {
                    // Bottom and top are reversed
                    [page14_15_top_1_default setImage:[NSImage imageNamed:@"page14_15_top_1.png"]];
                    [page14_15_flashlight setHidden:YES];
                    [self performSelector:@selector(topProgression) withObject:nil afterDelay:delay];
                }
                // Handle case for touching ring
                
            } else {
                NSRect xmasRect = NSMakeRect(1130, 900, 146, 146);
                touchingFlashlight = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+210),xmasRect);
            }
        }
        
        if (!touchingBottomFirefly) {
            if (touchingXmas) {
                [page14_15_xmas  setFrameOrigin:NSMakePoint(xPixel, yPixel)];
                
                NSRect bottomFireflyRect = NSMakeRect(0, 0, 300, 340);
                touchingBottomFirefly = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),bottomFireflyRect);
                if (touchingBottomFirefly) {
                    // Bottom and top are reversed
                    [page14_15_bottom_1_default setImage:[NSImage imageNamed:@"page14_15_bottom_1.png"]];
                    [page14_15_xmas setHidden:YES];
                    [self performSelector:@selector(bottomProgression) withObject:nil afterDelay:delay];
                }
                // Handle case for touching coin
                
            } else {
                NSRect flashlightRect = NSMakeRect(1130, 300, 146, 146);
                touchingXmas = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),flashlightRect);
            }
        }
        
        // NSLog(@"%d %d",[screen widthPixels],[screen heightPixels]);
        // NSLog(@"X: %d Y: %d",xPixel,yPixel);
    }
    
    //  [firefly setBounds:NSRectFromCGRect(CGRectMake(0, 0, 50, 50))];
    
    
    // Get the most recent frame and report some basic information
    /*
     NSLog(@"Frame id: %lld, timestamp: %lld, hands: %ld, fingers: %ld, tools: %ld, gestures: %ld",
     [frame id], [frame timestamp], [[frame hands] count],
     [[frame fingers] count], [[frame tools] count], [[frame gestures:nil] count]);
     */
    /*
     if ([[frame hands] count] != 0) {
     // Get the first hand
     LeapHand *hand = [[frame hands] objectAtIndex:0];
     
     // Check if the hand has any fingers
     NSArray *fingers = [hand fingers];
     if ([fingers count] >= 3) {
     // Calculate the hand's average finger tip position
     LeapVector *avgPos = [[LeapVector alloc] init];
     for (int i = 0; i < [fingers count]; i++) {
     LeapFinger *finger = [fingers objectAtIndex:i];
     avgPos = [avgPos plus:[finger tipPosition]];
     }
     avgPos = [avgPos divide:[fingers count]];
     NSLog(@"Hand has %ld fingers, average finger tip position %@",
     [fingers count], avgPos);
     
     
     // Get the hand's sphere radius and palm position
     NSLog(@"Hand sphere radius: %f mm, palm position: %@",
     [hand sphereRadius], [hand palmPosition]);
     
     // Get the hand's normal vector and direction
     const LeapVector *normal = [hand palmNormal];
     const LeapVector *direction = [hand direction];
     
     // Calculate the hand's pitch, roll, and yaw angles
     NSLog(@"Hand pitch: %f degrees, roll: %f degrees, yaw: %f degrees\n",
     [direction pitch] * LEAP_RAD_TO_DEG,
     [normal roll] * LEAP_RAD_TO_DEG,
     [direction yaw] * LEAP_RAD_TO_DEG);
     
     NSArray *gestures = [frame gestures:nil];
     //for (int g = 0; g < [gestures count]; g++) {
     if ([gestures count] > 0) {
     LeapGesture *gesture = [gestures objectAtIndex:0];
     if (gesture.type == LEAP_GESTURE_TYPE_SWIPE) {
     LeapSwipeGesture *swipeGesture = (LeapSwipeGesture *)gesture;
     NSLog(@"Swipe id: %d, %@, position: %@, direction: %@, speed: %f",
     swipeGesture.id, [self stringForState:swipeGesture.state],
     swipeGesture.position, swipeGesture.direction, swipeGesture.speed);
     }
     }
     
     // }
     
     }
     
     
     }
     //     switch (gesture.type) {
     //     case LEAP_GESTURE_TYPE_CIRCLE: {
     //     LeapCircleGesture *circleGesture = (LeapCircleGesture *)gesture;
     //     // Calculate the angle swept since the last frame
     //     float sweptAngle = 0;
     //     if(circleGesture.state != LEAP_GESTURE_STATE_START) {
     //     LeapCircleGesture *previousUpdate = (LeapCircleGesture *)[[aController frame:1] gesture:gesture.id];
     //     sweptAngle = (circleGesture.progress - previousUpdate.progress) * 2 * LEAP_PI;
     //     }
     //
     //     NSLog(@"Circle id: %d, %@, progress: %f, radius %f, angle: %f degrees",
     //     circleGesture.id, [self stringForState:gesture.state],
     //     circleGesture.progress, circleGesture.radius, sweptAngle * LEAP_RAD_TO_DEG);
     //     break;
     
     //     case LEAP_GESTURE_TYPE_KEY_TAP: {
     //     LeapKeyTapGesture *keyTapGesture = (LeapKeyTapGesture *)gesture;
     //     NSLog(@"Key Tap id: %d, %@, position: %@, direction: %@",
     //     keyTapGesture.id, [self stringForState:keyTapGesture.state],
     //     keyTapGesture.position, keyTapGesture.direction);
     //     break;
     //     }
     //     case LEAP_GESTURE_TYPE_SCREEN_TAP: {
     //     LeapScreenTapGesture *screenTapGesture = (LeapScreenTapGesture *)gesture;
     //     NSLog(@"Screen Tap id: %d, %@, position: %@, direction: %@",
     //     screenTapGesture.id, [self stringForState:screenTapGesture.state],
     //     screenTapGesture.position, screenTapGesture.direction);
     //     break;
     //     }
     
     //
     //     if (([[frame hands] count] > 0) || [[frame gestures:nil] count] > 0) {
     //         NSLog(@" ");
     //     }
     */
}


- (NSString *)stringForState:(LeapGestureState)state
{
    switch (state) {
        caseLEAP_GESTURE_STATE_INVALID:
            return@"STATE_INVALID";
        caseLEAP_GESTURE_STATE_START:
            return @"STATE_START";
        caseLEAP_GESTURE_STATE_UPDATE:
            return@"STATE_UPDATED";
        caseLEAP_GESTURE_STATE_STOP:
            return @"STATE_STOP";
        default:
            return@"STATE_INVALID";
    }
}

@end
