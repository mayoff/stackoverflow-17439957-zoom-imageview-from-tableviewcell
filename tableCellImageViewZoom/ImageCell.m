#import "ImageCell.h"

@implementation ImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *contentView = self.contentView;
        self.captionLabel = [[UILabel alloc] init];
        self.captionLabel.numberOfLines = 1;
        self.captionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.captionLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.captionLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.captionLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.captionLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [contentView addSubview:self.captionLabel];
        self.myImageView = [[UIImageView alloc] init];
        self.myImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.myImageView.clipsToBounds = YES;
        [contentView addSubview:self.myImageView];
        NSDictionary *views = NSDictionaryOfVariableBindings(_captionLabel, _myImageView);
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.captionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.myImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.myImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.myImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.myImageView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_captionLabel(==40)][_myImageView]|" options:0 metrics:0 views:views]];
    }
    return self;
}

@end
