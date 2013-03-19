//
//  CircleView3.m
//  SampleObjectiveC
//
//  Created by Gabriel Kho on 3/14/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "CircleView3.h"

@implementation CircleView3

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Get the graphics context that we are currently executing under
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    
    // Save the current graphics context settings
    [gc saveGraphicsState];
    
    NSUInteger randomOpacityInt = (random() % 30 + 5 );
    CGFloat opacityScale = (CGFloat)randomOpacityInt / 100.0;
    NSColor *fillColor = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:opacityScale];
    NSColor *strokeColor = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:opacityScale];
    
    // Set the color in the current graphics context for future draw operations
    [strokeColor setStroke];
    [fillColor setFill];
    
    // Create our circle path
    NSRect rect = NSMakeRect(10, 10, 10, 10);
    NSBezierPath* circlePath = [NSBezierPath bezierPath];
    [circlePath appendBezierPathWithOvalInRect: rect];
    
    // Outline and fill the path
    [circlePath stroke];
    [circlePath fill];
    
    // Restore the context to what it was before we messed with it
    [gc restoreGraphicsState];
}
@end
