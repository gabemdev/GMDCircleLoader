# GMDCircleLoader
GMDCircleLoader is a neat and easy to use loading view meant to replicate Apple’s progress loading view of an ongoing task. 

![GMDCircleLoader](http://cl.ly/YmrY/GMDCircleLoader.gif)

## Installation
* Drag the `GMDCircleLoader/GMDCircleLoader` folder into your project.
* Add the **QuartzCore** framework to your project.
* Update the definitions on your Header file if necessary.
* #import “GMDCircleLoader.h” on your implementation file or add it to your projects prefix file.

## Usage
(see sample Xcode project)

**Use GMDCircleLoader wisely! Bad use case examples: pull to refresh, infinite scrolling, sending message.**

Using GMDCircleLoader in your app will usually look as simple as this:
```objective-c
- (void)loginTwitter:(id)sender {
[GMDCircleLoading setOnView:self.view withTitle@"Loading..." animated:YES];
[[Twitter sharedInstance] loginWithCompletion:^(TWTRSession *session, NSError *error) {
    if (session) {
        [GMDCircleLoading hideHUDFromView:self.view animated:YES];
                }
}
```
### Showing the loading view
You can show the status of indeterminate tasks using one of the following:
```objective-c
+ (GMDCircleLoader *)setOnView:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated;
```
### Dismissing the loading view
It can be dismissed right away using:
```objective-c
+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated;
```

### Alternate views
You can include an image to show in the middle of the loading circle by simply uncommenting: 
```objective-c
        UIImageView *img = [[UIImageView alloc] initWithFrame:GMD_SPINNER_IMAGE];
        img.image = GMD_IMAGE;
        hud.center = img.center;
        [hud addSubview:img];
```

### Updates pending
* Create singleton
* Create additional status options, including no label loader.
* Reduce view frame from bounds to something more manageable.

## Contributing to this project
If you have feature requests or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/gabemdev/GMDCircleLoader/issues/new). 

Please take a moment to review the guidelines written by [Nicolas Gallagher](https://github.com/necolas/):
* [Bug reports](https://github.com/necolas/issue-guidelines/blob/master/CONTRIBUTING.md#bugs)
* [Feature requests](https://github.com/necolas/issue-guidelines/blob/master/CONTRIBUTING.md#features)
* [Pull requests](https://github.com/necolas/issue-guidelines/blob/master/CONTRIBUTING.md#pull-requests)

## Credits
GMDCircleLoader is brought to you by [Gabe Morales](http://gabemdev.com) and [contributors to the project](https://github.com/gabemdev/GMDCircleLoader/contributors). 

If you're using GMDCircleLoader in your project, attribution would be nice.

## License
GMDCircleLoader is released under MIT License.
