//
//  AnimatedPageThreeView.h
//  SampleObjectiveC
//
//  Created by Xin on 2013 - 03 - 09.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface AnimatedPageThreeView : NSView {
    CALayer* containerLayerForSpheres;
}
- (void)start;
@end

