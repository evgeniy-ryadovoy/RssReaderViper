//
//  DetailsInteractor.m
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "DetailsInteractor.h"
#import "LocalStorageService.h"
#import "UpcomingItem.h"
#import "ArticleEntity.h"

@implementation DetailsInteractor

- (void)fetchArticleById:(NSInteger)articleId {
    [self.detailsDataManger fetchArticlesWithUpcomingItemId:articleId];
}

- (void)articleFetched:(ArticleEntity *)article {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormat.locale = locale;
    dateFormat.dateFormat = @"MM/dd/yyyy";

    UpcomingItem *item = [UpcomingItem upcomingItemWithTitle:article.title
                                                        info:article.info
                                                     pubDate:[dateFormat stringFromDate:article.pubDate]
                                                        link:article.link
                                                      itemId:0];
    
    [self.detailsPresenter foundArticle:item];
}

- (void)fetchDidFailWithError:(NSString *)errorDescription {
    [self.detailsPresenter articleSearchDidFailWithError:errorDescription];
}

@end
