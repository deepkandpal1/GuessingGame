//
//  QuestionScoreViewController.m
//  GuessingGame
//
//  Created by kandpal, Deep (Cognizant) on 13/08/15.
//  Copyright (c) 2015 cts. All rights reserved.
//

#import "QuestionScoreViewController.h"
#import "PlayerScore.h"

@implementation QuestionScoreViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.questionImage.image=self.questionModel.questionImage;
    self.questionScore.text=[NSString stringWithFormat:@"+%ld Points For You",(long)self.score];
    self.questionText.text=self.questionModel.standFirst;
}

- (IBAction)nextArticleClicked:(id)sender {
    
    [self.delegate showNextQuestionDetailsForPlayer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showPlayerScore:(id)sender {
    
    NSInteger totalScore=[[PlayerScore sharedInstance] totalScore];
    if(totalScore<0)
        totalScore=0;
    
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"LeaderBoard" message:[NSString stringWithFormat:@"Your total score is %ld",(long)totalScore] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    
}
- (IBAction)readFullArticle:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.questionModel.storyUrl]];

}
@end
