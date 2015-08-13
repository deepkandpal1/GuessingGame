//
//  StartViewController.m
//  GuessingGame
//
//  Created by kandpal, Deep (Cognizant) on 13/08/15.
//  Copyright (c) 2015 cts. All rights reserved.
//

#import "StartViewController.h"
#import "Reachability.h"
#import "NetworkManager.h"
#import "GamingConstants.h"
#import "QuestionsViewController.h"
#import "QuestionModelHelper.h"
#import "QuestionsModel.h"

@interface StartViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;


@end

@implementation StartViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //Check Internet Reachability
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    __weak StartViewController* weakSelf= self;
    if (internetStatus != NotReachable) {
        //call URL to load Questions Feed
        [NetworkManager getFeedDataFromServerForURL:FEED_URL WithCompletionHandler:^(id feedData) {
                NSMutableArray* feedArray = [NSMutableArray arrayWithArray:[QuestionModelHelper convertJSONDictionaryToQuestionModel:feedData]];
                //downloading image for first question
                if(feedArray.count>0)
                {
                    QuestionsModel* firstQuestion=[feedArray objectAtIndex:0];
                    [weakSelf.messageLabel setText:@"Navigating to Game Screen..."];

                    [NetworkManager getFeedDataFromServerForURL:[NSURL URLWithString:firstQuestion.imageUrl] WithCompletionHandler:^(id responseData)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                        firstQuestion.questionImage=[UIImage imageWithData:responseData];
                        [feedArray replaceObjectAtIndex:0 withObject:firstQuestion];
                        QuestionsViewController *questionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionsViewController"];
                        questionsVC.questionsArray=feedArray;
                        [self.navigationController pushViewController:questionsVC animated:YES];
                        });
                    }];
                }
                else
                {
                    NSLog(@"No Data Downloaded from server");
                }
                
        }];
        
    }
    else {
        //no Internet Connection
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"No Internet" message:@"You seems to be appear offline.Please check your internet connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}

@end
