//
//  ArticlesInteractor.h
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticlesContract.h"

@interface ArticlesInteractor : NSObject <ArticlesInteractorInputInterface, ArticlesInteractorOutputInterface>

@property (weak, nonatomic)   id <ArticlesPresenterInterface> articlesPresenter;
@property (strong, nonatomic) id <ArticlesDataManagerInterface> dataManager;

@end
