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

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked  = [aDecoder decodeBoolForKey:@"Checked"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

@end
