//
//  ArticlesDataManager.m
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "ArticlesDataManager.h"
#import "NetworkService.h"
#import "ArticleParseOperation.h"
#import "ArticlesContract.h"
#import "LocalStorageService.h"

static NSString *kTestUrl = @"http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml";

@interface ArticlesDataManager () <ArticleParseOperationDelegate>

@property (strong, nonatomic) NSOperationQueue *parseQueue;

@end

@implementation ArticlesDataManager

@synthesize articlesInteractor;

- (instancetype)init {
    
    if (self = [super init]) {
         _parseQueue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

- (void)fetchAllArticles {
    NSURL *url = [NSURL URLWithString:kTestUrl];
    
    [[NetworkService sharedInstance] requestDataFromURL:url
                                    withCompletionBlock:^(NSData *data, NSError *error){
                                    
                                        if (error) {
                                            [self.articlesInteractor fetchDidFailWithError:error];
                                        } else {
                                            [self parseData:data];
                                        }
                                    
                                    }];
}

- (void)parseData:(NSData *)data {
    ArticleParseOperation *parseOperation = [[ArticleParseOperation alloc] initWithData:data];
    parseOperation.delegate = self;
    [self.parseQueue addOperation:parseOperation];
}

#pragma mark - ParseOperationDelegate

- (void)parseOperationEntriesDidParse:(NSArray <ArticleEntity *> *)parsedEntries {
    [[LocalStorageService sharedInstance] saveArticlesToStorage:parsedEntries];
    [self.articlesInteractor articlesFetched:parsedEntries];
}

- (void)parseOperationErrorDidOccur:(NSError *)error {
    [self.articlesInteractor fetchDidFailWithError:error];
}

@end
