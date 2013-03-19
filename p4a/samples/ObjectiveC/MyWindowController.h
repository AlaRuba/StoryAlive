/*
     File: MyWindowController.h
 Abstract: main NSWindowController
  Version: 1.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2011 Apple Inc. All Rights Reserved.
 
 */

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import <QuartzCore/QuartzCore.h>
#import "BFImageView.h"

@protocol myWindowDelegate <NSObject>
- (void)actualViewDidAppear;
@end

@interface MyWindowController : NSWindowController <LeapDelegate, BFImageViewDelegate>
{
    id <myWindowDelegate> delegate;

    
	IBOutlet NSView*	myTargetView;				// the host view
	NSViewController*	myCurrentViewController;	// the current view controller
    IBOutlet NSImageView *cursor;
    
    BFImageView *imageView;
    
    NSView *viewOverPage;
	NSView *viewUnderPage;
	
	CIImage *inputShadingImage;
	CIImage *sourceImage;
	CIImage *targetImage;
	CIImage *backsideImage;
	
	CIFilter *pageCurlFilter;
	
	NSMutableDictionary *_cachedImages;
	
	BOOL _isDragging;
	
	float stopValue;
	float stopAngle;
	
	float _lastDirection;
	float _currentTime;
	float _currentAngle;
}

@property (nonatomic, strong) IBOutlet id <myWindowDelegate> delegate;

@property     IBOutlet NSImageView *cursor;

- (IBAction)viewChoicePopupAction:(id)sender;
- (NSViewController*)viewController;

- (IBAction)nextPage:(id)sender;
- (IBAction)prevPage:(id)sender;

// Page turning things

@property (nonatomic, retain) IBOutlet BFImageView *imageView;

@property (nonatomic, retain) IBOutlet NSView *viewOverPage;
@property (nonatomic, retain) IBOutlet NSView *viewUnderPage;

@property (nonatomic, retain) CIImage *inputShadingImage;
@property (nonatomic, retain) CIImage *sourceImage;
@property (nonatomic, retain) CIImage *targetImage;
@property (nonatomic, retain) CIImage *backsideImage;

@property (nonatomic, retain) CIFilter *pageCurlFilter;

@property (nonatomic) float stopValue;
@property (nonatomic) float stopAngle;

- (NSImage *)NSImageFromCIImage:(CIImage *)ciImage;
- (NSImage *)NSImageFromNSView:(NSView *)nsView;
- (CIImage *)CIImageFromNSImage:(NSImage *)nsImage;
- (CIImage *)CIImageFromNSView:(NSView *)nsView;
- (CIImage *)CIImageFromResource:(NSString *)resource extension:(NSString *)extension;

- (NSImage *)transitionImageWithTime:(float)time angle:(float)angle;
- (void)updateTransitionImageWithTime:(float)time angle:(float)angle;
- (void)updateTransitionImageWithTime:(float)time angle:(float)angle animated:(BOOL)animated;
- (void)transitionDidFinishWithTime:(float)time;

- (void)removeSubview:(NSView *)subview;
- (void)placeSubview:(NSView *)subview underView:(NSView *)underView;
- (void)placeSubview:(NSView *)subview overView:(NSView *)underView;

- (IBAction)buttonPressed:(id)sender;


@end
