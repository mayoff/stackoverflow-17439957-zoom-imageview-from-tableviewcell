#import "ViewController.h"
#import  "ImageCell.h"

@interface ViewController ()

@property (nonatomic, strong, readonly) UIImageView *zoomedImageView;
@property (nonatomic, strong) NSIndexPath *zoomedIndexPath;

@end

@implementation ViewController

static NSString *const kCellIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ImageCell class] forCellReuseIdentifier:kCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.captionLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    cell.myImageView.image = [UIImage imageNamed:@"Kaz-800.jpg"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.zoomedIndexPath == nil) {
        [self zoomImageAtIndexPath:indexPath];
    }
}

- (void)zoomImageAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = (ImageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    self.zoomedImageView.image = cell.myImageView.image;
    [self.tableView addSubview:self.zoomedImageView];
    self.zoomedImageView.frame = [cell.myImageView convertRect:cell.myImageView.bounds toView:self.zoomedImageView.superview];
    cell.myImageView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.zoomedImageView.frame = self.tableView.bounds;
    }];
    self.tableView.panGestureRecognizer.enabled = NO;
    self.zoomedIndexPath = indexPath;
}

@synthesize zoomedImageView = _zoomedImageView;

- (UIImageView *)zoomedImageView {
    if (!_zoomedImageView) {
        _zoomedImageView = [[UIImageView alloc] init];
        _zoomedImageView.contentMode = UIViewContentModeScaleAspectFit;
        _zoomedImageView.clipsToBounds = YES;
        _zoomedImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewWasTapped)];
        [_zoomedImageView addGestureRecognizer:tapRecognizer];
    }
    return _zoomedImageView;
}

- (void)imageViewWasTapped {
    ImageCell *cell = (ImageCell *)[self.tableView cellForRowAtIndexPath:self.zoomedIndexPath];
    [UIView animateWithDuration:0.3 animations:^{
        self.zoomedImageView.frame = [cell.myImageView convertRect:cell.myImageView.bounds toView:self.zoomedImageView.superview];
    } completion:^(BOOL finished) {
        [self.zoomedImageView removeFromSuperview];
        cell.myImageView.hidden = NO;
        self.zoomedIndexPath = nil;
        self.zoomedImageView.image = nil;
        self.tableView.panGestureRecognizer.enabled = YES;
    }];
}

@end
