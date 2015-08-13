//
//  QuestionScoreViewController.h
//  GuessingGame
//
//  Created by kandpal, Deep (Cognizant) on 13/08/15.
//  Copyright (c) 2015 cts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsModel.h"

@protocol QuestionsScoreDelegate <NSObject>

-(void)showNextQuestionDetailsForPlayer;

@end

@interface QuestionScoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *questionImage;
@property (weak, nonatomic) IBOutlet UITextView *questionText;
@property (weak, nonatomic) IBOutlet UILabel *questionScore;
@property (strong, nonatomic) QuestionsModel *questionModel;
@property(assign,nonatomic)NSInteger score;
@property(assign,nonatomic)NSInteger totalScore;
@property(nonatomic,assign)id<QuestionsScoreDelegate>delegate;
- (IBAction)readFullArticle:(id)sender;
- (IBAction)nextArticleClicked:(id)sender;
- (IBAction)showPlayerScore:(id)sender;

@end
