//
//  DetailsPresenter.m
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "DetailsPresenter.h"
#import "UpcomingItem.h"

@implementation DetailsPresenter

/*- (void)didRequestRssArticleWithId:(NSInteger)itemId {
    [self.detailsInteractor fetchArticleById:itemId];
}*/

- (void)viewDidLoad {
    
    // Get article with full description
    [self.detailsInteractor fetchArticleById:self.article.itemId];
}


- (void)foundArticle:(UpcomingItem *)article {
    [self.detailsView showUpcomingArticleData:article];
}


- (void)articleSearchDidFailWithError:(NSString *)errorDescription {
    [self.detailsView showErrorWithDescription:errorDescription];
}


- (void)didClickBack {
    [self.detailsWireframe presentArticlesInterface];
}

@end
