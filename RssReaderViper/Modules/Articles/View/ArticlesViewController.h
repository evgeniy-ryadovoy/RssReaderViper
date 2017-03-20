//
//  ArticlesViewController.h
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesContract.h"

@interface ArticlesViewController : UIViewController <ArticlesViewInterface>

@property (strong, nonatomic) id <ArticlesPresenterInterface> articlesPresenter;

@end
