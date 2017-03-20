//
//  ArticleEntity.h
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleEntity : NSObject

@property (readonly, nonatomic, strong) NSDate *pubDate;
@property (readonly, nonatomic, copy)   NSString *title;
@property (readonly, nonatomic, copy)   NSString *info;
@property (readonly, nonatomic, copy)   NSString *link;

- (instancetype)initArticleEntityWithPubDate:(NSDate *)aPubDate
                                       title:(NSString *)aTitle
                                        info:(NSString *)ainfo
                                        link:(NSString *)aLink;

@end
