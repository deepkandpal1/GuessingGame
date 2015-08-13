//
//  QuestionsModel.h
//  GuessingGame
//
//  Created by kandpal, Deep (Cognizant) on 13/08/15.
//  Copyright (c) 2015 cts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuestionsModel : NSObject

@property(nonatomic,assign)NSInteger correctAnswerIndex;
@property(nonatomic,strong)NSString* imageUrl;
@property(nonatomic,strong)NSArray* headlines;
@property(nonatomic,strong)NSString* section;
@property(nonatomic,strong)NSString* standFirst;
@property(nonatomic,strong)NSString* storyUrl;
@property(nonatomic,strong)UIImage* questionImage;


@end
