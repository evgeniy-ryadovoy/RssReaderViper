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

@implementation DetailsDataManager

- (void)fetchArticlesWithUpcomingItemId:(NSInteger)itemId {
    ArticleEntity *article = [[LocalStorageService sharedInstance] getArticleWithUpcomingItemId:itemId];
    
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
