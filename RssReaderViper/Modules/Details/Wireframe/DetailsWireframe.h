//
//  DetailsWireframe.h
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsContract.h"

@class DetailsPresenter;

@interface DetailsWireframe : NSObject <DetailsWireframeInterface>

//@property (weak, nonatomic) ArticlesWireframe *detailsWireframe;
@property (nonatomic, strong) DetailsPresenter *detailsPresenter;
//@property (nonatomic, strong) RootWireframe *rootWireframe;

@end
