//
//  UpcomingItemsGroup.h
//  RssReaderViper
//
//  Created by evgeniy on 18/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UpcomingItem;

@interface UpcomingItemsGroup : NSObject

@property (readonly, nonatomic, copy) NSString *dateKey;
@property (readonly, nonatomic, copy) NSArray <UpcomingItem *> *items;

+ (instancetype)initWithDateKey:(NSString *)aDateKey andUpcomingItems:(NSArray <UpcomingItem *> *)aItems;

@end
