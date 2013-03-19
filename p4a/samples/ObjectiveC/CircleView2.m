//
//  CircleView.m
//  SampleObjectiveC
//
//  Created by Adam Raudonis on 3/8/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "CircleView2.h"

@implementation CircleView2

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
    NSUInteger randomOpacityInt = (random() % 30 + 30 );
    CGFloat opacityScale = (CGFloat)randomOpacityInt / 100.0;
    NSColor *fillColor = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:opacityScale];
    NSColor *strokeColor = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1];
    
    // Set the color in the current graphics context for future draw operations
    [strokeColor setStroke];
    [fillColor setFill];
    
    // Create our circle path
    NSInteger circleSize = (random() % 25 + 10);
    NSInteger circlePositionX = (random() %30);
    NSInteger circlePositionY = (random()%30);
    NSRect rect = NSMakeRect(circlePositionX, circlePositionY, circleSize, circleSize);
    NSBezierPath* circlePath = [NSBezierPath bezierPath];
    [circlePath appendBezierPathWithOvalInRect: rect];
    
    // Outline and fill the path
    [circlePath stroke];
    [circlePath fill];
    
    // Restore the context to what it was before we messed with it
    [gc restoreGraphicsState];
}

@end
