//
//  NetworkService.h
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestCompletionBlock)(NSData *data, NSError *error);

@interface NetworkService : NSObject

- (void)requestDataFromURL:(NSURL *)url withCompletionBlock:(RequestCompletionBlock)completionBlock;

@end
