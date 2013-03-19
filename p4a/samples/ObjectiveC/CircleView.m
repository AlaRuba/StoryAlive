//
//  CircleView.m
//  SampleObjectiveC
//
//  Created by Adam Raudonis on 3/8/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

@synthesize dimensions;
@synthesize color;
@synthesize stroke;

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
    
    // Set the color in the current graphics context for future draw operations
    [stroke setStroke];
    [color setFill];
    
    // Create our circle path
    NSRect rect = NSMakeRect(0, 0, dimensions, dimensions);
    NSBezierPath* circlePath = [NSBezierPath bezierPath];
    [circlePath appendBezierPathWithOvalInRect: rect];
    
    // Outline and fill the path
    [circlePath stroke];
    [circlePath fill];
    
    // Restore the context to what it was before we messed with it
    [gc restoreGraphicsState];
}

@end
