# MXToast-in-Objective-C

`MXToast` is an Android like alert view.

## Installation with CocoaPods

```
pod 'MXToast'
```

## Usage

```
#import "MXToast.h"
```

```
[[MXToast toast:@"Toast with NSString"] show];

[[MXToast toast:@"You can set duration if you like" duration:5] show];

[[MXToast toast:@"Also delay" delay:0 duration:5] show];

[[MXToast toastWithFormat:@"%@\nrandom number %zd", self.title, arc4random_uniform(20000)] show];
```
