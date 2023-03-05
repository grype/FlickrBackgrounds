Class {
	#name : #FlickrBackgroundsCommandline,
	#superclass : #ClapApplication,
	#category : #'FlickrBackgrounds-CLI'
}

{ #category : #commands }
FlickrBackgroundsCommandline class >> fill [
	<commandline>
	^ (ClapCommand id: #fill)
		  description:
			  'Fills a directory with random images from the Flickr Interestingness project';
		  add: ClapFlag forHelp;
		  add:
			  ((ClapFlag id: #destination) description: 'Destination directory'; implicitMeaning: Path workingDirectory);
		  add:
			  ((ClapFlag id: #count) description:
					   'Maximum number of images to keep');
		  add: ((ClapFlag id: #width)
				   description: 'Preferred image width';
				   implicitMeaning: [ FlickrBackgrounds preferredWidth ]);
		  add: ((ClapFlag id: #height)
				   description: 'Preferred image height';
				   implicitMeaning: [ FlickrBackgrounds preferredHeight ]);
		  meaning: [ :args | 
			  args at: ClapFlag forHelp ifPresent: [ :help | 
				  ^ help
					    value;
					    exitSuccess ].
			  (self with: args) execute ]
]

{ #category : #execution }
FlickrBackgroundsCommandline >> destination [

	^ arguments at: #destination ifAbsent: nil
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
	| bg |

	bg := FlickrBackgrounds new
		      preferredSize: self preferredSize;
		      yourself.

	bg fillDirectoryAt: self destination withAtMost: self maxCount
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
