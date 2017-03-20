//
//  ArticlesPresenter.m
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "ArticlesPresenter.h"
#import "UpcomingItem.h"
#import "UpcomingItemsGroup.h"

@interface ArticlesPresenter ()

@property (copy, nonatomic) NSArray *articleItems;
@property (nonatomic, assign) BOOL groupedStyle;

@end

@implementation ArticlesPresenter

- (void)viewDidLoad {
    [self.articlesView showActivityIndicator];
    [self.articlesInteractor fetchArticles];
}


- (void)plainButtonClicked {
    self.groupedStyle = NO;
    [self viewDidLoad];
}


- (void)groupedButtonClicked {
    self.groupedStyle = YES;
    [self viewDidLoad];
}


- (void)articlesSearchDidFailWithError:(NSString *)errorDescription {
    [self.articlesView hideActivityIndicator];
    [self.articlesView showErrorWithDescription:errorDescription];
}


- (void)foundArticles:(NSArray<UpcomingItem *> *)articles {
    self.articleItems = articles;
    [self.articlesView hideActivityIndicator];
    
    if (articles.count) {
        [self sortArticlesByDate];
    
        //Second option - show grouped articles by month
        if (self.groupedStyle && [self.articlesView respondsToSelector:@selector(showGroupedArticlesData:)]) {
            NSArray *groupedArtilces = [self groupArticlesByMonth];
            [self.articlesView showGroupedArticlesData:groupedArtilces];
        } else {
            //First option - show simple sorted articles
            [self.articlesView showUpcomingArticlesData:self.articleItems];
        }
        
    } else {
        [self.articlesView showNoData];
    }
}


- (void)didSelectArticle:(UpcomingItem *)article {
    //Send article through wireframe
    [self.articlesWireframe presentDetialsInterfaceForItem:article];
}


- (void)sortArticlesByDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormat.locale = locale;
    dateFormat.dateFormat = @"MM/dd/yyyy";
    
    self.articleItems = [self.articleItems sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *dateA = [dateFormat dateFromString:((UpcomingItem *)a).pubDate];
        NSDate *dateB = [dateFormat dateFromString:((UpcomingItem *)b).pubDate];
        return [dateB compare:dateA];
    }];
}


- (NSArray *)groupArticlesByMonth {
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    NSDateFormatter *itemDateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    itemDateFormat.locale = locale;
    itemDateFormat.dateFormat = @"MM/dd/yyyy";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.locale = locale;
    dateFormat.dateFormat = @"MMMM yyyy";
    
    NSString *previousItemDate;
    
    for (UpcomingItem *item in self.articleItems) {
        NSDate *itemDate = [itemDateFormat dateFromString:item.pubDate];
        NSString *dateString = [dateFormat stringFromDate:itemDate];
        
        if (!previousItemDate) {
            previousItemDate = dateString;
        }
        
        if ([previousItemDate isEqualToString:dateString]) {
            [items addObject:item];
        } else {
            UpcomingItemsGroup *group = [UpcomingItemsGroup initWithDateKey:previousItemDate andUpcomingItems:items];
            [sections addObject:group];
            
            [items removeAllObjects];
            [items addObject:item];
            previousItemDate = dateString;
        }
    }
    
    //check items for last group
    if (items.count) {
        UpcomingItemsGroup *group = [UpcomingItemsGroup initWithDateKey:previousItemDate andUpcomingItems:items];
        [sections addObject:group];
    }
    
    return sections;
}

@end
