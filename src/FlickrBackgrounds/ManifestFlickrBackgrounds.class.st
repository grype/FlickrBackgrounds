"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestFlickrBackgrounds,
	#superclass : #PackageManifest,
	#category : #'FlickrBackgrounds-Manifest'
}

{ #category : #'code-critics' }
ManifestFlickrBackgrounds class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#FlickrBackgrounds #fillDirectoryAt:withAtMost: #false)) #'2023-02-22T12:09:52.01333-08:00') )
]

{ #category : #'code-critics' }
ManifestFlickrBackgrounds class >> ruleModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#FlickrBackgrounds #fillDirectoryAt:withAtMost: #false)) #'2023-02-22T12:08:42.358262-08:00') )
]

{ #category : #'code-critics' }
ManifestFlickrBackgrounds class >> ruleStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#FlickrBackgrounds #fillDirectoryAt:withAtMost: #false)) #'2023-02-22T12:09:46.653257-08:00') )
]
