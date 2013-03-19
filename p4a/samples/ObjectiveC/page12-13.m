//
//  page12-13.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page12-13.h"
#import "GlobalModel.h"

@interface page12_13 ()
{
    LeapController *controller;
    BOOL touchingCoin;
    BOOL touchingRing;
    BOOL touchingTopFirefly;
    BOOL touchingBottomFirefly;
}
@end

@implementation page12_13

@synthesize page12_13_bottom_2;
@synthesize page12_13_bottom_3;
@synthesize page12_13_bottom_4;
@synthesize page12_13_top_2;
@synthesize page12_13_top_3;
@synthesize cursor;
@synthesize coin;
@synthesize ring;
@synthesize topFirefly;
@synthesize bottomFirefly;
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
    [page12_13_top_2 setHidden:YES];
    [page12_13_top_3 setHidden:YES];
    [page12_13_bottom_2 setHidden:YES];
    [page12_13_bottom_3 setHidden:YES];
    [page12_13_bottom_4 setHidden:YES];
    [coin setHidden:YES];
    [ring setHidden:YES];
}

//loadView is declared in NSViewController, but awakeFromNib would work also
//this is preferred to doing things in initWithNibName:bundle: because
//views are loaded lazily, so you don't need to go loading the other nibs
//until your own nib has actually been loaded.
- (void)actualViewDidAppear
{
    [coin setHidden:NO];
    [ring setHidden:NO];
    [coin start];
    [ring start];

    NSLog(@"Initialized");
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page12_13_voice" ofType:@"m4a"] byReference:NO];
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
    [page12_13_top_2 setHidden:NO];
    [self performSelector:@selector(topProgression1) withObject:nil afterDelay:delay];
}

- (void)topProgression1
{
    [page12_13_top_3 setHidden:NO];
}

- (void)bottomProgression
{
    [page12_13_bottom_2 setHidden:NO];
    [self performSelector:@selector(bottomProgression1) withObject:nil afterDelay:delay];
}

- (void)bottomProgression1
{
    [page12_13_bottom_3 setHidden:NO];
    [self performSelector:@selector(bottomProgression2) withObject:nil afterDelay:delay];
}

- (void)bottomProgression2
{
    [page12_13_bottom_4 setHidden:NO];
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
        //        [cursor setNeedsDisplay:YES];
        if (!touchingTopFirefly) {
            if (touchingRing) {
                [ring setFrameOrigin:NSMakePoint(xPixel - 50, yPixel - 50)];
                
                NSRect topFireflyRect = NSMakeRect(0, 500, 300, 400);
                touchingTopFirefly = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),topFireflyRect);
                if (touchingTopFirefly) {
                    // Bottom and top are reversed
                    [topFirefly setImage:[NSImage imageNamed:@"page12_13_top_1.png"]];
                    [ring setHidden:YES];
                    [self performSelector:@selector(topProgression) withObject:nil afterDelay:delay];
                }
                // Handle case for touching ring
                
            } else {
                NSRect coinRect = NSMakeRect(1130, 900, 146, 146);
                touchingRing = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+210),coinRect);
            }
        }
        
        if (!touchingBottomFirefly) {
            if (touchingCoin) {
                [coin setFrameOrigin:NSMakePoint(xPixel - 50, yPixel - 50)];
                
                NSRect bottomFireflyRect = NSMakeRect(0, 0, 300, 340);
                touchingBottomFirefly = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),bottomFireflyRect);
                if (touchingBottomFirefly) {
                    // Bottom and top are reversed
                    [bottomFirefly setImage:[NSImage imageNamed:@"page12_13_bottom_1.png"]];
                    [coin setHidden:YES];
                    [self performSelector:@selector(bottomProgression) withObject:nil afterDelay:delay];
                }
                // Handle case for touching ring
                
            } else {
                NSRect ringRect = NSMakeRect(1130, 300, 146, 146);
                touchingCoin = NSPointInRect(NSMakePoint(xPixel + 50, yPixel+140),ringRect);
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

