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

		spec
			package: 'FlickrBackgrounds'
			with: [ spec requires: #( 'Flickr' ) ] ]
]

{ #category : #'external projects' }
BaselineOfFlickrBackgrounds >> declareFlickrOn: spec [
	spec
		baseline: 'Flickr'
		with: [ spec repository: 'github://grype/Flickr-Pharo:main/src' ]
]
