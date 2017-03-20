//
//  ArticleParseOperation.m
//  RssReaderViper
//
//  Created by evgeniy on 11/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "ArticleParseOperation.h"
#import "ArticleEntity.h"

static NSString *kDateFormat = @"E, d MMM yyyy HH:mm:ss zzz";

@interface ArticleParseOperation () <NSXMLParserDelegate>

@property (nonatomic) ArticleEntity *currentRssEntry;
@property (nonatomic) NSString *currentParseElement;
@property (nonatomic) NSMutableArray *currentParseBatch;

@property (nonatomic) NSMutableString *itemTitle;
@property (nonatomic) NSMutableString *itemLink;
@property (nonatomic) NSMutableString *itemDescription;
@property (nonatomic) NSMutableString *itemPubDate;

// a stack queue containing  elements as they are being parsed, used to detect malformed XML.
@property (nonatomic, strong) NSMutableArray *elementStack;

@end

@implementation ArticleParseOperation

- (instancetype)init {
    
    NSAssert(NO, @"Invalid use of init; use initWithData to create RssFeedParser");
    return [self init];
}


- (instancetype)initWithData:(NSData *)parseData {
    self = [super init];
    
    if (self != nil && parseData != nil) {
        _rssFeedData = [parseData copy];
        _currentParseBatch = [[NSMutableArray alloc] init];
        _elementStack = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)rssFeedsParsed:(NSArray *)feedEntries {
    
    assert([NSThread isMainThread]);
    
    [self.delegate parseOperationEntriesDidParse:feedEntries];
}


// The main function for this NSOperation, to start the parsing.
- (void)main {
    /*
     It's also possible to have NSXMLParser download the data, by passing it a URL,
     but it gives less control over the network
     */
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.rssFeedData];
    parser.delegate = self;
    [parser parse];
    
    if (self.currentParseBatch.count) {
        [self performSelectorOnMainThread:@selector(rssFeedsParsed:) withObject:self.currentParseBatch waitUntilDone:YES];
    }
}


#pragma mark - Parser constants
// Reduce potential parsing errors by using string constants declared in a single place.
static NSString *kEntryElementName = @"item";
static NSString *kElementTitle   = @"title";
static NSString *kElementDesc    = @"description";
static NSString *kElementLink    = @"link";
static NSString *kElementPubDate = @"pubDate";


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    // add the element to the state stack
    [self.elementStack addObject:elementName];
    
    self.currentParseElement = elementName;
    
    if ([elementName isEqualToString:kEntryElementName]) {
        self.itemTitle       = [[NSMutableString alloc] init];
        self.itemLink        = [[NSMutableString alloc] init];
        self.itemDescription = [[NSMutableString alloc] init];
        self.itemPubDate     = [[NSMutableString alloc] init];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([self.currentParseElement isEqualToString:kElementTitle]) {
        [self.itemTitle appendString:string];
    }
    else if ([self.currentParseElement isEqualToString:kElementLink]) {
        [self.itemLink appendString:string];
    }
    else if ([self.currentParseElement isEqualToString:kElementDesc]) {
        [self.itemDescription appendString:string];
    }
    else if ([self.currentParseElement isEqualToString:kElementPubDate]) {
        [self.itemPubDate appendString:string];
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    // check if the end element matches what's last on the element stack
    if ([elementName isEqualToString:self.elementStack.lastObject]) {
        // they match, remove it
        [self.elementStack removeLastObject];
    } else {
        // they don't match, we have malformed XML
        [self.elementStack removeAllObjects];
        [parser abortParsing];
    }
    
    if ([elementName isEqualToString:kEntryElementName]) {
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormat.locale = locale;
        dateFormat.dateFormat = kDateFormat;
        NSString *trimmedDate = [self.itemPubDate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSDate *pubDate = [dateFormat dateFromString:trimmedDate];
        
        NSString *trimmedLink = [self.itemLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        ArticleEntity *entry = [[ArticleEntity alloc] initArticleEntityWithPubDate:pubDate
                                                                             title:self.itemTitle
                                                                              info:self.itemDescription
                                                                              link:trimmedLink];
        [self.currentParseBatch addObject:entry];
    }
}


// An error occurred while parsing the rss feed data: post the error as an NSNotification to our app delegate.
- (void)handleRssFeedsError:(NSError *)parseError {
    
    assert([NSThread isMainThread]);
    
    [self.delegate parseOperationErrorDidOccur:parseError];
}


// An error occurred while parsing the rss feed data, pass the error to the main thread for handling.
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    if (parseError.code != NSXMLParserDelegateAbortedParseError) {
        [self.currentParseBatch removeAllObjects];
        [self performSelectorOnMainThread:@selector(handleRssFeedsError:) withObject:parseError waitUntilDone:NO];
    }
}

@end
