//
//  page10-11.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import "AnimatedFart.h"
#import "PageViewController.h"

@interface page10_11 : PageViewController <LeapDelegate>
@property IBOutlet NSImageView *page10_11_cricket;
@property IBOutlet NSImageView *page10_11_ellery;
@property IBOutlet NSImageView *page10_11_fart;
@property IBOutlet NSImageView *page10_11_franny;
@property IBOutlet NSImageView *page10_11_josie;
@property IBOutlet NSImageView *page10_11_martin;
@property IBOutlet NSImageView *cursor1;
@property IBOutlet NSImageView *cursor2;
@property IBOutlet AnimatedFart *animated_fart;
@property NSSound *sound;
@end
