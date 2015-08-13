//
//  QuestionModelHelper.m
//  GuessingGame
//
//  Created by kandpal, Deep (Cognizant) on 13/08/15.
//  Copyright (c) 2015 cts. All rights reserved.
//

#import "QuestionModelHelper.h"
#import "QuestionsModel.h"

@implementation QuestionModelHelper

/**
 *  This method will convert data received as response from server to model objects and then return the array of model object back
 *
 *  @param feedData data received as response of the URL
 *
 *  @return Array of model ojects
 */
+(NSArray*)convertJSONDictionaryToQuestionModel:(id)feedData
{
    NSError *error=nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:feedData
                                                             options:kNilOptions
                                                               error:&error];
    NSMutableArray* modelArray=[[NSMutableArray alloc] initWithCapacity:0];
    for(NSDictionary* dict in [jsonDict objectForKey:@"items"])
    {
        QuestionsModel* modelObj=[[QuestionsModel alloc] init];
        modelObj.correctAnswerIndex= [[dict valueForKey:@"correctAnswerIndex"] integerValue];
        modelObj.imageUrl= [dict valueForKey:@"imageUrl"];
        modelObj.headlines= [dict objectForKey:@"headlines"];
        modelObj.section= [dict valueForKey:@"section"];
        modelObj.standFirst= [dict valueForKey:@"standFirst"];
        modelObj.storyUrl= [dict valueForKey:@"storyUrl"];
        
        [modelArray addObject:modelObj];
    }
    return modelArray;
}

@end
