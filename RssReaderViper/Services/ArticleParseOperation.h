//
//  ParseService.h
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ArticleParseOperationDelegate <NSObject>

// required methods
- (void)parseOperationEntriesDidParse:(NSArray *)parsedEntries;
- (void)parseOperationErrorDidOccur:(NSError *)error;

@end

@interface ArticleParseOperation : NSOperation

@property (weak, nonatomic) id <ArticleParseOperationDelegate> delegate;
@property (copy, readonly) NSData *rssFeedData;

- (instancetype)initWithData:(NSData *)parseData NS_DESIGNATED_INITIALIZER;

@end
