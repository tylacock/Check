//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by Lacock, Ty on 1/16/14.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

@end
