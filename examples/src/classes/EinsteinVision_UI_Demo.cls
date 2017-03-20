/**
* Demo class that showcases how to use the Einstein Vision Apex wrappers.
*
* For creating a valid access token please refer to the Einstein Vision documentation:
* 
* Authorization via Apex: https://metamind.readme.io/docs/apex_qs_scenario
* Authorization via Website: https://metamind.readme.io/docs/set-up-auth
*
*/
public with sharing class EinsteinVision_UI_Demo {
    
    /**
    * This method reads all trained examples from your Einstein Vision account.
    */
    @AuraEnabled
    public static List<EinsteinVision_Example> readDemoExamples() {
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('enterYourTokenHere');
        List<EinsteinVision_Dataset> datasets = service.getDatasets();
        List<EinsteinVision_Example> examples = service.getExamples(datasets[0]);
        return examples;
    }
	    
    /**
    * This method predicts a given URL based on the Einstein Vision General Image Classifier.
    *
    * https://metamind.readme.io/v1/page/general-image-model-class-list
    *
    */
    @AuraEnabled
    public static List<EinsteinVision_Probability> predictUrl(String url) {
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('enterYourTokenHere');
        EinsteinVision_PredictionResult result = service.predictUrl('GeneralImageClassifier', url, '');
        return result.probabilities;
    }
    
}