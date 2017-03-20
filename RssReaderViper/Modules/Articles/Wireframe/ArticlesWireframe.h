//
//  ArticlesWireframe.h
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailsWireframe;
@class ArticlesPresenter;
@class RootWireframe;
@class UpcomingItem;

@interface ArticlesWireframe : NSObject

@property (nonatomic, strong) DetailsWireframe *detailsWireframe;
@property (nonatomic, strong) ArticlesPresenter *articlesPresenter;
@property (nonatomic, strong) RootWireframe *rootWireframe;

- (void)presentListInterfaceFromWindow:(UIWindow *)window;
- (void)presentDetialsInterfaceForItem:(UpcomingItem *)article;

@end
