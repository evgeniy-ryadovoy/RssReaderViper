//
//  LocalStorageService.h
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArticleEntity;
@class UpcomingItem;

@interface LocalStorageService : NSObject

+ (instancetype)sharedInstance;
- (void)saveArticlesToStorage:(NSArray <ArticleEntity *> *)articles;
- (ArticleEntity *)getArticleWithUpcomingItemId:(NSInteger)upcomingItemId;

@end
