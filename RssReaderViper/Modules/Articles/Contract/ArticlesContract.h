//
//  ArticlesContract.h
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

@class ArticleEntity;
@class UpcomingItem;
@class UpcomingItemsGroup;

#ifndef ArticlesContract_h
#define ArticlesContract_h

//Not an apple-way naming but it used for interface

#pragma mark - Articles Interactor (I/O)

@protocol ArticlesInteractorOutputInterface <NSObject>

- (void)articlesFetched:(NSArray <ArticleEntity *> *)articles;
- (void)fetchDidFailWithError:(NSError *)error;

@end


@protocol ArticlesInteractorInputInterface <NSObject>

- (void)fetchArticles;

@end


#pragma mark - Articles Data Manager

@protocol ArticlesDataManagerInterface <NSObject>

- (void)fetchAllArticles;

@end


#pragma mark - Articles Presenter

@protocol ArticlesPresenterInterface <NSObject>

- (void)viewDidLoad;
- (void)didSelectArticle:(UpcomingItem *)article;
- (void)plainButtonClicked;
- (void)groupedButtonClicked;

- (void)foundArticles:(NSArray <UpcomingItem *> *)articles;
- (void)articlesSearchDidFailWithError:(NSString *)errorDescription;

@end


#pragma mark - Articles View

@protocol ArticlesViewInterface <NSObject>

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

- (void)showUpcomingArticlesData:(NSArray *)articles;
- (void)showNoData;
- (void)showErrorWithDescription:(NSString *)description;

@optional

- (void)showGroupedArticlesData:(NSArray <UpcomingItemsGroup *> *)groupedArticles;

@end

#endif /* ArticlesContract_h */
