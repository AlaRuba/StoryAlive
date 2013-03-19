//
//  BFImageView.m
//  PageFlipping
//
//  Created by Алексеев Влад on 31.12.10.
//  Copyright 2010 beefon software. All rights reserved.
//

#import "BFImageView.h"

@implementation BFImageView

@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self setup];
	}
	
	return self;
}

- (id)init {
	self = [super init];
			
	if (self) {
		[self setup];
	}
	
	return self;
}

- (id)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];
	
	if (self) {
		[self setup];
	}
	
	return self;
}

- (BOOL)acceptsFirstResponder {
	return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
	return YES;
}

- (void)setup {
	
}

- (NSPoint)pointForMouseEvent:(NSEvent *)event {
	NSPoint locationInWindow = [event locationInWindow];
	NSPoint locationInView = [self convertPoint:locationInWindow fromView:nil];
	
	if (locationInView.y < 0) 
		locationInView.y = 0;
	
	if (locationInView.y > self.bounds.size.height)
		locationInView.y = self.bounds.size.height;
	
	return locationInView;
}

- (void)setFrame:(NSRect)frameRect {
	[super setFrame:frameRect];
	
	[[self delegate] imageView:self didChangeFrame:frameRect];
}

- (void)mouseDown:(NSEvent *)theEvent {
	NSPoint location = [self pointForMouseEvent:theEvent];
	
	if (dragInProcess == NO) {
		if ([[self delegate] imageView:self shouldCaptureEvent:theEvent atPoint:location] == NO) {
			[super mouseDown:theEvent];
		}
		else {
			dragInProcess = YES;
			
			
			BOOL keepOn = YES;
			BOOL isInside = YES;
			NSPoint prevLocation = location;
			NSPoint mouseLoc;
			
			[[self delegate] imageView:self mouseDragDidStartAtPoint:location];
			
			while (keepOn) {
				theEvent = [[self window] nextEventMatchingMask: NSLeftMouseUpMask | NSLeftMouseDraggedMask];
				mouseLoc = [self convertPoint:[theEvent locationInWindow] fromView:nil];
				isInside = [self mouse:mouseLoc inRect:[self bounds]];
				
				float deltaX, deltaY;
				
				switch ([theEvent type]) {
					case NSLeftMouseDragged:
						deltaX = mouseLoc.x - prevLocation.x;
						deltaY = prevLocation.y - mouseLoc.y;
						
						prevLocation = mouseLoc;
						
						[[self delegate] imageView:self 
							   mouseDraggedAtPoint:mouseLoc 
										 direction:deltaX 
										angleDelta:deltaY];
						dragInProcess = YES;
						break;
					case NSLeftMouseUp:
						[[self delegate] imageView:self mouseDragDidEndAtPoint:mouseLoc];
						keepOn = NO;
						dragInProcess = NO;
						break;
					default:
						/* Ignore any other kind of event. */
						break;
				}	
			}
		}	
	}
}

//- (void)mouseDragged:(NSEvent *)theEvent {	
//	NSPoint location = [self pointForMouseEvent:theEvent];
//	
//	if (dragInProcess == NO) {
//		if ([[self delegate] imageView:self shouldCaptureEvent:theEvent atPoint:location] == NO) {
//			[super mouseDown:theEvent];
//		}
//	}
//	
//	dragInProcess = YES;
//	
//	float direction = [theEvent deltaX];
//	float angleDelta = [theEvent deltaY];
//	
//	[[self delegate] imageView:self mouseDrag:theEvent atPoint:location];
//	[[self delegate] imageView:self mouseDraggedAtPoint:location direction:direction angleDelta:angleDelta];
//}
//
//- (void)mouseUp:(NSEvent *)theEvent {
//	NSPoint location = [self pointForMouseEvent:theEvent];
//	
//	if (dragInProcess == NO) {
//		if ([[self delegate] imageView:self shouldCaptureEvent:theEvent atPoint:location] == NO) {
//			[super mouseUp:theEvent];
//		}
//	}
//	else {
//		[[self delegate] imageView:self mouseDragDidEndAtPoint:location];
//	}
//	dragInProcess = NO;
//	
//	[[self delegate] imageView:self mouseUp:theEvent atPoint:location];	
//}
//
//- (void)mouseExited:(NSEvent *)theEvent {
//	NSPoint location = [self pointForMouseEvent:theEvent];
//	
//	if (dragInProcess == NO) {
//		if ([[self delegate] imageView:self shouldCaptureEvent:theEvent atPoint:location] == NO) {
//			[super mouseUp:theEvent];
//		}
//	}
//	else {
//		[[self delegate] imageView:self mouseDragDidEndAtPoint:location];
//	}
//	dragInProcess = NO;
//}

@end
