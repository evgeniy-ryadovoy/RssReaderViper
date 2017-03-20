//
//  ArticlesPresenter.h
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticlesContract.h"
#import "ArticlesWireframe.h"

@interface ArticlesPresenter : NSObject <ArticlesPresenterInterface>

@property (strong, nonatomic) ArticlesWireframe *articlesWireframe;
@property (weak, nonatomic)   id <ArticlesViewInterface> articlesView;
@property (strong, nonatomic) id <ArticlesInteractorInputInterface> articlesInteractor;

@end
