//
//  DetailsViewController.h
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsContract.h"

@interface DetailsViewController : UIViewController <DetailsViewInterface>

@property (strong, nonatomic) id <DetailsPresenterInterface> detailsPresenter;


@end
