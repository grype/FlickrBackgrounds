Class {
	#name : #BaselineOfFlickrBackgrounds,
	#superclass : #BaselineOf,
	#category : #BaselineOfFlickrBackgrounds
}

{ #category : #baselines }
BaselineOfFlickrBackgrounds >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		self declareFlickrOn: spec.
		self declareTaskItOn: spec.
		self declareClapOn: spec.

		spec
			package: 'FlickrBackgrounds'
			with: [ spec requires: #( 'Flickr' ) ];
			package: 'FlickrBackgrounds-CLI'
			with: [ spec requires: #( FlickrBackgrounds ) ].

		spec
			group: 'default' with: #( FlickrBackgrounds );
			group: 'cli' with: #( default #'FlickrBackgrounds-CLI'
				   Clap ) ]
]

{ #category : #'external projects' }
BaselineOfFlickrBackgrounds >> declareClapOn: spec [
	spec baseline: 'Clap' with: [ 
		spec
			loads: #( core pharo);
			repository: 'github://cdlm/clap-st/src' ]
]

{ #category : #'external projects' }
BaselineOfFlickrBackgrounds >> declareFlickrOn: spec [
	spec baseline: 'Flickr' with: [ 
		spec
			repository: 'github://grype/Flickr-Pharo:main/src' ]
]

{ #category : #'external projects' }
BaselineOfFlickrBackgrounds >> declareTaskItOn: spec [
	spec baseline: 'TaskIt' with: [ 
		spec
			loads: #( 'core' 'TaskItProcesses' 'TaskItRetry' 'TaskItDebugger' );
			repository: 'github://pharo-contributions/taskit:v1.2.0' ]
]
