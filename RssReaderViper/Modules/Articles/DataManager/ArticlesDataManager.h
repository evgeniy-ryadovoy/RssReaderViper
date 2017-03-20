//
//  ArticlesDateManager.h
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticlesContract.h"

@interface ArticlesDataManager : NSObject <ArticlesDataManagerInterface>

@property (weak, nonatomic) id <ArticlesInteractorOutputInterface> articlesInteractor;

@end
