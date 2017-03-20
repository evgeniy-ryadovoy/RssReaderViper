//
//  UpcomingItemsGroup.m
//  RssReaderViper
//
//  Created by evgeniy on 18/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "UpcomingItemsGroup.h"
#import "UpcomingItem.h"

@interface UpcomingItemsGroup ()

@property (nonatomic, copy) NSString *dateKey;
@property (nonatomic, copy) NSArray <UpcomingItem *> *items;

@end

@implementation UpcomingItemsGroup

+ (instancetype)initWithDateKey:(NSString *)aDateKey andUpcomingItems:(NSArray <UpcomingItem *> *)aItems {

    UpcomingItemsGroup *group = [[self alloc] init];
    
    group.dateKey = aDateKey;
    group.items = aItems;
    
    return group;
}

@end
