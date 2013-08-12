//
//  main.m
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

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Coder.h"
#import "Coders.h"

int main(int argc, const char * argv[])
{
  @autoreleasepool
  {
    Person *curly = [[Person alloc] initWithFirstName:@"Curly" lastName:@"Howard"];
    NSLog(@"Person first name: %@", [curly valueForKey:@"firstName"]);
    NSLog(@"Person full name: %@", [curly valueForKey:@"fullName"]);
    NSArray *langs1 = @[@"Objective-C", @"C"];
    Coder *coder1 = [Coder new];
    coder1.person = curly;
    coder1.languages = [langs1 mutableCopy];
    NSLog(@"\nCoder name: %@\n\t  languages: %@",
          [coder1 valueForKeyPath:@"person.fullName"],
          [coder1 valueForKey:@"languages"]);
    
    Coder *coder2 = [Coder new];
    coder2.person = [[Person alloc] initWithFirstName:@"Larry" lastName:@"Fine"];
    coder2.languages = [@[@"Objective-C", @"C++"] mutableCopy];
    NSLog(@"\nCoder name: %@\n\t  languages: %@",
          [coder2 valueForKeyPath:@"person.fullName"],
          [coder2 valueForKey:@"languages"]);
    
    [curly addObserver:coder1
            forKeyPath:@"fullName"
               options:NSKeyValueObservingOptionNew
               context:NULL];
    curly.lastName = @"Fine";
    [curly removeObserver:coder1 forKeyPath:@"fullName"];
    
    Coders *bestCoders = [Coders new];
    bestCoders.developers = [[NSSet alloc] initWithArray:@[coder1, coder2]];
    [bestCoders valueForKey:@"developers"];
    NSLog(@"Number of coders = %@", [bestCoders.developers valueForKeyPath:@"@count"]);
    
    NSError *error;
    NSString *emptyName = @"";
    BOOL valid = [curly validateValue:&emptyName forKey:@"lastName" error:&error];
    if (!valid)
    {
      NSLog(@"Error: %@", ([error userInfo])[NSLocalizedDescriptionKey]);
    }
  }
  return 0;
}

