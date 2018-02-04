//
//  LocalStorageService.m
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "LocalStorageService.h"
#import "ArticleEntity.h"

@interface LocalStorageService ()

@property (nonatomic, copy) NSArray <ArticleEntity *> *articleItems;

@end

@implementation LocalStorageService

- (void)saveArticlesToStorage:(NSArray <ArticleEntity *> *)articles {
    
    if (articles.count) {
        self.articleItems = articles;
    }
}

// Simplest implementation for test app. We can use some algorithms, keep data in cache, core data etc
- (ArticleEntity *)getArticleWithUpcomingItemId:(NSInteger)upcomingItemId {
    
    if (self.articleItems.count <= upcomingItemId) {
        return nil;
    }
    
    return self.articleItems[upcomingItemId];
}

@end
