//
//  DetailsInteractor.h
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailsContract.h"

@interface DetailsInteractor : NSObject <DetailsInteractorOutputInterface, DetailsInteractorInputInterface>

@property (weak, nonatomic) id <DetailsPresenterInterface> detailsPresenter;
@property (strong, nonatomic) id <DetailsDataManagerInterface> detailsDataManger;

@end
