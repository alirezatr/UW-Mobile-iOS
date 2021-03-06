#import "NewsViewController.h"
#import "NewsDetailsViewController.h"
#import "NewsCell.h"

#import "AppDelegate.h"

static NSString *const kNewsTitle = @"NEWS";

@interface NewsViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = kNewsTitle;
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.appDelegate.news count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NewsCell class])
                                                     forIndexPath:indexPath];

    [(NewsCell *)cell configureWithNews:self.appDelegate.news[indexPath.row]];

    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UWNews *news = self.appDelegate.news[indexPath.row];
    return CGSizeMake(CGRectGetWidth(collectionView.frame), [NewsCell heightWithNews:news]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"ShowNewsDetails"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        UWNews *news = self.appDelegate.news[indexPath.row];
        NewsDetailsViewController *detailsViewController = [segue destinationViewController];
        [detailsViewController configureWithNews:news];
    }
}

@end
