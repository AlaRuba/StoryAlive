//
//  TestMouseView.m
//  SampleObjectiveC
//
//  Created by Adam Raudonis on 3/8/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import "TestMouseView.h"
#import "GlobalModel.h"

@implementation TestMouseView

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
    // Drawing code here.
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    NSPoint mousePointInView = [self convertPoint:theEvent.locationInWindow fromView:nil];

    NSLog(@"%f %f",mousePointInView.x,mousePointInView.y);
    
    
}

@end
