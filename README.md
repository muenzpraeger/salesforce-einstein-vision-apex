# salesforce-einstein-vision-apex

This repository showcases how to use the [Salesforce Einstein Vision API](https://metamind.readme.io/) using an Apex based wrapper.

Please check the [product documentation](https://metamind.readme.io/) for general information about what the Salesforce Einstein Vision API is, how to use it and when it'll be available for you.

# Run-On-Your-Own

## Prerequisites

For running the app on your own you'll need to fulfill the following requirements:
* Access to a Salesforce org, i. e. a Developer Edition (You can [signup here for free](https://developer.salesforce.com/signup) if you don't have one).
* An API account for Salesforce Einstein Vision.

Please find the detailed instructions for how to setup access to the [Einstein Vision API here](https://metamind.readme.io/docs/what-you-need-to-call-api).

## Unmanaged Package

It is recommended to upload the source code to the org of your choice i. e. with the Force.com IDE.

You can also install the current version as an [unmanaged package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t0Y000000qkmP).

# Getting started

As this library is basically a wrapper for using the [Salesforce Einstein Vision API](https://metamind.readme.io/) it is highly recommended to checkout the API documentation.

The workflow for using Einstein Vision can be described with the following scenario.

* First you identify image categories that need to be identified (i. e. Beaches, Mountains etc.).
* Then you create a dataset which will hold all those image categories.
* You add for each identified image category a so called "label" to the dataset.
* For every label you add a number of example images to the dataset.
* After you've finished adding examples you can train the dataset.
* After the training you can start to predict if a given image belongs to one of the defined labels.

Please check the MetaMind documentation for recommendations regarding image quality, amount of examples and so forth.

### Creating a PredictionService

The foundation for everything is the `PredictionService`. As the communication with the API is based on a valid OAuth2 token (see MetaMind documentation) you can initiate a new PredictionService in the following way.

```
EinsteinVision_PredictionService predictionService = new EinsteinVision_PredictionService("AASDFNSADF23423424SADSFASF");
```

### Predict an image

You can predict images either by sending Base64, uploading a Blob or a remote (publicly available!) URL. See this example how to validate a remote URL.

```
EinsteinVision_PredictionResult result = service.predictUrl(modelId, beachUrl, "");
```

The returned result will give you an array of all Labels within the Dataset and their probability.

You can find two Lightning examples [here in the GitHub repo](https://github.com/muenzpraeger/salesforce-einstein-vision-apex/tree/master/examples/).

## Contribution

Feel free to contribute to this project via pull requests.

## License

For licensing see the included [license file](https://github.com/muenzpraeger/salesforce-einstein-vision-apex/blob/master/LICENSE.md).