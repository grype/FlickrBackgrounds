Class {
	#name : #FlickrBackgroundsCommandline,
	#superclass : #ClapApplication,
	#category : #'FlickrBackgrounds-CLI'
}

{ #category : #'as yet unclassified' }
FlickrBackgroundsCommandline class >> updateBackgrounds [
	<commandline>
	^ (ClapCommand id: #updateBackgrounds)
		  description:
			  'Downloads most recent images from Flickr Interestingness';
		  add: ClapFlag forHelp;
		  add: ((ClapFlag id: #destination) description:
					   'Directory to download images to');
		  add:
			  ((ClapFlag id: #count) description:
					   'Maximum number of images to keep');
		  add: ((ClapFlag id: #width)
				   description: 'Preferred image width';
				   defaultValue: FlickrBackgrounds preferredWidth);
		  add: ((ClapFlag id: #height)
				   description: 'Preferred image height';
				   defaultValue: FlickrBackgrounds preferredHeight);
		  meaning: [ :args | 
			  args at: #helpFlag ifPresent: [ :help | 
				  help
					  value;
					  exitSuccess ].
			  (self with: args) execute ]
]

{ #category : #execution }
FlickrBackgroundsCommandline >> canUsePhoto: aPhoto [
	^ true
]

{ #category : #execution }
FlickrBackgroundsCommandline >> destination [

	^ arguments at: #destination
]

{ #category : #execution }
FlickrBackgroundsCommandline >> execute [
	self fetchImages
]

{ #category : #execution }
FlickrBackgroundsCommandline >> existingFiles [

	^ self destination asFileReference fileNames
]

{ #category : #execution }
FlickrBackgroundsCommandline >> fetchImages [
	| existingFiles sizeSpecs preferredSize maxCount |

	preferredSize := self preferredSize.
	maxCount := self maxCount.
	sizeSpecs := OrderedCollection new.

	self flickr interestingness
		pageSize: (maxCount min: 10);
		do: [ :aPhoto | 
			((self flickr photoWithId: aPhoto id) sizes smallestSizeExceeding:
					 preferredSize) ifNotNil: [ :val | sizeSpecs add: val ] ]
		whileTrue: [ sizeSpecs size < maxCount ].

	existingFiles := self existingFiles select: [ :aFile | 
		                 aFile path segments last ].

	sizeSpecs
		collect: [ :aSize | aSize source asUrl ]
		thenDo: [ :aUrl | 
			(existingFiles contains: aUrl segments last) ifFalse: [ 
				aUrl asZnUrl saveContentsToFile:
					(self destination asPath resolve: aUrl segments last) ] ]
]

{ #category : #accessing }
FlickrBackgroundsCommandline >> flickr [
	^ FlickrBackgrounds flickr
]

{ #category : #accessing }
FlickrBackgroundsCommandline >> maxCount [
	^ arguments at: #count ifAbsent: [ 10 ]
]

{ #category : #execution }
FlickrBackgroundsCommandline >> preferredSize [

	| width height |
	width := arguments
		         at: #width
		         ifAbsent: FlickrBackgrounds preferredWidth.
	height := arguments
		          at: #height
		          ifAbsent: FlickrBackgrounds preferredHeight.
	^ width @ height
]
