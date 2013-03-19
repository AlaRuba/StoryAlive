//
//  BFImageView.h
//  PageFlipping
//
//  Created by Алексеев Влад on 31.12.10.
//  Copyright 2010 beefon software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol BFImageViewDelegate;

@interface BFImageView : NSImageView {
	id <BFImageViewDelegate> delegate;
	BOOL dragInProcess;
    BOOL isInNextPageCurl;
}
@property (nonatomic, strong) IBOutlet id <BFImageViewDelegate> delegate;

- (void)setup;

@end

@protocol BFImageViewDelegate <NSObject>

- (BOOL)imageView:(BFImageView *)anImageView shouldCaptureEvent:(NSEvent *)theEvent atPoint:(NSPoint)aPoint;

- (void)imageView:(BFImageView *)anImageView didChangeFrame:(NSRect)frameRect;

- (void)imageView:(BFImageView *)anImageView mouseDragDidStartAtPoint:(NSPoint)point;
- (void)imageView:(BFImageView *)anImageView mouseDraggedAtPoint:(NSPoint)point direction:(float)direction angleDelta:(float)angleDelta;
- (void)imageView:(BFImageView *)anImageView mouseDragDidEndAtPoint:(NSPoint)point;

@end