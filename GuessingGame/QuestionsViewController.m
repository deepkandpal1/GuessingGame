//
//  QuestionsViewController.m
//  GuessingGame
//
//  Created by kandpal, Deep (Cognizant) on 12/08/15.
//  Copyright (c) 2015 cts. All rights reserved.
//

#import "QuestionsViewController.h"
#import "QuestionsModel.h"
#import "QuestionScoreViewController.h"
#import "NetworkManager.h"
#import "PlayerScore.h"

@interface QuestionsViewController ()<QuestionsScoreDelegate>
{
    NSInteger currentIndex;
    int secondsLeft;
    float progress;
    NSTimer* timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *questionImageView;
@property (weak, nonatomic) IBOutlet UILabel *questionCategory;
@property (weak, nonatomic) IBOutlet UILabel *questionPoints;
@property (weak, nonatomic) IBOutlet UIImageView *loadingView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)GiveUpButton:(id)sender;


@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentIndex=0;
    [self downloadImageForNextQuestion];
    [self initializeViewsAndTimer];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  This method is used for displaying the content of the subviews and invoking the timer.
 */
-(void)initializeViewsAndTimer
{
    QuestionsModel* modelObj= [self.questionsArray objectAtIndex:currentIndex];
    self.questionImageView.image=modelObj.questionImage;
    self.questionCategory.text=modelObj.section;
    secondsLeft=10;
    progress=1.0;
    [self.progressView setProgress:progress animated:NO];
    self.questionPoints.text=[NSString stringWithFormat:@"+%d",secondsLeft];
    timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTimeCounter) userInfo:nil repeats:YES];
}

/**
 *  This method is used for downloadin the image of next question in advance so that user did not have to wait afterwards.
 */
-(void)downloadImageForNextQuestion
{
    QuestionsModel* modelObj= [self.questionsArray objectAtIndex:currentIndex+1];
    [NetworkManager getFeedDataFromServerForURL:[NSURL URLWithString:modelObj.imageUrl] WithCompletionHandler:^(id responseData) {
        modelObj.questionImage=[UIImage imageWithData:responseData];
        [self.questionsArray replaceObjectAtIndex:currentIndex+1 withObject:modelObj];
    }];
 
}

/**
 *  This method will get called after each second.We are checking for the second elapsed and once the seconds are 0, we are presenting the score view.
 */
-(void)changeTimeCounter
{
    secondsLeft--;
    progress-=0.1f;
    self.questionPoints.text=[NSString stringWithFormat:@"+%d",secondsLeft];
    [self.progressView setProgress:progress animated:YES];
    if(secondsLeft==0)
    {
        [timer invalidate];
        QuestionScoreViewController *scoreVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionScoreViewController"];
        scoreVC.questionModel=[self.questionsArray objectAtIndex:currentIndex];
        scoreVC.score=secondsLeft;
        scoreVC.delegate=self;
        [self.navigationController presentViewController:scoreVC animated:YES completion:nil];
        
    }
}

#pragma mark - UITableview Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self.questionsArray objectAtIndex:currentIndex] headlines] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    QuestionsModel* modelObj= [self.questionsArray objectAtIndex:currentIndex];
    cell.textLabel.text=[modelObj.headlines objectAtIndex:indexPath.section];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.numberOfLines=0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    QuestionsModel* modelObj= [self.questionsArray objectAtIndex:currentIndex];
    [timer invalidate];
    QuestionScoreViewController *scoreVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionScoreViewController"];
    scoreVC.questionModel=modelObj;
    scoreVC.delegate=self;
    NSInteger oldScore=[[PlayerScore sharedInstance] totalScore];
    if(oldScore<0)
        oldScore=0;
    if(modelObj.correctAnswerIndex==indexPath.section)
    {
        scoreVC.score=secondsLeft;
        [[PlayerScore sharedInstance] setTotalScore:oldScore+secondsLeft];
    }
    else
    {
        scoreVC.score=0;
        [[PlayerScore sharedInstance] setTotalScore:oldScore-2];

    }
    [self.navigationController presentViewController:scoreVC animated:YES completion:nil];

}

#pragma mark QuestionsScore Delegate

-(void)showNextQuestionDetailsForPlayer
{
    currentIndex++;
    [self.tableView reloadData];
    [self initializeViewsAndTimer];
    [self downloadImageForNextQuestion];
}

#pragma mark

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GiveUpButton:(id)sender {
}
@end
