//
//  DetailsPresenter.h
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailsContract.h"

@interface DetailsPresenter : NSObject <DetailsPresenterInterface>

@property (strong, nonatomic) id <DetailsWireframeInterface> detailsWireframe;
@property (weak, nonatomic)   id <DetailsViewInterface> detailsView;
@property (strong, nonatomic) id <DetailsInteractorInputInterface> detailsInteractor;

@property (strong, nonatomic) UpcomingItem *article;

@end
