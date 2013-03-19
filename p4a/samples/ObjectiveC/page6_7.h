//
//  page6-7.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import "PageViewController.h"


@interface page6_7 : PageViewController <LeapDelegate>
@property IBOutlet NSImageView *page6_7_cricket;
@property IBOutlet NSImageView *page6_7_ellery_light;
@property IBOutlet NSImageView *page6_7_ellery;
@property IBOutlet NSImageView *page6_7_franny;
@property IBOutlet NSImageView *page6_7_josie_light;
@property IBOutlet NSImageView *page6_7_josie;
@property IBOutlet NSImageView *page6_7_martin_light;
@property IBOutlet NSImageView *page6_7_martin;
@property NSSound *sound;

@end
