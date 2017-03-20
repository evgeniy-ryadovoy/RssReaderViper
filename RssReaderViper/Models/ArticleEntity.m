//
//  ArticleEntity.m
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "ArticleEntity.h"

@implementation ArticleEntity

- (instancetype)initArticleEntityWithPubDate:(NSDate *)aPubDate
                                       title:(NSString *)aTitle
                                        info:(NSString *)aInfo
                                        link:(NSString *)aLink
{
    
    if (self = [super init]) {
        _pubDate = aPubDate;
        _title   = aTitle;
        _info    = aInfo;
        _link    = aLink;
    }
    
    return self;
}

@end
