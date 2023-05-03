"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestFlickrBackgroundsCLI,
	#superclass : #PackageManifest,
	#category : #'FlickrBackgrounds-CLI-Manifest'
}

{ #category : #'code-critics' }
ManifestFlickrBackgroundsCLI class >> ruleUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'FlickrBackgroundsCommandline class' #fill #true)) #'2023-05-02T21:27:33.576996-07:00') )
]
