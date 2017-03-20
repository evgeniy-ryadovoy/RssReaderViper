//
//  UpcomingItem.h
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>

//Special non-mutable item for presenter
@interface UpcomingItem : NSObject

@property (readonly, assign) NSUInteger itemId;
@property (nonatomic, readonly, copy)   NSString *title;
@property (nonatomic, readonly, copy)   NSString *info;
@property (nonatomic, readonly, strong) NSString *pubDate;
@property (nonatomic, readonly, copy)   NSString *link;

+ (instancetype)upcomingItemWithTitle:(NSString *)aTitle
                                 info:(NSString *)aInfo
                              pubDate:(NSString *)aPubDate
                                 link:(NSString *)aLink
                               itemId:(NSUInteger)aItemId;

@end
