//
//  NetworkService.m
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "NetworkService.h"

@interface NetworkService ()


@end

@implementation NetworkService

const float kRequestTime = 15.0;
const float kConnectionLiveTime = 15.0;

+ (instancetype)sharedInstance {
    static NetworkService *service;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
    });
    
    return service;
}

- (void)requestDataFromURL:(NSURL *)url withCompletionBlock:(RequestCompletionBlock)completionBlock {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = kRequestTime;
    config.timeoutIntervalForRequest = kConnectionLiveTime;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // create an session data task to obtain and download the app icon
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:urlRequest
                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                                          //NSLog(error.localizedDescription);
                                          // back on the main thread, check for errors, if no errors start the parsing
                                          if (error != nil && response == nil) {
                                              
                                              if (error.code == NSURLErrorAppTransportSecurityRequiresSecureConnection) {
                                                  
                                                  // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                                                  // then your Info.plist has not been properly configured to match the target server.
                                                  //
                                                  NSAssert(NO, @"NSURLErrorAppTransportSecurityRequiresSecureConnection");
                                              } else {
                                                  
                                                  // error - use completion block
                                                  if (completionBlock) {
                                                      completionBlock(nil, error);
                                                  }
                                              }
                                          }
                                          
                                          // here we check for any returned NSError from the server,
                                          // "and" we also check for any http response errors check for any response errors
                                          if (response != nil) {
                                              
                                              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                              
                                              if ((httpResponse.statusCode/100) == 2) {
                                                  
                                                  if (data && completionBlock) {
                                                      /* return received data*/
                                                      completionBlock(data, nil);
                                                  }
                                                  
                                              } else {
                                                  NSString *errorString =
                                                  NSLocalizedString(@"HTTP Error", @"Error message displayed when receiving an error from the server.");
                                                  NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorString};
                                                  
                                                  NSError *error = [NSError errorWithDomain:@"HTTP"
                                                                                   code:httpResponse.statusCode
                                                                               userInfo:userInfo];
                                                  
                                                  // error - use completion block
                                                  if (completionBlock) {
                                                      completionBlock(nil, error);
                                                  }
                                              }
                                          }
                                      }];
                                  }];
    
    [sessionTask resume];
}

@end
