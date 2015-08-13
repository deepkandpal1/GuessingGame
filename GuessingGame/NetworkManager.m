//
//  NetworkManager.m
//  GuessingGame
//
//  Created by kandpal, Deep (Cognizant) on 13/08/15.
//  Copyright (c) 2015 cts. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

/**
 *  This method is used for getting the data from the url which we are passing as parameter.The data which this method receives will pass it back to the calling method using Completion block
 *
 *  @param url             NSURL object for getting data from server
 *  @param completionBlock Block for giving comtrol back to caller class.
 */
+(void)getFeedDataFromServerForURL:(NSURL *)url WithCompletionHandler:(void (^)(id responseData))completionBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if(data)
                                      {
                                      completionBlock(data);
                                      }
                                      else
                                      {
                                          NSLog(@"No Data Available");
                                      }
                                          
                                  }];
    
    [task resume];
}

@end
