# FlickrBackgrounds
Tiny tool to set Pharo's world background to a random image using Flickr API.

```smalltalk
Metacello new   
    baseline: 'FlickrBackgrounds';     
    onWarningLog;
    repository: 'github://grype/FlickrBackgrounds:main/src';
    load.

"Get yourself an API key on https://www.flickr.com/services/apps/create/"
"And set it in Settings/Tools, or programatically:"
FlickrBackgrounds apiKey: ''.

"Open the UI"
FlickrBackgroundsPresenter new open.
```
