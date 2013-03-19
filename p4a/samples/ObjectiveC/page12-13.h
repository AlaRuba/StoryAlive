//
//  page12-13.h
//  SampleObjectiveC
//
//  Created by Cindy Chang on 3/3/13.
//  Copyright (c) 2013 Leap Motion. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import "AnimatedCoin.h"
#import "AnimatedRing.h"
#import "PageViewController.h"

@interface page12_13 : PageViewController <LeapDelegate>
{
    IBOutlet NSImageView *page12_13_bottom_2;
    IBOutlet NSImageView *page12_13_bottom_3;
    IBOutlet NSImageView *page12_13_bottom_4;

    IBOutlet NSImageView *page12_13_top_2;
    IBOutlet NSImageView *page12_13_top_3;
    
    IBOutlet AnimatedCoin *coin;
    IBOutlet AnimatedRing *ring;
    IBOutlet NSImageView *cursor;
    IBOutlet NSImageView *topFirefly;
    IBOutlet NSImageView *bottomFirefly;
    
}
@property IBOutlet NSImageView *shelf;
@property IBOutlet NSImageView *page12_13_bottom_2;
@property IBOutlet NSImageView *page12_13_bottom_3;
@property IBOutlet NSImageView *page12_13_bottom_4;

@property IBOutlet NSImageView *page12_13_top_2;
@property IBOutlet NSImageView *page12_13_top_3;

@property IBOutlet NSTextField *alabel;
@property IBOutlet AnimatedCoin *coin;
@property IBOutlet AnimatedRing *ring;
@property IBOutlet NSImageView *cursor;
@property IBOutlet NSImageView *topFirefly;
@property IBOutlet NSImageView *bottomFirefly;
@property NSSound *sound;



@end
