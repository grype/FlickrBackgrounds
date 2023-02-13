Class {
	#name : #FlickrBackgrounds,
	#superclass : #Object,
	#instVars : [
		'generator',
		'query'
	],
	#classInstVars : [
		'PreferredWidth',
		'PreferredHeight',
		'APIKey',
		'Enabled',
		'SampleSize'
	],
	#category : #FlickrBackgrounds
}

{ #category : #accessing }
FlickrBackgrounds class >> apiKey [

	^ APIKey
]

{ #category : #accessing }
FlickrBackgrounds class >> apiKey: anObject [

	APIKey := anObject
]

{ #category : #settings }
FlickrBackgrounds class >> apiKeySettingsOn: builder [

	(builder setting: #backgroundsFlickrAPIKey)
		label: 'API Token';
		target: self;
		selector: #apiKey;
		description: 'Flickr API Key'
]

{ #category : #accessing }
FlickrBackgrounds class >> enabled [

	^ Enabled
]

{ #category : #accessing }
FlickrBackgrounds class >> enabled: anObject [

	Enabled := anObject
]

{ #category : #accessing }
FlickrBackgrounds class >> flickr [

	^ Flickr defaultWithKey: APIKey
]

{ #category : #initialization }
FlickrBackgrounds class >> initialize [

	Enabled := false.
	APIKey ifNil: [ APIKey := '' ].
	SampleSize := 100.
	PreferredWidth := 2560.
	PreferredHeight := 1440
]

{ #category : #accessing }
FlickrBackgrounds class >> preferredHeight [

	^ PreferredHeight
]

{ #category : #accessing }
FlickrBackgrounds class >> preferredHeight: anObject [

	PreferredHeight := anObject
]

{ #category : #settings }
FlickrBackgrounds class >> preferredSizeSettingsOn: builder [

	(builder setting: #backgroundPreferredWidth)
		label: 'Preferred Width';
		target: self;
		selector: #preferredWidth;
		description:
			'Preferred desktop image width. Use smaller sizes to reduce memory consumption. Use display resolution size if you want better quality.'.

	(builder setting: #backgroundPreferredHeight)
		label: 'Preferred Height';
		target: self;
		selector: #preferredHeight;
		description:
			'Preferred desktop image height. Use smaller sizes to reduce memory consumption. Use display resolution size if you want better quality.'
]

{ #category : #accessing }
FlickrBackgrounds class >> preferredWidth [

	^ PreferredWidth
]

{ #category : #accessing }
FlickrBackgrounds class >> preferredWidth: anObject [

	PreferredWidth := anObject
]

{ #category : #accessing }
FlickrBackgrounds class >> sampleSize [

	^ SampleSize
]

{ #category : #accessing }
FlickrBackgrounds class >> sampleSize: anObject [

	SampleSize := anObject
]

{ #category : #settings }
FlickrBackgrounds class >> sampleSizeSettingsOn: builder [

	^ (builder setting: #backgroundsFlickrSampleSize)
		  label: 'Sample size';
		  target: self;
		  selector: #sampleSize;
		  description: 'Selects a random image out of that many results'
]

{ #category : #settings }
FlickrBackgrounds class >> settingsOn: builder [

	<systemsettings>
	(builder group: #FlickrBackgrounds)
		parent: #tools;
		label: 'Flickr Photos';
		description: 'Settings for configuring FlickrBackgrounds';
		iconName: #smallPaint;
		with: [ 
			self apiKeySettingsOn: builder.
			self sampleSizeSettingsOn: builder.
			self preferredSizeSettingsOn: builder ]
]

{ #category : #fetching }
FlickrBackgrounds class >> smallestFittingSizeFor: photo [

	^ ((self flickr photoWithId: photo id) sizes smallestSizeExceeding:
		   PreferredWidth @ PreferredHeight) ifNotNil: [ :size | 
		  PreferredWidth < PreferredHeight
			  ifTrue: [ 
				  size width < size height
					  ifTrue: [ size ]
					  ifFalse: [ nil ] ]
			  ifFalse: [ 
				  size width >= size height
					  ifTrue: [ size ]
					  ifFalse: [ nil ] ] ]
]

{ #category : #'world menu' }
FlickrBackgrounds class >> worldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Backgrounds)
		parent: #Tools;
		order: 999;
		label: 'Change Background';
		help: 'Sets background of this world to a random image';
		icon: (self iconNamed: #image);
		action: [ FlickrBackgroundsPresenter new open ]
]

{ #category : #initialization }
FlickrBackgrounds >> endpoint [
	^ query
		  ifNil: [ self class flickr interestingness ]
		  ifNotNil: [ :aQuery | 
			  self class flickr photos search
				  text: aQuery;
				  beSafe;
				  beForPhotosOnly;
				  filterPublic;
				  yourself ]
]

{ #category : #initialization }
FlickrBackgrounds >> formForPhoto: aPhoto [
	| size url sizeSpec |

	sizeSpec := (self class flickr photoWithId: aPhoto id) sizes.
	size := (sizeSpec smallestSizeExceeding:
		         self class preferredWidth @ self class preferredHeight) 
		        ifNil: [ sizeSpec largestSize ].
	url := size source asUrl.
	^ Form fromBinaryStream: url retrieveContents readStream
]

{ #category : #accessing }
FlickrBackgrounds >> generator [
	^ generator ifNil: [ 
		  self initializeGenerator.
		  generator ]
]

{ #category : #initialization }
FlickrBackgrounds >> initializeGenerator [
	generator := Generator on: [ :aGenerator | 
		             | cursor |

		             cursor := FlickrPageCursor new
			                       page: 1;
			                       pageSize: 100;
			                       yourself.
			
		             [ cursor hasMore ] whileTrue: [ 
			             (self endpoint nextWith: cursor) shuffled do: [ 
				             :aPhoto | 
				             aGenerator yield: (self formForPhoto: aPhoto) ] ] ]
]

{ #category : #accessing }
FlickrBackgrounds >> nextPhoto [
	^ self generator next
]

{ #category : #accessing }
FlickrBackgrounds >> query [

	^ query
]

{ #category : #accessing }
FlickrBackgrounds >> query: anObject [
	| newValue |

	newValue := anObject isEmptyOrNil
		            ifTrue: [ nil ]
		            ifFalse: [ anObject ].
	query ~= newValue ifFalse: [ ^ self ].
	query := newValue.
	generator := nil
]

{ #category : #initialization }
FlickrBackgrounds >> reset [
	generator := nil
]
