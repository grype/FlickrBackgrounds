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

		spec
			package: 'FlickrBackgrounds'
			with: [ spec requires: #( 'Flickr' ) ] ]
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
			loads: #( core );
			repository: 'github://pharo-contributions/taskit:v1.2.0' ]
]
