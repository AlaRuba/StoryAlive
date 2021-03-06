//
//  CircleView.h
//  SampleObjectiveC
//
//  Created by Adam Raudonis on 3/8/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CircleView : NSView

@property (nonatomic, assign) int dimensions;
@property (nonatomic, strong) NSColor *color;
@property (nonatomic, strong) NSColor *stroke;

@end
