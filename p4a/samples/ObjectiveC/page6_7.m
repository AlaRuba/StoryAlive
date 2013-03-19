//
//  page6-7.m
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "page6_7.h"
#import "GlobalModel.h"
#import "CircleView.h"
#import "CircleView2.h"
#import "CircleView3.h"


@interface page6_7 ()
{
    LeapController *controller;
    NSMutableArray *trailArray;
    NSMutableArray *trailArray2;
    NSMutableArray *trailArray3;
    int maxImagesInTrail;
    int currentImageIndex;
    int oldX1;
    int oldY1;
    int oldX2;
    int oldY2;
    int oldX3;
    int oldY3;
    double alpha;
}
@property (nonatomic, strong) NSImageView *testImageView;
@property (nonatomic, strong) NSImageView *testImageView2;
@property (nonatomic, strong) NSImageView *testImageView3;


@end

@implementation page6_7
@synthesize page6_7_cricket;
@synthesize page6_7_ellery;
@synthesize page6_7_ellery_light;
@synthesize page6_7_franny;
@synthesize page6_7_josie;
@synthesize page6_7_josie_light;
@synthesize page6_7_martin;
@synthesize page6_7_martin_light;
@synthesize testImageView;
@synthesize testImageView2;
@synthesize testImageView3;
@synthesize sound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    NSLog(@"Initialized");
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page6_7_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
    
    NSRect rect = NSMakeRect(110, 110, 202, 203);
    testImageView = [[NSImageView alloc] initWithFrame:rect];
    [testImageView setImage: [NSImage imageNamed:@"page6_7_josie"]];
    [self.view addSubview: testImageView];
    
    [page6_7_josie setHidden:YES];
    [page6_7_josie_light setHidden:YES];
    
    testImageView2 = [[NSImageView alloc] initWithFrame:rect];
    [testImageView2 setImage: [NSImage imageNamed:@"page6_7_ellery"]];
    [self.view addSubview: testImageView2];
    [page6_7_ellery setHidden:YES];
    [page6_7_ellery_light setHidden:YES];
    [page6_7_martin setHidden:YES];
    [page6_7_martin_light setHidden:YES];
    testImageView3 = [[NSImageView alloc] initWithFrame:rect];
    [testImageView3 setImage: [NSImage imageNamed:@"page6_7_martin"]];
    [self.view addSubview: testImageView3];
    
    
    [self createImageArray];
    [self createImageArray2];
    [self createImageArray3];
    
    oldX1 = -1;;
    oldY1 = -1;
    oldX2 = -1;
    oldY2 = -1;
    oldX3 = -1;
    oldY3 = -1;
    alpha = 0.9;
    
    [self run];
    
}

- (void)actualViewDidAppear {
    NSLog(@"Initialized");
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page6_7_voice" ofType:@"m4a"] byReference:NO];
    [model.sound play];
    
    NSRect rect = NSMakeRect(110, 110, 202, 203);
    testImageView = [[NSImageView alloc] initWithFrame:rect];
    [testImageView setImage: [NSImage imageNamed:@"page6_7_josie"]];
    [self.view addSubview: testImageView];
    
    [page6_7_josie setHidden:YES];
    [page6_7_josie_light setHidden:YES];
    
    testImageView2 = [[NSImageView alloc] initWithFrame:rect];
    [testImageView2 setImage: [NSImage imageNamed:@"page6_7_ellery"]];
    [self.view addSubview: testImageView2];
    [page6_7_ellery setHidden:YES];
    [page6_7_ellery_light setHidden:YES];
    [page6_7_martin setHidden:YES];
    [page6_7_martin_light setHidden:YES];
    testImageView3 = [[NSImageView alloc] initWithFrame:rect];
    [testImageView3 setImage: [NSImage imageNamed:@"page6_7_martin"]];
    [self.view addSubview: testImageView3];

    
    [self createImageArray];
    [self createImageArray2];
    [self createImageArray3];
    
    oldX1 = -1;;
    oldY1 = -1;
    oldX2 = -1;
    oldY2 = -1;
    oldX3 = -1;
    oldY3 = -1;
    alpha = 0.9;
    
    [self run];
}

- (void)run
{
    controller = [[LeapController alloc] init];
    [controller addListener:self];
    NSLog(@"running");
}

- (void)createImageArray
{
    maxImagesInTrail = 100;
    currentImageIndex = 0;
    trailArray = [[NSMutableArray alloc] initWithCapacity:maxImagesInTrail];
    for (int i = 0; i < maxImagesInTrail; i++) {
        //        NSRect rect = NSMakeRect(110, 110, 202, 203);
        //        NSImageView *imageView = [[NSImageView alloc] initWithFrame:rect];
        //        [imageView setImage: [NSImage imageNamed:@"page1_2_sun"]];
        //        [self.view addSubview: imageView];
        int testNum = rand() % 100;
        CircleView *circle = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, testNum, testNum)];
        NSUInteger randomOpacityInt = (random() % 50 + 20 );
        CGFloat opacityScale = (CGFloat)randomOpacityInt / 100.0;
        circle.color = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:opacityScale];
        circle.stroke = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:opacityScale];
        circle.dimensions = testNum;
        [self.view addSubview:circle];
        [trailArray addObject:circle];
    }
}

- (void)createImageArray2
{
    maxImagesInTrail = 100;
    currentImageIndex = 0;
    trailArray2 = [[NSMutableArray alloc] initWithCapacity:maxImagesInTrail];
    for (int i = 0; i < maxImagesInTrail; i++) {
        //        NSRect rect = NSMakeRect(110, 110, 202, 203);
        //        NSImageView *imageView = [[NSImageView alloc] initWithFrame:rect];
        //        [imageView setImage: [NSImage imageNamed:@"page1_2_sun"]];
        //        [self.view addSubview: imageView];
        int testNum = rand() % 100;
        CGFloat red, green, blue;
        
        NSInteger colorInt = (random() % 2);
        if (colorInt == 0) {
            red   = 171.0 / 255.0;
            green = 0.0 / 255.0;
            blue  = 255.0 / 255.0;
        } else {
            red   = 47.0 / 255.0;
            green = 144.0 / 255.0;
            blue  = 255.0 / 255.0;
        }
        NSUInteger randomOpacityInt = (random() % 30 + 1 );
        CGFloat opacityScale = (CGFloat)randomOpacityInt / 100.0;
        CircleView *circle2 = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, testNum, testNum)];
        circle2.color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:opacityScale];
        circle2.stroke = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:opacityScale];
        circle2.dimensions = testNum;
        
        [self.view addSubview:circle2];
        [trailArray2 addObject:circle2];
    }
}

-(void)createImageArray3
{
    maxImagesInTrail = 150;
    currentImageIndex = 0;
    trailArray3 = [[NSMutableArray alloc] initWithCapacity:maxImagesInTrail];
    for (int i = 0; i < maxImagesInTrail; i++) {
        //        NSRect rect = NSMakeRect(110, 110, 202, 203);
        //        NSImageView *imageView = [[NSImageView alloc] initWithFrame:rect];
        //        [imageView setImage: [NSImage imageNamed:@"page1_2_sun"]];
        //        [self.view addSubview: imageView];
        CircleView *circle3 = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        circle3.color = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:0.5];
        circle3.stroke = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.5];
        circle3.dimensions = 15;
        [self.view addSubview:circle3];
        [trailArray3 addObject:circle3];
    }
}

- (void)goToNextPage;
{
    NSLog(@"Exited");
    [sound stop];
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

- (void)createSun2:(NSArray *)point
{
    if (currentImageIndex >= trailArray.count) {
        currentImageIndex = 0;
    }
    NSPoint pt = NSMakePoint([[point objectAtIndex:0] floatValue], [[point objectAtIndex:1] floatValue]);
    CircleView2 *imageView = [trailArray2 objectAtIndex:currentImageIndex];
    [imageView setHidden:NO];
    [imageView setFrameOrigin:pt];
    currentImageIndex++;
    //[imageView.layer addAnimation:[self opacityAnimation] forKey:@"opacityPath"];
    [self performSelector:@selector(removeSun:) withObject:imageView afterDelay:1];
}

- (void)createSun3:(NSArray *)point
{
    if (currentImageIndex >= trailArray.count) {
        currentImageIndex = 0;
    }
    NSPoint pt = NSMakePoint([[point objectAtIndex:0] floatValue], [[point objectAtIndex:1] floatValue]);
    CircleView3 *imageView = [trailArray3 objectAtIndex:currentImageIndex];
    [imageView setHidden:NO];
    [imageView setFrameOrigin:pt];
    currentImageIndex++;
    //[imageView.layer addAnimation:[self opacityAnimation] forKey:@"opacityPath"];
    [self performSelector:@selector(removeSun:) withObject:imageView afterDelay:1];
}

- (void)removeSun:(CircleView *)sun
{
    [sun setHidden:YES];
}


#pragma mark - SampleListener Callbacks

- (void)onInit:(NSNotification *)notification
{
    NSLog(@"Initialized");
}

- (void)onConnect:(NSNotification *)notification;
{
    NSLog(@"Connected");
    //LeapController *aController = (LeapController *)[notification object];
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
    
    if([frame pointables].count > 0 )
    {
        NSLog(@"one finger");
        [page6_7_josie setHidden:YES];
        [page6_7_josie_light setHidden:YES];
        [testImageView setHidden:NO];
        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable = [[frame pointables] objectAtIndex:0];
        
        LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:1];
        int xPixel = (int)(normalizedCoordinates.x * [screen widthPixels]);
        int yPixel = (int)(normalizedCoordinates.y * [screen heightPixels]); //screen heightPixels] -
        if (oldX1 < 0) {
            oldX1 = xPixel;
        }
        if (oldY1 < 0) {
            oldY1 = yPixel;
        }
        
        xPixel = alpha * oldX1 + (1-alpha)*xPixel;
        yPixel = alpha * oldY1 + (1-alpha)*yPixel;
        //NSLog(@"HERE");
        [testImageView setFrameOrigin:NSMakePoint(xPixel, yPixel)];
        //     [cursor setFrameOrigin:];
        NSNumber *p1 = [NSNumber numberWithInt:xPixel];
        NSNumber *p2 = [NSNumber numberWithInt:yPixel];
        
        [self performSelector:@selector(createSun:) withObject:[[NSArray alloc] initWithObjects:p1,p2, nil] afterDelay:0];
       // [self updateTrail];
        oldX1 = xPixel;
        oldY1 = yPixel;
    }
    else {
        [testImageView setHidden:NO];
    }
    if([frame pointables].count > 1) {
        NSLog(@"two finger");
        [testImageView2 setHidden:NO];

        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable = [[frame pointables] objectAtIndex:1];
        
        LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:1];
        
        int xPixel = (int)(normalizedCoordinates.x * [screen widthPixels]);
        int yPixel = (int)(normalizedCoordinates.y * [screen heightPixels]); //screen heightPixels] -
        //NSLog(@"HERE");
        if (oldX2 < 0) {
            oldX2 = xPixel;
        }
        if (oldY2 < 0) {
            oldY2 = yPixel;
        }
        
        xPixel = alpha * oldX2 + (1-alpha)*xPixel;
        yPixel = alpha * oldY2 + (1-alpha)*yPixel;
        [testImageView2 setFrameOrigin:NSMakePoint(xPixel, yPixel)];
        //     [cursor setFrameOrigin:];
        NSNumber *p1 = [NSNumber numberWithInt:xPixel];
        NSNumber *p2 = [NSNumber numberWithInt:yPixel];
        
        [self performSelector:@selector(createSun2:) withObject:[[NSArray alloc] initWithObjects:p1,p2, nil] afterDelay:0];
        //[self updateTrail:];
        oldX2 = xPixel;
        oldY2 = yPixel;
    }
    else {
        [testImageView2 setHidden:NO];
        
    }
    
    if([frame pointables].count > 2) {
        NSLog(@"three finger");
        [page6_7_martin setHidden:YES];
        [testImageView3 setHidden:NO];
        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable = [[frame pointables] objectAtIndex:2];
        
        LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:1];
        int xPixel = (int)(normalizedCoordinates.x * [screen widthPixels]);
        int yPixel = (int)(normalizedCoordinates.y * [screen heightPixels]); //screen heightPixels] -
        //NSLog(@"HERE");
        if (oldX3 < 0) {
            oldX3 = xPixel;
        }
        if (oldY3 < 0) {
            oldY3 = yPixel;
        }
        
        xPixel = alpha * oldX3 + (1-alpha)*xPixel;
        yPixel = alpha * oldY3 + (1-alpha)*yPixel;
        [testImageView3 setFrameOrigin:NSMakePoint(xPixel, yPixel)];
        //     [cursor setFrameOrigin:];
        NSNumber *p1 = [NSNumber numberWithInt:xPixel];
        NSNumber *p2 = [NSNumber numberWithInt:yPixel];
        
        [self performSelector:@selector(createSun3:) withObject:[[NSArray alloc] initWithObjects:p1,p2, nil] afterDelay:0];
        //[self updateTrail:];
        oldX3 = xPixel;
        oldY3 = yPixel;
    }
    else {
        [testImageView3 setHidden:YES];
        
    }
}




@end
