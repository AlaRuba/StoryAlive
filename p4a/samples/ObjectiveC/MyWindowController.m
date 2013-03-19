

#import "MyWindowController.h"
#import "page1_2.h"
#import "page3_4.h"
#import "page5.h"
#import "page6_7.h"
#import "page8_9.h"
#import "page10_11.h"
#import "page12-13.h"
#import "page14-15.h"
#import "page16-17.h"
#import "page18_19.h"
#import "page20_21.h"
#import "page22_23.h"
#import "page24_25.h"
#import "page26_27.h"
#import "page28_29.h"
#import "page30_31.h"
#import "page32.h"
#import "GlobalModel.h"
#import <QuartzCore/QuartzCore.h>
#import <dispatch/dispatch.h>
#import "PageViewController.h"

@implementation MyWindowController
{
    LeapController *controller;
    int currentPage;
    NSArray *vcArray;
    BOOL paging;
    BOOL dragInProcess;
    NSPoint prevLocation;
    NSPoint mouseLoc;
    int limiter;
    BOOL animationInProgress;
    BOOL isInNextPageCurl;

    BOOL touchingCricket1;
    BOOL touchedCricket1;
    BOOL touchingFranny8;
    BOOL touchedFranny8;
    BOOL touchingCricket26;
    BOOL touchedCricket26;
    BOOL touchingFranny26;
    BOOL touchedFranny26;
}
enum	// popup tag choices
{
	kImageView = 0,
	kTableView,
	kVideoView,
	kPage1View
};

NSString *const kViewTitle		= @"CustomImageView";
NSString *const kTableTitle		= @"CustomTableView";
NSString *const kVideoTitle		= @"CustomVideoView";
NSString *const kPage1Title	    = @"Page1ViewController";

@synthesize cursor;


@synthesize imageView;

@synthesize viewOverPage;
@synthesize viewUnderPage;

@synthesize inputShadingImage;
@synthesize sourceImage;
@synthesize targetImage;
@synthesize backsideImage;

@synthesize pageCurlFilter;

@synthesize stopValue;
@synthesize stopAngle;

@synthesize delegate;

- (IBAction)nextPage:(id)sender
{
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    NSLog(@"Next Page Pressed");
    [self goToNextPage];
}

- (void)goToNextPage
{
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    currentPage++;
    if (currentPage >= vcArray.count) {
        currentPage = (int)vcArray.count;
        
        [self.viewUnderPage removeFromSuperview];
        [self.viewOverPage removeFromSuperview];
        
        self.viewUnderPage = ((NSViewController *)[vcArray objectAtIndex:vcArray.count-1]).view;
        self.viewOverPage = ((NSViewController *)[vcArray objectAtIndex:vcArray.count-1]).view;

        [[self viewOverPage] setFrame:[[self imageView] frame]];
        [[self viewUnderPage] setFrame:[[self imageView] frame]];
        
        [self placeSubview:[self viewUnderPage] underView:[self imageView]];
        [self placeSubview:[self viewOverPage] overView:[self imageView]];
        
        return;
    }
    
    // we are about to change the current view controller,
	// this prepares our title's value binding to change with it
	[self willChangeValueForKey:@"viewController"];
	
	if ([myCurrentViewController view] != nil)
		[[myCurrentViewController view] removeFromSuperview];	// remove the current view
    
	//if (myCurrentViewController != nil)
	//	[myCurrentViewController release];		// remove the current view controller
    NSViewController *vc = [vcArray objectAtIndex:currentPage];
    // page1_2* pageOneViewController = [[page1_2 alloc] initWithNibName:@"page1_2" bundle:nil];
    if (vc != nil)
    {
        myCurrentViewController = vc;	// keep track of the current view controller
        //[myCurrentViewController setTitle:@"page1_2"];
    }
    NSLog(@"Current Page %d",currentPage);
    
    PageViewController *pvc = [vcArray objectAtIndex:currentPage];
    [pvc actualViewDidAppear];
    
    [self.viewUnderPage removeFromSuperview];
    [self.viewOverPage removeFromSuperview];
    
    self.viewOverPage = ((NSViewController *)[vcArray objectAtIndex:currentPage]).view;
    if (currentPage < vcArray.count - 1) {
        self.viewUnderPage = ((NSViewController *)[vcArray objectAtIndex:currentPage + 1]).view;
        NSLog(@"%@",[vcArray objectAtIndex:currentPage + 1]);
        NSLog(@"%@",self.viewUnderPage);
        [[self viewOverPage] setFrame:[[self imageView] frame]];
        [[self viewUnderPage] setFrame:[[self imageView] frame]];
        
        [self placeSubview:[self viewUnderPage] underView:[self imageView]];
        [self placeSubview:[self viewOverPage] overView:[self imageView]];
        //NSLog(@"[[self imageView] frame] %f %f %f %f",[[self imageView] frame].origin.x,[[self imageView] frame].origin.y,[[self imageView] frame].size.width,[[self imageView] frame].size.height);
        [[self viewOverPage] setFrame:[[self imageView] frame]];
        [[self viewUnderPage] setFrame:[[self imageView] frame]];
        [self imageView:[self imageView] didChangeFrame:[[self imageView] frame]];
    }

    _lastDirection = 0;
    _currentAngle = 0;
    _currentTime = 0;

    animationInProgress = NO;
    dragInProcess = NO;
}

- (void)goToPrevPage
{
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    currentPage--;
    if (currentPage < 1) {
        currentPage = 0;
        return;
    }

    
    // we are about to change the current view controller,
	// this prepares our title's value binding to change with it
	[self willChangeValueForKey:@"viewController"];
	
	if ([myCurrentViewController view] != nil)
		[[myCurrentViewController view] removeFromSuperview];	// remove the current view
    
	//if (myCurrentViewController != nil)
	//	[myCurrentViewController release];		// remove the current view controller
    NSViewController *vc = [vcArray objectAtIndex:currentPage];
    // page1_2* pageOneViewController = [[page1_2 alloc] initWithNibName:@"page1_2" bundle:nil];
    if (vc != nil)
    {
        myCurrentViewController = vc;	// keep track of the current view controller
        //[myCurrentViewController setTitle:@"page1_2"];
    }
    NSLog(@"Current Page %d",currentPage);
    
    PageViewController *pvc = [vcArray objectAtIndex:currentPage];
    [pvc actualViewDidAppear];
    
    [self.viewUnderPage removeFromSuperview];
    [self.viewOverPage removeFromSuperview];
    
    self.viewOverPage = ((NSViewController *)[vcArray objectAtIndex:currentPage]).view;
    if (currentPage < vcArray.count - 1) {
        self.viewUnderPage = ((NSViewController *)[vcArray objectAtIndex:currentPage - 1]).view;
        NSLog(@"%@",[vcArray objectAtIndex:currentPage + 1]);
        NSLog(@"%@",self.viewUnderPage);
        [[self viewOverPage] setFrame:[[self imageView] frame]];
        [[self viewUnderPage] setFrame:[[self imageView] frame]];
        
        [self placeSubview:[self viewUnderPage] underView:[self imageView]];
        [self placeSubview:[self viewOverPage] overView:[self imageView]];
        //NSLog(@"[[self imageView] frame] %f %f %f %f",[[self imageView] frame].origin.x,[[self imageView] frame].origin.y,[[self imageView] frame].size.width,[[self imageView] frame].size.height);
        [[self viewOverPage] setFrame:[[self imageView] frame]];
        [[self viewUnderPage] setFrame:[[self imageView] frame]];
        [self imageView:[self imageView] didChangeFrame:[[self imageView] frame]];
    }
    
    _lastDirection = 0;
    _currentAngle = 0;
    _currentTime = 0;
    
    animationInProgress = NO;
    dragInProcess = NO;
    
    
    
    /*
    // we are about to change the current view controller,
	// this prepares our title's value binding to change with it
	[self willChangeValueForKey:@"viewController"];
	
	if ([myCurrentViewController view] != nil)
		[[myCurrentViewController view] removeFromSuperview];	// remove the current view
    
	//if (myCurrentViewController != nil)
	//	[myCurrentViewController release];		// remove the current view controller
    NSViewController *vc = [vcArray objectAtIndex:currentPage];
    // page1_2* pageOneViewController = [[page1_2 alloc] initWithNibName:@"page1_2" bundle:nil];
    if (vc != nil)
    {
        myCurrentViewController = vc;	// keep track of the current view controller
        //[myCurrentViewController setTitle:@"page1_2"];
    }
    
	
	// embed the current view to our host view
	[myTargetView addSubview: [myCurrentViewController view]];
	
	// make sure we automatically resize the controller's view to the current window size
	[[myCurrentViewController view] setFrame: [myTargetView bounds]];
	
	// set the view controller's represented object to the number of subviews in that controller
	// (our NSTextField's value binding will reflect this value)
    //	[myCurrentViewController setRepresentedObject: [NSNumber numberWithUnsignedInt: [[[myCurrentViewController view] subviews] count]]];
	
	[self didChangeValueForKey:@"viewController"];	// this will trigger the NSTextField's value binding to change
*/
}

- (IBAction)prevPage:(id)sender
{
    GlobalModel *model = [GlobalModel sharedGlobalModel];
    [model.sound pause];
    [self goToPrevPage];
}

- (IBAction)firstPage
{
    
}

// -------------------------------------------------------------------------------
//	initWithPath:newPath
// -------------------------------------------------------------------------------
- initWithPath:(NSString *)newPath
{
    return [super initWithWindowNibName:@"TestWindow"];
}

// -------------------------------------------------------------------------------
//	changeViewController:whichViewTag
//
//	Change the current NSViewController to a new one based on a tag obtained from
//	the NSPopupButton control.
// -------------------------------------------------------------------------------
- (void)changeViewController:(NSInteger)whichViewTag
{

}

// -------------------------------------------------------------------------------
//	awakeFromNib:
// -------------------------------------------------------------------------------
- (void)awakeFromNib
{
    currentPage = 0;

    controller = [[LeapController alloc] init];
    [controller addListener:self];
    
    vcArray = [[NSArray alloc] initWithObjects:
               //[[page1_2 alloc] initWithNibName:@"page_tutorial" bundle:nil],
               [[page1_2 alloc] initWithNibName:@"page1_2" bundle:nil],
               [[page3_4 alloc] initWithNibName:@"page3_4" bundle:nil],
               [[page5 alloc] initWithNibName:@"page5" bundle:nil],
               [[page6_7 alloc] initWithNibName:@"page6_7" bundle:nil],
               [[page8_9 alloc] initWithNibName:@"page8_9" bundle:nil],
               [[page10_11 alloc] initWithNibName:@"page10_11" bundle:nil],
               [[page12_13 alloc] initWithNibName:@"page12-13" bundle:nil],
               [[page14_15 alloc] initWithNibName:@"page14-15" bundle:nil],
               [[page16_17 alloc] initWithNibName:@"page16-17" bundle:nil],
               [[page18_19 alloc] initWithNibName:@"page18_19" bundle:nil],
               [[page20_21 alloc] initWithNibName:@"page20_21" bundle:nil],
               [[page22_23 alloc] initWithNibName:@"page22_23" bundle:nil],
               [[page24_25 alloc] initWithNibName:@"page24_25" bundle:nil],
               [[page26_27 alloc] initWithNibName:@"page26_27" bundle:nil],
               [[page28_29 alloc] initWithNibName:@"page28_29" bundle:nil],
               [[page30_31 alloc] initWithNibName:@"page30_31" bundle:nil],
               [[page32 alloc] initWithNibName:@"page32" bundle:nil], nil];
    
    // we are about to change the current view controller,
	// this prepares our title's value binding to change with it
	[self willChangeValueForKey:@"viewController"];
	
	if ([myCurrentViewController view] != nil)
		[[myCurrentViewController view] removeFromSuperview];	// remove the current view
    
	//if (myCurrentViewController != nil)
	//	[myCurrentViewController release];		// remove the current view controller
    NSViewController *vc = [vcArray objectAtIndex:currentPage];
    // page1_2* pageOneViewController = [[page1_2 alloc] initWithNibName:@"page1_2" bundle:nil];
    if (vc != nil)
    {
        myCurrentViewController = vc;	// keep track of the current view controller
        //[myCurrentViewController setTitle:@"page1_2"];
    }
    
	
	// embed the current view to our host view
	//[myTargetView addSubview: [myCurrentViewController view]];
	
	// make sure we automatically resize the controller's view to the current window size
	//[[myCurrentViewController view] setFrame: [myTargetView bounds]];
	
	// set the view controller's represented object to the number of subviews in that controller
	// (our NSTextField's value binding will reflect this value)
    //	[myCurrentViewController setRepresentedObject: [NSNumber numberWithUnsignedInt: [[[myCurrentViewController view] subviews] count]]];
	
	[self didChangeValueForKey:@"viewController"];	// this will trigger the NSTextField's value binding to change
    
    // From init.
    _cachedImages = [[NSMutableDictionary alloc] init];
    
    [[self imageView] setDelegate:self];
	
	stopValue = 1.0f;
	stopAngle = -0.0f;
	_currentAngle = 0.0f;
	
	NSShadow *pageFlipViewShadow = [[NSShadow alloc] init];
	[pageFlipViewShadow setShadowColor:[NSColor blackColor]];
	[pageFlipViewShadow setShadowBlurRadius:32];
	[pageFlipViewShadow setShadowOffset:NSMakeSize(0, 0)];
	[[self imageView] setShadow:pageFlipViewShadow];
	pageFlipViewShadow = nil;
    
	
	CIFilter *_curlFilter = [CIFilter filterWithName:@"CIPageCurlTransition"];
	[_curlFilter setDefaults];
	[_curlFilter setValue:[self inputShadingImage] forKey:@"inputShadingImage"];
	[_curlFilter setValue:[NSNumber numberWithFloat:3.14*3 / 4] forKey:@"inputAngle"];//M_PI_4/2.0f
	[_curlFilter setValue:[NSNumber numberWithFloat:120.0f] forKey:@"inputRadius"];
	
	[self setPageCurlFilter:_curlFilter];
	
    
    self.viewOverPage = ((NSViewController *)[vcArray objectAtIndex:0]).view;
    self.viewUnderPage = ((NSViewController *)[vcArray objectAtIndex:1]).view;

	[[self viewOverPage] setFrame:[[self imageView] frame]];
	[[self viewUnderPage] setFrame:[[self imageView] frame]];
	
	//[[self viewOverPage] setAutoresizingMask:[[self imageView] autoresizingMask]];
	//[[self viewUnderPage] setAutoresizingMask:[[self imageView] autoresizingMask]];
	
	[self placeSubview:[self viewUnderPage] underView:[self imageView]];
	[self placeSubview:[self viewOverPage] overView:[self imageView]];
	
	[self imageView:[self imageView] didChangeFrame:[[self imageView] frame]];
    
    NSLog(@"[[self imageView] frame] %f %f %f %f",[[self imageView] frame].origin.x,[[self imageView] frame].origin.y,[[self imageView] frame].size.width,[[self imageView] frame].size.height);

    
   // [self.imageView addSubview:cursor];
}

// -------------------------------------------------------------------------------
//	viewChoicePopupAction
// -------------------------------------------------------------------------------
- (IBAction)viewChoicePopupAction:(id)sender
{
	[self changeViewController: [[sender selectedCell] tag]];
}

// -------------------------------------------------------------------------------
//	viewController
// -------------------------------------------------------------------------------
- (NSViewController*)viewController
{
	return myCurrentViewController;
}

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
    LeapController *aController = (LeapController *)[notification object];
    LeapFrame *frame = [aController frame:0];
    
    if([frame pointables].count > 0 )
    {
        NSArray *screens = aController.calibratedScreens;
        LeapScreen *screen = [screens objectAtIndex:0];
        LeapPointable *pointable = [[frame pointables] objectAtIndex:0];
        
        LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:1];
        int xPixel = (int)(normalizedCoordinates.x * [screen widthPixels]);
        int yPixel = (int)(normalizedCoordinates.y * [screen heightPixels]);
        
        [cursor setFrameOrigin:NSMakePoint(xPixel, yPixel)];
        GlobalModel *model = [GlobalModel sharedGlobalModel];
        
        
        if (currentPage == 0 && !touchedCricket1 && ![model.sound isPlaying]) {
            touchingCricket1 = NSPointInRect(NSMakePoint(xPixel + 50, yPixel + 140), NSMakeRect(250, 100, 150, 100));
            if (touchingCricket1) {
                [model.sound pause];
                model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cricket" ofType:@"mp3"] byReference:NO];
                [model.sound play];
                touchingCricket1 = NO;
                touchedCricket1 = YES;
            }
        } else if (currentPage == 12 && !touchedCricket26 && ![model.sound isPlaying]) {
            touchingCricket26 = NSPointInRect(NSMakePoint(xPixel+50, yPixel+140), NSMakeRect(345, 160, 300, 260));
            if (touchingCricket26) {
                [model.sound pause];
                model.sound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cricket" ofType:@"mp3"] byReference:NO];
                [model.sound play];
                touchingCricket26 = NO;
                touchedCricket26 = YES;
            }
        }        
        
        if (animationInProgress == NO) {
            if (dragInProcess == NO) {
                if (yPixel < 100) {
                    if (xPixel < 100 && currentPage > 0) {
                        isInNextPageCurl = NO;
                        NSLog(@"Should start drag LEFT");
                        prevLocation = NSMakePoint(xPixel, yPixel);
                        [self.viewUnderPage removeFromSuperview];
                        self.viewUnderPage = ((NSViewController *)[vcArray objectAtIndex:currentPage - 1]).view;
                        [[self viewUnderPage] setFrame:[[self imageView] frame]];
                        [self placeSubview:[self viewUnderPage] underView:[self imageView]];
                        [[self viewUnderPage] setFrame:[[self imageView] frame]];
                        [self imageView:imageView mouseDragDidStartAtPoint:prevLocation];
                        dragInProcess = YES;
                    } else if (xPixel > 1100 && currentPage < 18) {
                        isInNextPageCurl = YES;
                        NSLog(@"Should start drag RIGHT");
                        prevLocation = NSMakePoint(xPixel, yPixel);
                        [self.viewUnderPage removeFromSuperview];
                        self.viewUnderPage = ((NSViewController *)[vcArray objectAtIndex:currentPage + 1]).view;
                        [[self viewUnderPage] setFrame:[[self imageView] frame]];
                        [self placeSubview:[self viewUnderPage] underView:[self imageView]];
                        [[self viewUnderPage] setFrame:[[self imageView] frame]];
                        [self imageView:imageView mouseDragDidStartAtPoint:prevLocation];
                        dragInProcess = YES;
                    }
                  
                }
            } else {
                mouseLoc = NSMakePoint(xPixel, yPixel);
                
                float deltaX, deltaY;
                
                deltaX = mouseLoc.x - prevLocation.x;
                deltaY = prevLocation.y - mouseLoc.y;
                if (abs(deltaX) > 2) {
                    if (limiter == 25) {
                        prevLocation = mouseLoc;
                        NSLog(@"Leap:(%f,%f) Dx: %f Dy: %f",mouseLoc.x,mouseLoc.y,deltaX,deltaY);
                        
                        [self imageView:imageView mouseDraggedAtPoint:mouseLoc
                              direction:deltaX
                             angleDelta:deltaY];
                        limiter = 0;
                    } else {
                        limiter++;
                    }
                }
                if (isInNextPageCurl) {
                    if (mouseLoc.x < 800) {
                        animationInProgress = YES;
                        [self imageView:imageView mouseDragDidEndAtPoint:mouseLoc];
                    }
                } else {
                    if (mouseLoc.x > 400) {
                        animationInProgress = YES;
                        [self imageView:imageView mouseDragDidEndAtPoint:mouseLoc];
                    }
                }
  
            }
        }

    }
    
    if ([[frame hands] count] != 0) {
        // Get the first hand
        LeapHand *hand = [[frame hands] objectAtIndex:0];
        
        // Check if the hand has any fingers
        NSArray *fingers = [hand fingers];
        if ([fingers count] >= 1) {
            // Calculate the hand's average finger tip position
            LeapVector *avgPos = [[LeapVector alloc] init];
            for (int i = 0; i < [fingers count]; i++) {
                LeapFinger *finger = [fingers objectAtIndex:i];
                avgPos = [avgPos plus:[finger tipPosition]];
            }
            avgPos = [avgPos divide:[fingers count]];
         //   NSLog(@"Hand has %ld fingers, average finger tip position %@",
         //         [fingers count], avgPos);
            
            
            // Get the hand's sphere radius and palm position
          //  NSLog(@"Hand sphere radius: %f mm, palm position: %@",
         //         [hand sphereRadius], [hand palmPosition]);
            
            // Get the hand's normal vector and direction
            //const LeapVector *normal = [hand palmNormal];
            //const LeapVector *direction = [hand direction];
            
            // Calculate the hand's pitch, roll, and yaw angles
       //     NSLog(@"Hand pitch: %f degrees, roll: %f degrees, yaw: %f degrees\n",
           //       [direction pitch] * LEAP_RAD_TO_DEG,
           //       [normal roll] * LEAP_RAD_TO_DEG,
           //       [direction yaw] * LEAP_RAD_TO_DEG);
            
            /*
            NSArray *gestures = [frame gestures:nil];
            //for (int g = 0; g < [gestures count]; g++) {
            if ([gestures count] > 0 && paging == NO) {
                LeapGesture *gesture = [gestures objectAtIndex:0];
                if (gesture.type == LEAP_GESTURE_TYPE_SWIPE) {
                    LeapSwipeGesture *swipeGesture = (LeapSwipeGesture *)gesture;
                    NSLog(@"Swipe id: %d, %@, position: %@, direction: %@, speed: %f",
                          swipeGesture.id, [self stringForState:swipeGesture.state],
                          swipeGesture.position, swipeGesture.direction, swipeGesture.speed);
                    double magnitude = .2;
                    double pagingDelay = .4;
                    if (swipeGesture.direction.x < magnitude * -1) {
                        paging = YES;
                        [self performSelector:@selector(pagingTimeOut) withObject:nil afterDelay:pagingDelay];
                        [self goToNextPage];
                    } else if (swipeGesture.direction.x > magnitude) {
                        [self performSelector:@selector(pagingTimeOut) withObject:nil afterDelay:pagingDelay];
                        paging = YES;
                        [self goToPrevPage];
                    }
                }
            }
            */
        }
    }    
}

- (void)pagingTimeOut
{
    paging = NO;
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







#pragma mark Image Generation

- (NSImage *)transparentImageWithSize:(NSSize)size {
	NSImage *imageTransparent = [[NSImage alloc] initWithSize:size];
	[imageTransparent lockFocus];
	[NSGraphicsContext saveGraphicsState];
	[[NSColor clearColor] setFill];
	NSRectFill(NSMakeRect(0, 0, size.width, size.height));
	[NSGraphicsContext restoreGraphicsState];
	[imageTransparent unlockFocus];
	
	return imageTransparent;
}

- (NSImage *)NSImageFromCIImage:(CIImage *)ciImage {
	CGRect imageRect = [ciImage extent];
	NSImage *image = [[NSImage alloc] initWithSize:imageRect.size];
	[image lockFocus];
	CGContextRef contextRef = [[NSGraphicsContext currentContext] graphicsPort];
	CIContext *ciContext = [CIContext contextWithCGContext:contextRef options:nil];
	//[ciContext drawImage:ciImage atPoint:CGPointMake(0, 0) fromRect:[ciImage extent]];
    // CGRect tempRect = [ciImage extent];
    //  CGRect mynewRect = CGRectMake(0, 0, tempRect.size.width/2, tempRect.size.height/2);
    [ciContext drawImage:ciImage inRect:[ciImage extent] fromRect:[ciImage extent]];
	/*Does not leak when using the software renderer!*/
	[image unlockFocus];
	
	return image;
}

// Note can be + yet.
-(NSImage*) resize:(NSImage*)aImage scale:(CGFloat)aScale
{
    NSImageView* kView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, aImage.size.width * aScale, aImage.size.height* aScale)];
    [kView setImageScaling:NSImageScaleProportionallyUpOrDown];
    [kView setImage:aImage];
    
    NSRect kRect = kView.frame;
    NSBitmapImageRep* kRep = [kView bitmapImageRepForCachingDisplayInRect:kRect];
    [kView cacheDisplayInRect:kRect toBitmapImageRep:kRep];
    
    NSData* kData = [kRep representationUsingType:NSPNGFileType properties:nil];
    return [[NSImage alloc] initWithData:kData];
}

- (NSImage *)NSImageFromNSView:(NSView *)nsView {
	NSData *viewScreenshotData = [nsView dataWithPDFInsideRect:[nsView bounds]];
	NSImage *viewImage = [[NSImage alloc] initWithData:viewScreenshotData];
	//NSImage *viewImage = [self resize:viewImage2 scale:.5];
	
	NSColor *windowBackgroundColor = [[[self imageView] window] backgroundColor];
	//NSSize mySize = NSMakeSize([viewImage size].width/2, [viewImage size].height/2);
//    NSLog(@"%f %f",[viewImage size].width,[viewImage size].height);
	NSImage *drawedImage = [[NSImage alloc] initWithSize:[viewImage size]];
	[drawedImage lockFocus];
	[NSGraphicsContext saveGraphicsState];
	
	[windowBackgroundColor setFill];
	NSRectFill(NSMakeRect(0, 0, [viewImage size].width, [viewImage size].height));
	
	[viewImage drawAtPoint:NSZeroPoint
				  fromRect:NSZeroRect
				 operation:NSCompositeSourceOver
				  fraction:1.0f];
	
	[NSGraphicsContext restoreGraphicsState];
	[drawedImage unlockFocus];
	
	viewImage = nil;
    
	return drawedImage;
}

- (CIImage *)CIImageFromNSImage:(NSImage *)nsImage {
    
    
	NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithData:[nsImage TIFFRepresentation]];
    // CIImage *testImage = [CIImage alloc] initWi
	CIImage *image2 = [[CIImage alloc] initWithBitmapImageRep:bitmap];
    
    NSRect myrect = image2.extent;
    NSLog(@"%f %f",myrect.size.width,nsImage.size.width);
    CIImage * image;
    if (myrect.size.width > 1.9 * nsImage.size.width) {
        CIFilter *transform = [CIFilter filterWithName:@"CIAffineTransform"];
        [transform setValue:image2 forKey:@"inputImage"];
        
        NSAffineTransform *affineTransform = [NSAffineTransform transform];
        // [affineTransform translateXBy:0 yBy:128];
        [affineTransform scaleXBy:.5 yBy:.5];
        [transform setValue:affineTransform forKey:@"inputTransform"];
        
        image = [transform valueForKey:@"outputImage"];
    } else {
        image = image2;
    }
    
  
    
    /*
     CIFilter *f
     = [CIFilter filterWithName:@"CIAffineTransform"];
     NSAffineTransform *t = [NSAffineTransform transform];
     [t scaleBy:.5];
     //[f setValue:t forKey:@"inputTransform"];
     [f setValue:image forKey:@"inputImage"];
     image = [f valueForKey:@"outputImage"];
     */
    NSLog(@"New %f %f",image.extent.size.width,image.extent.size.height);
    return image;
	//return [image autorelease];
}

- (CIImage *)CIImageFromResource:(NSString *)resource extension:(NSString *)extension {
	NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:resource ofType:extension]];
	NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithData:imageData];
	CIImage *image = [[CIImage alloc] initWithBitmapImageRep:bitmap];
	return image;
}

- (CIImage *)CIImageFromNSView:(NSView *)nsView {
	return [self CIImageFromNSImage:[self NSImageFromNSView:nsView]];
}

#pragma mark Lazy Image

- (CIImage *)inputShadingImage {
	if (inputShadingImage == nil) {
		inputShadingImage = [self CIImageFromResource:@"restrictedshine" extension:@"tiff"];
	}
	return inputShadingImage;
}

- (CIImage *)sourceImage {
	if (sourceImage == nil) {
		sourceImage = [self CIImageFromNSView:[self viewOverPage]];
	}
	return sourceImage;
}

- (CIImage *)targetImage {
	if (targetImage == nil) {
		targetImage = [self CIImageFromNSImage:[self transparentImageWithSize:[[self imageView] bounds].size]];
	}
	return targetImage;
}

- (CIImage *)backsideImage {
	if (backsideImage == nil) {
		CIFilter *backendFilter = [CIFilter filterWithName:@"CIColorControls"];
		[backendFilter setDefaults];
		[backendFilter setValue:[self sourceImage] forKey:@"inputImage"];
		[backendFilter setValue:[NSNumber numberWithFloat:0.15] forKey:@"inputBrightness"];
		[backendFilter setValue:[NSNumber numberWithFloat:0.25] forKey:@"inputSaturation"];
		[backendFilter setValue:[NSNumber numberWithFloat:0.25] forKey:@"inputContrast"];
		CIImage *backendImage = [backendFilter valueForKey:@"outputImage"];
		
		[self setBacksideImage:backendImage];
	}
	return backsideImage;
}

#pragma mark Transition Methods

- (void)updateTransitionImageWithTime:(float)time angle:(float)angle animated:(BOOL)animated {
	float inputTimeValue = time;
	float angleMultiplier = angle;
	
	if (inputTimeValue < 0.0f)
		inputTimeValue = 0.0f;
	
	if (inputTimeValue > [self stopValue])
		inputTimeValue = [self stopValue];
	
	if (inputTimeValue > 1.0f)
		inputTimeValue = 1.0f;
	
	float currentTime = _currentTime;
	float currentAngle = _currentAngle;
	
	if ((inputTimeValue == currentTime && angleMultiplier == currentAngle) || (inputTimeValue == 0.0f && currentTime == 0.0f)) {
		[self transitionDidFinishWithTime:inputTimeValue];
		return;
	}
	
	NSInteger numberOfSteps = 7; //15
	NSLog(@"Input %f Current %f",inputTimeValue,currentTime);
    if (isInNextPageCurl) { // hack
        inputTimeValue = 1;
    }
	float timeStep = (inputTimeValue - currentTime)/numberOfSteps;
	float angleStep = (angleMultiplier - currentAngle)/numberOfSteps;
	
	[_cachedImages removeAllObjects];
	
	for (NSInteger step = 0; step < numberOfSteps; step++) {
		float newTimeValue = currentTime + timeStep*(step+1);
		float newAngleValue = currentAngle + angleStep*(step+1);
		
		NSImage *image = [self transitionImageWithTime:newTimeValue angle:newAngleValue];
		[_cachedImages setObject:image forKey:[NSNumber numberWithFloat:newTimeValue]];
		
		image = nil;
		
		dispatch_time_t pauseTime = dispatch_time(DISPATCH_TIME_NOW, 400000000 + 750000*(step+1));
		dispatch_queue_t mainQueue = dispatch_get_main_queue();
		dispatch_after(pauseTime, mainQueue, ^{
			
			float newTimeValue = currentTime + timeStep*(step+1);
			float newAngleValue = currentAngle + angleStep*(step+1);
			
			if (_isDragging == NO) {
				[self updateTransitionImageWithTime:newTimeValue angle:newAngleValue];
			}
			
			if (newTimeValue == 0.0f || newTimeValue == [self stopValue] || newTimeValue == 1.0f) {
				[self transitionDidFinishWithTime:newTimeValue];
			}
		});
	}
	
	_lastDirection = 0;
}

- (NSImage *)transitionImageWithTime:(float)time angle:(float)angle {
	float angleMultiplier = angle;
	float inputTimeValue = time;
	
	NSRect rect = [imageView bounds];
	//NSLog(@"Rect %f %f",rect.size.width,rect.size.height);
	_currentTime = time;
	_currentAngle = angle;
	
	[[self pageCurlFilter] setValue:[NSNumber numberWithFloat:inputTimeValue] forKey:@"inputTime"];
    float curlAngle;
    if (isInNextPageCurl) {
        curlAngle = (3.14 * 3 / 4);
    } else {
        curlAngle = (angleMultiplier * M_PI_4 * (1 - time*0.75));
    }
    NSLog(@"Time %f",time);
	[[self pageCurlFilter] setValue:[NSNumber numberWithFloat:curlAngle] forKey:@"inputAngle"];
	[[self pageCurlFilter] setValue:[NSNumber numberWithFloat:(0.1f + 150.0f*time)] forKey:@"inputRadius"];
    //NSLog(@"%@ %@ %@",[self backsideImage],[self sourceImage],[self targetImage] );
	[[self pageCurlFilter] setValue:[self backsideImage] forKey:@"inputBacksideImage"];
	[[self pageCurlFilter] setValue:[self sourceImage] forKey:@"inputImage"];
	[[self pageCurlFilter] setValue:[self targetImage] forKey:@"inputTargetImage"];
	
	CIImage *outputImage = [[self pageCurlFilter] valueForKey:@"outputImage"];
	
	// CICurl
	
	CIVector *imageExtent = [CIVector vectorWithX:rect.origin.x Y:rect.origin.y Z:rect.size.width W:rect.size.height];
	CIFilter *cropTransition = [CIFilter filterWithName: @"CICrop"];
	[cropTransition setValue:outputImage forKey: @"inputImage"];
	[cropTransition setValue:imageExtent forKey: @"inputRectangle"];
	CIImage *outputCroppedImage = [cropTransition valueForKey:@"outputImage"];
	
	NSImage *image = [self NSImageFromCIImage:outputCroppedImage];
	return image;
}

- (void)updateTransitionImageWithTime:(float)time angle:(float)angle {
	
	NSImage *image = [_cachedImages objectForKey:[NSNumber numberWithFloat:time]];
	
	if (image == nil) {
		image = [self transitionImageWithTime:time angle:angle];
	}
	else {
		//[[image retain] autorelease];
	}
	
	[[self imageView] setImage:image];
}

- (void)transitionDidFinishWithTime:(float)time {
	
	[_cachedImages removeAllObjects];
	
	if (time == 0.0f) {
		// page is "closed"
		// viewOverPage is visible, viewUnderPage is hidden
		
		if ([[self viewUnderPage] superview] != nil) {
			[self removeSubview:[self viewUnderPage]];
		}
		
		if ([[self viewOverPage] superview] == nil) {
			[self placeSubview:[self viewOverPage] overView:[self imageView]];
		}
		
		if ([[self imageView] image] != nil) {
			[[self imageView] setImage:nil];
		}
	}
	else if (time == 1.0f || time == [self stopValue]) {
		// page is "opened"
		// viewOverPage is hidden, viewUnderPage is visible
		
		if ([[self viewOverPage] superview] != nil) {
			[self removeSubview:[self viewOverPage]];
		}
		
		if ([[self viewUnderPage] superview] == nil) {
			[self placeSubview:[self viewUnderPage] underView:[self imageView]];
		}
	}
    
	[self setSourceImage:nil];
    
    // Restart for Next page
    animationInProgress = NO;
    if (isInNextPageCurl) {
        [self goToNextPage];

    } else {
        [self goToPrevPage];
    }
}

- (void)removeSubview:(NSView *)subview {
	[subview removeFromSuperview];
}

- (void)placeSubview:(NSView *)subview overView:(NSView *)underView {
	[[underView superview] addSubview:subview
						   positioned:NSWindowAbove
						   relativeTo:underView];
}

- (void)placeSubview:(NSView *)subview underView:(NSView *)underView {
	[[underView superview] addSubview:subview
						   positioned:NSWindowBelow
						   relativeTo:underView];
}

#pragma mark Delegate methods

- (void)imageView:(BFImageView *)anImageView didChangeFrame:(NSRect)frameRect {
	[[self viewOverPage] setFrame:frameRect];
	[[self viewUnderPage] setFrame:frameRect];
	
	// update filter "effect zone"
	[[self pageCurlFilter] setValue:[CIVector vectorWithX:frameRect.origin.x
														Y:frameRect.origin.y
														Z:frameRect.size.width
														W:frameRect.size.height]
							 forKey:@"inputExtent"];
	
	// update source view image
	[self setSourceImage:nil];
	[[self pageCurlFilter] setValue:[self sourceImage]
							 forKey:@"inputImage"];
	
	// destination (transparent) image
	[self setTargetImage:nil];
	[[self pageCurlFilter] setValue:[self targetImage]
							 forKey:@"inputTargetImage"];
	
	// backside image
	[self setBacksideImage:nil];
	[[self pageCurlFilter] setValue:[self backsideImage]
							 forKey:@"inputBacksideImage"];
	
	//apply filter
	
	if ([[self imageView] image] != nil) {
		[self updateTransitionImageWithTime:_currentTime angle:_currentAngle];
	}
}

- (BOOL)imageView:(BFImageView *)anImageView shouldCaptureEvent:(NSEvent *)theEvent atPoint:(NSPoint)aPoint {
    if (aPoint.x < 100) {
        isInNextPageCurl = NO;
    } else if (aPoint.x > 1000) {
        isInNextPageCurl = YES;
    }
	/*
    NSLog(@"HERE");
	NSImage *image = [anImageView image];
	NSColor *theColor;
	[image lockFocus];
	theColor = NSReadPixel(aPoint);
	[image unlockFocus];
	
	if ([theColor alphaComponent] == 0.0f) {
		return NO;
	}
	*/
	return YES;
}
 

- (void)imageView:(BFImageView *)anImageView mouseDragDidStartAtPoint:(NSPoint)point {
	[self updateTransitionImageWithTime:_currentTime angle:_currentAngle];
	
	if ([[self viewOverPage] superview] != nil) {
		[self removeSubview:[self viewOverPage]];
	}
	
	if ([[self viewUnderPage] superview] == nil) {
		[self placeSubview:[self viewUnderPage] underView:[self imageView]];
	}
}

- (void)imageView:(BFImageView *)anImageView mouseDraggedAtPoint:(NSPoint)point direction:(float)direction angleDelta:(float)angleDelta {
	_lastDirection = direction;
    float inputTimeValue;
    if (isInNextPageCurl) {
        inputTimeValue = _currentTime - direction / anImageView.bounds.size.width;
    } else {
        inputTimeValue = _currentTime + direction / anImageView.bounds.size.width;
    }
    NSLog(@"inputTimeValue %f",inputTimeValue);

    
	if (inputTimeValue < 0.0f)
		inputTimeValue = 0.0f;
	if (inputTimeValue > 1.0f) {
		inputTimeValue = 1.0f;
	}
	
	float angleMultiplier = _currentAngle + -2*angleDelta / anImageView.bounds.size.height;
	if (angleMultiplier < -1.0f)
		angleMultiplier = -1.0f;
	if (angleMultiplier > 1.0f)
		angleMultiplier = 1.0f;
	
	_isDragging = YES;
	
	[self updateTransitionImageWithTime:inputTimeValue angle:angleMultiplier];
}

- (void)imageView:(BFImageView *)anImageView mouseDragDidEndAtPoint:(NSPoint)point {
	float inputTimeValue;
	float angleMultiplier;
	
	if (_isDragging) {
		if (_lastDirection < 0) {
			inputTimeValue = 0.0f;
			angleMultiplier = 0.0f;
		}
		else {
			inputTimeValue = [self stopValue];
			angleMultiplier = [self stopAngle];
		}
	}
	else {
		if (_currentTime == [self stopValue]) {
			// goto to start
			inputTimeValue = 0.0f;
			angleMultiplier = 0.0f;
		}
	}
	_isDragging = NO;
	
	[self updateTransitionImageWithTime:inputTimeValue angle:angleMultiplier animated:YES];
}


@end
