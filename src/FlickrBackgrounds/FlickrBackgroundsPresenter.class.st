Class {
	#name : #FlickrBackgroundsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'searchButton',
		'fullscreen',
		'keyword',
		'flickrBackgrounds'
	],
	#category : #FlickrBackgrounds
}

{ #category : #accessing }
FlickrBackgroundsPresenter >> alertNextPhotoNotFound [
	^ Smalltalk uiManager alert: 'Can''t find a photo'
]

{ #category : #initialization }
FlickrBackgroundsPresenter >> initialize [
	super initialize.
	flickrBackgrounds := FlickrBackgrounds new
]

{ #category : #initialization }
FlickrBackgroundsPresenter >> initializeFullscreen [

	fullscreen := self newCheckBox label: 'Adjust for fullscreen?'; yourself
]

{ #category : #initialization }
FlickrBackgroundsPresenter >> initializeKeyword [

	keyword := self newText
		        placeholder: 'keyword';
		        beNotWrapWord;
		        withoutScrollBars;
		        yourself
]

{ #category : #initialization }
FlickrBackgroundsPresenter >> initializeLayout [

	| isFullscreen boxLayout |
	isFullscreen := Display isFullscreen.
	boxLayout := SpBoxLayout newTopToBottom
		             add: #keyword;
		             yourself.
	isFullscreen ifFalse: [ boxLayout add: #fullscreen ].
	boxLayout addLast: #searchButton.
	self layout: boxLayout
]

{ #category : #initialization }
FlickrBackgroundsPresenter >> initializePresenters [
	self initializeKeyword.
	self initializeFullscreen.
	self initializeSearchButton.
	self initializeLayout
]

{ #category : #initialization }
FlickrBackgroundsPresenter >> initializeSearchButton [

	searchButton := self newButton
		                iconName: #search;
		                label: 'Surprise me!';
		                action: [ self search ]
]

{ #category : #initialization }
FlickrBackgroundsPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'New Background';
		initialExtent: 320 @ (self presenters size * 45);
		windowIcon: (self iconNamed: #paint);
		beNotResizable;
		centered;
		yourself
]

{ #category : #accessing }
FlickrBackgroundsPresenter >> search [
	| query |

	query := keyword text trimBoth.
	flickrBackgrounds query: query.
	flickrBackgrounds nextPhoto
		ifNil: [ self alertNextPhotoNotFound ]
		ifNotNil: [ :aForm | self setBackground: aForm ]
]

{ #category : #accessing }
FlickrBackgroundsPresenter >> setBackground: aForm [
	fullscreen state ifTrue: [ Display fullscreen: true ].
	self currentWorld backgroundImage: aForm layout: #fitAspect.
	fullscreen state ifTrue: [ 
		[ 
		1 seconds wait.
		Display fullscreen: false ] fork ]
]
