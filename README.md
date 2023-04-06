# FlickrBackgrounds

Tiny tool to set Pharo's world background to a random image using Flickr API

# Quick Start

## Installation via Script

```Smalltalk
Metacello new 
	repository: 'github://grype/FlickrBackgrounds:main/src';
	baseline: 'FlickrBackgrounds';
	load
```

## API Keys

To set the API key (see https://www.flickr.com/services/apps/create/)

```Smalltalk
FlickrBackgrounds apiKey: ''.
```

## UI

To open a simple UI for changing the background image

```Smalltalk
FlickrBackgroundsPresenter new open.
```