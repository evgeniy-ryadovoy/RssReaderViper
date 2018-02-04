//
//  DetailsContract.h
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#ifndef DetailsContract_h
#define DetailsContract_h

@class ArticleEntity;
@class UpcomingItem;
@class UIViewController;

@protocol DetailsView <NSObject>

- (void)showDetailsForArticle:(UpcomingItem *)article;

@end


#pragma mark - Details Interactor (I/O)

@protocol DetailsInteractorOutputInterface <NSObject>

- (void)articleFetched:(ArticleEntity *)article;
- (void)fetchDidFailWithError:(NSString *)errorDescription;

@end


@protocol DetailsInteractorInputInterface <NSObject>

- (void)fetchArticleById:(NSInteger)articleId;

@end


#pragma mark - Details Presenter

@protocol DetailsPresenterInterface <NSObject>

- (void)viewDidLoad;
- (void)didClickBack;

- (void)foundArticle:(UpcomingItem *)article;
- (void)articleSearchDidFailWithError:(NSString *)errorDescription;

@end


#pragma mark - Details View

@protocol DetailsViewInterface <NSObject>

- (void)showUpcomingArticleData:(UpcomingItem *)article;
- (void)showNoData;
- (void)showErrorWithDescription:(NSString *)description;

@end


#pragma mark - Details Wireframe

@protocol DetailsWireframeInterface <NSObject>

- (void)presentArticlesInterface;
- (UIViewController *)detailsViewControllerForItem:(UpcomingItem *)item;

@end

#pragma mark - Details Data Manager

@protocol DetailsDataManagerInterface <NSObject>

- (void)fetchArticlesWithUpcomingItemId:(NSInteger)itemId;

@end

#endif /* DetailsContract_h */
