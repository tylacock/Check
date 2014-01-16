//
//  ChecklistItem.m
//  Checklists
//
//  Created by Lacock, Ty on 1/16/14.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

- (void)toggleChecked
{
  self.checked = !self.checked;
}

@end
