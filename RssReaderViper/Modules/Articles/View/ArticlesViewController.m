//
//  ArticlesViewController.m
//  RssReaderViper
//
//  Created by evgeniy on 13/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleTableViewCell.h"
#import "UpcomingItem.h"
#import "UpcomingItemsGroup.h"

@interface ArticlesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSArray <UpcomingItem *> *articleEntries;
@property (nonatomic, copy) NSArray <UpcomingItemsGroup *> *groupedArticles;

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    
    self.title = @"Rss Feed";
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidAppear:(BOOL)animated {
    
    if (!self.articleEntries) {
        [self.articlesPresenter viewDidLoad];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showUpcomingArticlesData:(NSArray *)articles {
    self.articleEntries = articles;
    self.groupedArticles = nil;
    [self.tableView reloadData];
}


- (void)showGroupedArticlesData:(NSArray <UpcomingItemsGroup *> *)groupedArticles {
    self.groupedArticles = groupedArticles;
    self.articleEntries = nil;
    [self.tableView reloadData];
}


- (void)showNoData {
    //show no data info
    
}


- (void)showErrorWithDescription:(NSString *)description {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:description
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    if (self.presentedViewController == nil) {
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (IBAction)plainBtnClicked:(id)sender {
    [self.articlesPresenter plainButtonClicked];
}


- (IBAction)groupedBtnClicked:(id)sender {
    [self.articlesPresenter groupedButtonClicked];
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.groupedArticles) {
        return self.groupedArticles.count;
    }
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.groupedArticles) {
        UpcomingItemsGroup *group = self.groupedArticles[section];
        return group.items.count;
    }
    
    return self.articleEntries.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (self.groupedArticles) {
        UpcomingItemsGroup *group = self.groupedArticles[section];
        return group.dateKey;
    }
    
    return @"Articles";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ArticleTableViewCell";
    UpcomingItem *rssEntry;
    
    if (self.groupedArticles) {
        UpcomingItemsGroup *group = self.groupedArticles[indexPath.section];
        rssEntry = group.items[indexPath.row];
    } else {
        rssEntry = self.articleEntries[indexPath.row];
    }
    
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.title.text = rssEntry.title;
    cell.articleDescription.text = rssEntry.info;
    cell.pubDate.text = rssEntry.pubDate;
    
    return cell;
}


//Hide empty table rows
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.articlesPresenter didSelectArticle:self.articleEntries[indexPath.row]];
}


#pragma mark - Activity Indicator

- (void)showActivityIndicator {
    [self.activityIndicator startAnimating];
    self.activityIndicatorView.hidden = NO;
}


- (void)hideActivityIndicator {
    [self.activityIndicator stopAnimating];
    self.activityIndicatorView.hidden = YES;
}

@end
