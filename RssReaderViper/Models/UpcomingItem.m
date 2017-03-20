//
//  UpcomingItem.m
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "UpcomingItem.h"

@interface UpcomingItem ()

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *info;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, copy)   NSString *link;
@property (assign) NSUInteger itemId;

@end

@implementation UpcomingItem

+ (instancetype)upcomingItemWithTitle:(NSString *)aTitle
                                 info:(NSString *)aInfo
                              pubDate:(NSString *)aPubDate
                                 link:(NSString *)aLink
                               itemId:(NSUInteger)aItemId
{
    UpcomingItem *item = [[self alloc] init];
    
    item.title = aTitle;
    item.info = aInfo;
    item.pubDate = aPubDate;
    item.link = aLink;
    item.itemId = aItemId;
    
    return item;
}

@end
