//
//  DoneViewController.h
//  Todo List
//
//  Created by Donia Ashraf on 4/5/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController
<UITableViewDataSource ,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *doneTable;

@end

NS_ASSUME_NONNULL_END
