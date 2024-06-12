"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestFlickrBackgroundsCLI',
	#superclass : 'PackageManifest',
	#category : 'FlickrBackgrounds-CLI-Manifest',
	#package : 'FlickrBackgrounds-CLI',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestFlickrBackgroundsCLI class >> ruleUsesAddRuleV1FalsePositive [
	^ #( #( #( #RGMethodDefinition #( #'FlickrBackgroundsCommandline class'
	              #flickr #true ) )
	        #'2023-05-03T23:35:48.309062-07:00' ) )
]
