//
//  AnimatedLights.h
//  SampleObjectiveC
//
//  Created by Xin on 2013 - 03 - 12.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AnimatedLights : NSView {
    CALayer* containerLayerForSpheres;
    CALayer* mainLayer;
}
- (void)start;

@end
