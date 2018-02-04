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
#import "LocalStorageService.h"

static NSString *kTestUrl = @"http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml";

@interface ArticlesDataManager () <ArticleParseOperationDelegate>

@property (strong, nonatomic) NetworkService *networkService;
@property (strong, nonatomic) LocalStorageService *storageService;
@property (strong, nonatomic) NSOperationQueue *parseQueue;

@end

@implementation ArticlesDataManager

@synthesize articlesInteractor;

- (instancetype)init {
    return [self initWithNetworkService:nil andStorageService:nil];
}

- (instancetype)initWithNetworkService:(NetworkService *)aNetworkService
                     andStorageService:(LocalStorageService *)aStorageService {

    if (self = [super init]) {
        _parseQueue = [[NSOperationQueue alloc] init];

        if (!aNetworkService) {
            aNetworkService = [[NetworkService alloc] init];
        }

        _networkService = aNetworkService;

        if (!aStorageService) {
            aStorageService = [[LocalStorageService alloc] init];
        }

        _storageService = aStorageService;
    }

    return self;
}

- (void)fetchAllArticles {
    NSURL *url = [NSURL URLWithString:kTestUrl];
    
    [self.networkService requestDataFromURL:url
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
    [self.storageService saveArticlesToStorage:parsedEntries];
    [self.articlesInteractor articlesFetched:parsedEntries];
}

- (void)parseOperationErrorDidOccur:(NSError *)error {
    [self.articlesInteractor fetchDidFailWithError:error];
}

@end
