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

### Manual importing

Just add both files from src directory to your project.


## Usage

When registering custom cells, call overriden registerClass/registerNib method instead of a default. `UITableView+Cache` swizzles dequeueReusableCellWithIdentifier methods with a private one that uses its own cache and implements registerClass/registerNib mechanism on itself. 
When dequeueReusableCellWithIdentifier is called and returns nil - the cache is asked for a cell. If cache is empty then cell is created using registered class or nib.

#### Example

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
