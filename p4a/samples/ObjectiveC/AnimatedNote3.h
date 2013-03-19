//
//  AnimatedNote3.h
//  SampleObjectiveC
//
//  Created by Xin on 2013 - 03 - 12.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AnimatedNote3 : NSView {
    CALayer* containerLayerForSpheres;
}
- (void)start;

@end