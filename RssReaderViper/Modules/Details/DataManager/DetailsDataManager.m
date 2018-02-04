//
//  DetailsDataManager.m
//  RssReaderViper
//
//  Created by evgeniy on 16/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "DetailsDataManager.h"
#import "LocalStorageService.h"
#import "ArticleEntity.h"

@interface DetailsDataManager ()

@property (strong, nonatomic) LocalStorageService *storageService;

@end

@implementation DetailsDataManager

- (id)init {
    return [self initWithStorageService:nil];
}

- (instancetype)initWithStorageService:(LocalStorageService *)aStorageService {

    if (self = [super init]) {

        if (!aStorageService) {
            aStorageService = [[LocalStorageService alloc] init];
        }

        _storageService = aStorageService;
    }

    return self;
}

- (void)fetchArticlesWithUpcomingItemId:(NSInteger)itemId {
    ArticleEntity *article = [self.storageService getArticleWithUpcomingItemId:itemId];
    
    if (article) {
        [self articleFetched:article];
    } else {
        [self fetchDidFailWithError:@"No such article"];
    }
}

- (void)articleFetched:(ArticleEntity *)article {
    [self.detailsInteractor articleFetched:article];
}

- (void)fetchDidFailWithError:(NSString *)errorDescription {
    [self.detailsInteractor fetchDidFailWithError:errorDescription];
}

@end
