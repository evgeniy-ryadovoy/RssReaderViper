//
//  AppDependencies.m
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "AppDependencies.h"
#import "ArticlesWireframe.h"
#import "ArticlesPresenter.h"
#import "ArticlesInteractor.h"
#import "ArticlesDataManager.h"
#import "RootWireframe.h"

#import "DetailsWireframe.h"
#import "DetailsPresenter.h"
#import "DetailsInteractor.h"
#import "DetailsDataManager.h"

#import "NetworkService.h"
#import "LocalStorageService.h"

@interface AppDependencies ()

@property (nonatomic, strong) ArticlesWireframe *articlesWireframe;

@end

@implementation AppDependencies

- (id)init {
    
    if ((self = [super init])) {
        [self configureDependencies];
    }
    
    return self;
}


- (void)installRootViewControllerIntoWindow:(UIWindow *)window {
    [self.articlesWireframe presentListInterfaceFromWindow:window];
}


- (void)configureDependencies
{
    //Network Service
    NetworkService *networkService = [[NetworkService alloc] init];

    //Local Storage Service
    LocalStorageService *storageService = [[LocalStorageService alloc] init];

    // Root Level Classes
    RootWireframe *rootWireframe = [[RootWireframe alloc] init];
    
    // Articles Module Classes
    ArticlesWireframe *articlesWireframe = [[ArticlesWireframe alloc] init];
    ArticlesPresenter *articlesPresenter = [[ArticlesPresenter alloc] init];
    ArticlesDataManager *articlesDataManager = [[ArticlesDataManager alloc] initWithNetworkService:networkService
                                                                                 andStorageService:storageService];
    ArticlesInteractor *articlesInteractor = [[ArticlesInteractor alloc] init];
    
    // Details Module Classes
    DetailsWireframe *detailsWireframe = [[DetailsWireframe alloc] init];
    DetailsInteractor *detailsInteractor = [[DetailsInteractor alloc] init];
    DetailsPresenter *detailsPresenter = [[DetailsPresenter alloc] init];
    DetailsDataManager *detailsDataManager = [[DetailsDataManager alloc] initWithStorageService:storageService];
    
    // Articles Module Classes
    articlesInteractor.articlesPresenter = articlesPresenter;
    articlesInteractor.dataManager = articlesDataManager;
    
    articlesPresenter.articlesInteractor = articlesInteractor;
    articlesPresenter.articlesWireframe = articlesWireframe;
    
    articlesWireframe.articlesPresenter = articlesPresenter;
    articlesWireframe.rootWireframe = rootWireframe;
    articlesWireframe.detailsWireframe = detailsWireframe;
    _articlesWireframe = articlesWireframe;
    
    articlesDataManager.articlesInteractor = articlesInteractor;
    
    // Details Module Classes
    detailsInteractor.detailsDataManger = detailsDataManager;
    detailsPresenter.detailsInteractor = detailsInteractor;
    detailsInteractor.detailsPresenter = detailsPresenter;
    detailsWireframe.detailsPresenter = detailsPresenter;
    detailsDataManager.detailsInteractor = detailsInteractor;
    
    detailsPresenter.detailsWireframe = detailsWireframe;
}

@end
