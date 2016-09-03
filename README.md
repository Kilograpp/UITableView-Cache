[![Build Status](https://travis-ci.org/Kilograpp/UITableView-Cache.svg?branch=master)](https://travis-ci.org/Kilograpp/UITableView-Cache)
[![Pod Version](https://img.shields.io/cocoapods/v/UITableView+Cache.svg?style=flat)](http://cocoadocs.org/docsets/UITableView+Cache/)
[![codebeat badge](https://codebeat.co/badges/1c7930d9-7431-49ff-989c-f906779f00bc?t=)](https://codebeat.co/projects/github-com-kilograpp-uitableview-cache)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Kilograpp/UITableView-Cache)

# UITableView + Cache
[https://github.com/Kilograpp/UITableView-Cache](https://github.com/Kilograpp/UITableView-Cache)

UITableView cell cache that cures scroll-lags on a cell instantiating. 

## Introduction

`UITableView+Cache` is a light `UITableView` category that purges scroll-lag that occurs on a new cell instantiation during scroll. 
It makes UITableView instantiate and cache cells before cellForRow:atIndexPath: call. It also provides simple interface very similar to existing registerClass/registerNib one. 

## Installation

### CocoaPods

```
pod 'UITableView+Cache'
```

### Carthage

```
github "Kilograpp/UITableView-Cache" "master"
```

### Manual importing

Just add all files from src directory to your project.


## Usage

When registering custom cells, call overriden registerClass/registerNib method instead of a default. `UITableView+Cache` swizzles dequeueReusableCellWithIdentifier methods with a private one that uses its own cache and implements registerClass/registerNib mechanism on itself. 
When dequeueReusableCellWithIdentifier is called and returns nil - the cache is asked for a cell. If cache is empty then cell is created using registered class or nib.

#### Swift
	
	import UITableView_Cache

	...

	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.registerClass(TableViewCodeCell.self, forCellReuseIdentifier: "MyReuseIdentifier", cacheSize: 10)
		self.tableView.registerNib(TableViewCodeCell.nib, forCellReuseIdentifier: "MyReuseIdentifier", cacheSize: 10)
	}

	...

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCellWithIdentifier("MyReuseIdentifier") as! TableViewCodeCell
		return cell
	}


#### Objective-C

	- (void)viewDidLoad {
		[super viewDidLoad];

		[self.tableView registerClass:[TableViewCodeCell class] forCellReuseIdentifier:@"MyReuseIdentifier" cacheSize:10];
		[self.tableView registerNib:[TableViewNibCell nib] forCellReuseIdentifier:@"MyNibReuseIdentifier" cacheSize:10];
	}

	...

	- (MyCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
		MyCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MyReuseIdentifier"];
		return cell;
	}
	
Make sure to call dequeueReusableCellWithIdentifier:reuseIdentifier method and **NOT** dequeueReusableCellWithIdentifier:reuseIdentifier:**forIndexPath:** one. They perform different logic and a crash will occure on wrong method use. 

## License

UITableView+Cache is available under the MIT license. See the LICENSE file for more info.

## Author

[Mehdzor](https://github.com/mehdzor)
