//
//  ArticlesInteractor.m
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "ArticlesInteractor.h"
#import "ArticleEntity.h"
#import "UpcomingItem.h"

@implementation ArticlesInteractor

const int kDescriptionLength = 150;

- (void)fetchArticles {
    [self.dataManager fetchAllArticles];
}

- (void)articlesFetched:(NSArray<ArticleEntity *> *)articles {
    
    //form array of upcoming items for presenter
    NSMutableArray *upcomingItems = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormat.locale = locale;
    dateFormat.dateFormat = @"MM/dd/yyyy";
    NSString *shortDescription = nil;
    
    for (ArticleEntity *entity in articles) {
        
        shortDescription = (kDescriptionLength <= entity.info.length) ?
                            [entity.info substringToIndex:kDescriptionLength] : entity.info;
        
        UpcomingItem *item = [UpcomingItem upcomingItemWithTitle:entity.title
                                                            info:shortDescription
                                                         pubDate:[dateFormat stringFromDate:entity.pubDate]
                                                            link:entity.link
                                                          itemId:upcomingItems.count];
        
        [upcomingItems addObject:item];
    }
    
    [self.articlesPresenter foundArticles:upcomingItems];
}

- (void)fetchDidFailWithError:(NSError *)error {
    [self.articlesPresenter articlesSearchDidFailWithError:error.localizedDescription];
}

@end
