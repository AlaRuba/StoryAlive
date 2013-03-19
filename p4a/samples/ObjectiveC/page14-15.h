//
//  page14-15.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import "AnimatedFlashlight.h"
#import "AnimatedLights.h"
#import "PageViewController.h"

@interface page14_15 : PageViewController <LeapDelegate>
{
    IBOutlet NSImageView *page14_15_bottom_1_default;
    IBOutlet NSImageView *page14_15_bottom_1;
    IBOutlet NSImageView *page14_15_bottom_2;
    IBOutlet AnimatedFlashlight *page14_15_flashlight;
    IBOutlet NSImageView *page14_15_top_1_default;
    IBOutlet NSImageView *page14_15_top_1;
    IBOutlet NSImageView *page14_15_top_2;
    IBOutlet AnimatedLights *page14_15_xmas;
    IBOutlet NSImageView *cursor;
    
}
@property IBOutlet NSImageView *page14_15_bottom_1_default;
@property IBOutlet NSImageView *page14_15_bottom_1;
@property IBOutlet NSImageView *page14_15_bottom_2;
@property IBOutlet AnimatedFlashlight *page14_15_flashlight;
@property IBOutlet NSImageView *page14_15_top_1_default;
@property IBOutlet NSImageView *page14_15_top_1;
@property IBOutlet NSImageView *page14_15_top_2;
@property IBOutlet AnimatedLights *page14_15_xmas;
@property NSSound *sound;

@end
