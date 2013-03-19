//
//  GlobalModel.h
//  MiniLeague
//
//  Created by Bryant Tan on 05/08/2011.
//  Copyright 2011 Adam Raudonis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalModel : NSObject

// Note these are the files, not sheets.
@property(nonatomic, strong) NSArray *spreadsheets;
@property NSSound *sound;


+ (GlobalModel*) sharedGlobalModel;

@end
