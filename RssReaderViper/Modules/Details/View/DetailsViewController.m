//
//  DetailsViewController.m
//  RssReaderViper
//
//  Created by evgeniy on 14/03/2017.
//  Copyright © 2017 evgeniy. All rights reserved.
//

#import "DetailsViewController.h"
#import "UpcomingItem.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@property (nonatomic, copy) NSString *urlSource;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Details";
    // Do any additional setup after loading the view from its nib.
    [self.detailsPresenter viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showUpcomingArticleData:(UpcomingItem *)article {
    self.titleLabel.text = article.title;
    self.pubDateLabel.text = article.pubDate;
    self.infoTextView.text = article.info;
    self.urlSource = article.link;
}


- (void)showNoData {
    self.titleLabel.text = @"No data";
    self.pubDateLabel.text = @"";
    self.infoTextView.text = @"";
    self.urlSource = @"";
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


- (IBAction)showMore:(id)sender {
    NSURL *url = [NSURL URLWithString:self.urlSource];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        [self showErrorWithDescription:@"Failed to open url"];
    }
}

@end
