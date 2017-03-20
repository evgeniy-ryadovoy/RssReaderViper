//
//  ArticlesWireframe.m
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "ArticlesWireframe.h"
#import "ArticlesViewController.h"
#import "ArticlesPresenter.h"
#import "RootWireframe.h"
#import "DetailsWireframe.h"
#import "LocalStorageService.h"
#import "UpcomingItem.h"

static NSString *kArticlesControllerIdentifier = @"ArticlesViewController";

@interface ArticlesWireframe ()

@property (nonatomic, strong) ArticlesViewController *articlesViewController;

@end

@implementation ArticlesWireframe

- (void)presentListInterfaceFromWindow:(UIWindow *)window {
    ArticlesViewController *articlesViewController = [self articlesViewControllerFromStoryboard];
    articlesViewController.articlesPresenter = self.articlesPresenter;
    self.articlesPresenter.articlesView = articlesViewController;
    self.articlesViewController = articlesViewController;
    
    [self.rootWireframe showRootViewController:articlesViewController
                                      inWindow:window];
}


- (void)presentDetialsInterfaceForItem:(UpcomingItem *)article {
    UIViewController *detailsViewController = [self.detailsWireframe detailsViewControllerForItem:article];
    [self.articlesViewController.navigationController pushViewController:detailsViewController animated:YES];
}


- (ArticlesViewController *)articlesViewControllerFromStoryboard {
    UIStoryboard *storyboard = [self mainStoryboard];
    ArticlesViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:kArticlesControllerIdentifier];
    return viewController;
}

- (UIStoryboard *)mainStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

@end
