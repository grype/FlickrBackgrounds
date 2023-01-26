Class {
	#name : #FlickrBackgroundsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'searchButton',
		'fullscreen',
		'keyword'
	],
	#category : #FlickrBackgrounds
}

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
	(query
		 ifEmpty: [ FlickrBackgrounds randomImageUrl ]
		 ifNotEmpty: [ FlickrBackgrounds randomImageUrlForQuery: query ])
		ifNil: [ self alert: 'Sorry, couldn''t find anything!' ]
		ifNotNil: [ :url | self setBackgroundFromUrl: url ]
]

{ #category : #accessing }
FlickrBackgroundsPresenter >> setBackgroundFromUrl: aUrl [

	fullscreen state ifTrue: [ Display fullscreen: true ].
	self currentWorld
		backgroundImage:
		(Form fromBinaryStream: (ZnEasy get: aUrl asUrl) entity readStream)
		layout: #fitAspect.
	fullscreen state ifTrue: [ 
		[ 
		1 seconds wait.
		Display fullscreen: false ] fork ]
]
