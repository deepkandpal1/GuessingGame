//
//  PlayerScore.h
//  GuessingGame
//
//  Created by kandpal, Deep (Cognizant) on 13/08/15.
//  Copyright (c) 2015 cts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerScore : NSObject

@property (nonatomic, assign) NSInteger totalScore;

+ (id)sharedInstance;

@end