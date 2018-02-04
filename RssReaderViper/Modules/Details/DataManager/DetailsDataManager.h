//
//  DetailsDataManager.h
//  RssReaderViper
//
//  Created by evgeniy on 16/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailsContract.h"
@class LocalStorageService;

@interface DetailsDataManager : NSObject <DetailsDataManagerInterface>

@property (weak, nonatomic) id <DetailsInteractorOutputInterface> detailsInteractor;

- (instancetype)initWithStorageService:(LocalStorageService *)aStorageService;

@end
