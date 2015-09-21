//
//  DBSETimelineTableViewCell.h
//  dbstandupemail
//
//  Created by Daniele Bogo on 21/09/2015.
//  Copyright © 2015 Daniele Bogo. All rights reserved.
//

@import UIKit;

#import "UITableViewCell+Identifier.h"


@interface DBSETimelineTableViewCell : UITableViewCell

- (void)setUserName:(NSString *)userName userPicture:(NSString *)userPicture;
- (void)setUserMessage:(NSString *)message icon:(NSString *)icon;

@end