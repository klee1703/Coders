//
//  Person.m
//  Coders
//
//  Created by Keith Lee on 6/16/13.
//  Copyright (c) 2013 Keith Lee. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//   1. Redistributions of source code must retain the above copyright notice, this list of
//      conditions and the following disclaimer.
//
//   2. Redistributions in binary form must reproduce the above copyright notice, this list
//      of conditions and the following disclaimer in the documentation and/or other materials
//      provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY Keith Lee ''AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Keith Lee OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of Keith Lee.

#import "Person.h"
#define CodersErrorDomain   @"CodersErrorDomain"
#define kInvalidValueError  1

@implementation Person

- (id)initWithFirstName:(NSString *)fname lastName:(NSString *)lname
{
  if ((self = [super init]))
  {
    _firstName = fname;
    _lastName = lname;
  }
  
  return self;
}

- (NSString *)fullName
{
  return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (BOOL)validateLastName:(id *)value error:(NSError * __autoreleasing *)error
{
  if (*value == nil)
  {
    if (error != NULL)
    {
      NSDictionary *reason = @{NSLocalizedDescriptionKey:@"Last name cannot be nil"};
      *error = [NSError errorWithDomain:CodersErrorDomain
                                   code:kInvalidValueError
                               userInfo:reason];
    }
    return NO;
  }
  NSUInteger length = [[(NSString *)*value stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]] length];
  if (length == 0)
  {
    if (error != NULL)
    {
      NSDictionary *reason = @{NSLocalizedDescriptionKey:@"Last name cannot be empty"};
      *error = [NSError errorWithDomain:CodersErrorDomain
                                   code:kInvalidValueError
                               userInfo:reason];
    }
    return NO;
  }
  return YES;
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
  NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
  if ([key isEqualToString:@"fullName"])
  {
    NSArray *affectingKeys = @[@"firstName", @"lastName"];
    keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
  }
  
  return keyPaths;
  
}

@end
