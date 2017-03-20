//
//  DetailsWireframe.m
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "DetailsWireframe.h"
#import "DetailsViewController.h"
#import "DetailsPresenter.h"

static NSString *kDetailsControllerIdentifier = @"DetailsViewController";

@implementation DetailsWireframe

- (void)presentArticlesInterface {

}

- (UIViewController *)detailsViewControllerForItem:(UpcomingItem *)item {
    DetailsViewController *detailsViewController = [self detailsViewControllerFromStoryboard];
    detailsViewController.detailsPresenter = self.detailsPresenter;
    self.detailsPresenter.detailsView = detailsViewController;
    self.detailsPresenter.article = item;
    //self.articlesViewController = articlesViewController;
    return detailsViewController;
}


- (DetailsViewController *)detailsViewControllerFromStoryboard {
    UIStoryboard *storyboard = [self mainStoryboard];
    DetailsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:kDetailsControllerIdentifier];
    return viewController;
}


- (UIStoryboard *)mainStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

@end
