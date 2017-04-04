@isTest
public with sharing class Test_EinsteinVision {
    
    static testMethod void createDataset() {
        
        // Test 1: Create valid dataset
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        String[] labels = new String[]{'beach', 'mountain'};
            
            Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Dataset dataset = service.createDataset('Beach and Mountain', labels);
        
        System.assertEquals(57, dataset.id);
        System.assertEquals('Beach and Mountain', dataset.name);
        System.assertEquals(0, dataset.totalExamples);
        System.assertEquals(2, dataset.totalLabels);
        System.assertEquals('SUCCEEDED', dataset.statusMsg);
        System.assertEquals(true, dataset.available);
        
        List<EinsteinVision_Label> datasetLabels = dataset.labelSummary.labels;
        
        for (EinsteinVision_Label label : datasetLabels) {
            System.assertEquals(57, label.datasetId);
            // TODO System.assertEquals(0, label.numExamples);
            if (label.id == 611) {
                System.assertEquals('beach', label.name);
            }
        }
        
        // Test 2: Test EinsteinVision_StringIsEmptyException with empty string for Dataset name
        try {
            dataset = service.createDataset('', labels);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }
        
        // Test 3: Test EinsteinVision_StringIsEmptyException with null string for Dataset name
        try {
            dataset = service.createDataset(null, labels);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }
        
        // Test 4: Test EinsteinVision_StringTooLongException Dataset name > 180 characters
        try {
            String nameTooLong = 'AbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefg';
            dataset = service.createDataset(nameTooLong, labels);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringTooLongException'));
        }
        
        // Test 5: Test EinsteinVision_NullPointerException with null value for labels
        try {
            dataset = service.createDataset('Beaches and Mountains', null);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NullPointerException'));
        }
        
        // Test 6: Test EinsteinVision_NoValuesException for emtpy labels array
        try {
            String[] labelsEmpty = new String[]{};
                dataset = service.createDataset('Beaches and Mountains', labelsEmpty);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NoValuesException'));
        }
        
        // Test 7: Test EinsteinVision_TooManyValuesException for label count > 1000
        try {
            String[] labelsTooBig = new String[]{};
                for (Integer i=0;i<1002;i++) {
                    labelsTooBig.add('Label' + i);
                }
            dataset = service.createDataset('Beaches and Mountains', labelsTooBig);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_TooManyValuesException'));
        }
    }
    
    static testMethod void getDataset() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Dataset dataset = service.getDataset(57);
        
        // Test 1: Valid Dataset returned
        System.assertEquals('Beach and Mountain', dataset.name);
        System.assertEquals(DateTime.newInstanceGmT(2016,9,15,16,51,41), dataset.updatedAt);
    }
    
    static testMethod void getDatasets() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        List<EinsteinVision_Dataset> datasets = service.getDatasets();
        
        System.assertEquals(2, datasets.size());
        
        for (EinsteinVision_Dataset dataset : datasets) {
            if (dataset.id == 57) {
                System.assertEquals('Beach and Mountain', dataset.name);
            }
        }
    }
    
    static testMethod void deleteDataset() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        Boolean success = service.deleteDataset(108);
        
        System.assertEquals(true, success);
        
        EinsteinVision_Dataset dataset = new EinsteinVision_Dataset();
        dataset.id = 108;
        
        success = service.deleteDataset(dataset);
        
        System.assertEquals(true, success);
        
    }
    
    static testMethod void createLabel() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Label label = service.createLabel(57, 'beach');
        
        System.assertEquals('beach', label.name);
        System.assertEquals(57, label.datasetId);
        
        // Test 3: Test EinsteinVision_StringIsEmptyException with null string for Dataset name
        try {
            label = service.createLabel(57, '');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }
        
        // Test 4: Test EinsteinVision_StringTooLongException Dataset name > 180 characters
        try {
            String nameTooLong = 'AbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefg';
            label = service.createLabel(57, nameTooLong);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringTooLongException'));
        }
        
    }
    
    static testMethod void getLabel() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Label label = service.getLabel(57, 614);
        
        System.assertEquals('beach', label.name);
        System.assertEquals(57, label.datasetId);
        
    }
    
    static testMethod void createExample() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Example example = service.createExample(57, '77880132.jpg', 614, Blob.valueOf('data'));
        
        System.assertEquals(43887, example.id);
        System.assertEquals('77880132.jpg', example.name);
        System.assertEquals('https://jBke4mtMuOjrCK3A04Q79O5TBySI2BC3zqi7...', example.location);
        System.assertEquals(DateTime.newInstanceGmt(2016,9,15,23,18,13), example.createdAt);
        
    }
    
    static testMethod void createExamplesFromUrl() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Dataset dataset = service.createExamplesFromUrl(1000022, 'http://my.image.com/test.png');
        
        System.assertEquals('mountainvsbeach', dataset.name);
        System.assertEquals(DateTime.newInstanceGmt(2017,2,17,0,22,10), dataset.createdAt);
        System.assertEquals(DateTime.newInstanceGmt(2017,2,17,0,22,12), dataset.updatedAt);
        
        try {
            dataset = service.createExamplesFromUrl(1000022, '');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }
        
    }
    
    static testMethod void getExample() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Example example = service.getExample(57, 43887);
        
        System.assertEquals('77880132.jpg', example.name);
        System.assertEquals(DateTime.newInstanceGmt(2016,9,15,23,18,13), example.createdAt);
        System.assertEquals('https://jBke4mtMuOjrCK3A04Q79O5TBySI2BC3zqi7...', example.location);
        
    }
    
    static testMethod void getExamples() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        List<EinsteinVision_Example> examples = service.getExamples(57);
        
        System.assertEquals(4, examples.size());
        
        EinsteinVision_Dataset dataset = new EinsteinVision_Dataset();
        dataset.id = 57;
        
        examples = service.getExamples(dataset);
        
        System.assertEquals(4, examples.size());
        
    }
    
    static testMethod void deleteExample() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        Boolean success = service.deleteExample(108, 43555);
        
        System.assertEquals(true, success);
        
        EinsteinVision_Example example = new EinsteinVision_Example();
        example.id = 43555;
        example.label = new EinsteinVision_Label();
        example.label.datasetId = 108;
        
        success = service.deleteExample(example);
        
        System.assertEquals(true, success);
        
    }
    
    static testMethod void trainDataset() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Model model = service.trainDataset(57, 'Beach and Mountain Model', 0, 0, '');
        
        System.assertEquals(DateTime.newInstanceGmt(2016,9,16,18,3,21), model.createdAt);
        System.assertEquals(DateTime.newInstanceGmt(2016,9,16,18,3,21), model.updatedAt);
        System.assertEquals(57, model.datasetId);
        System.assertEquals(0, model.datasetVersionId);
        System.assertEquals('Beach and Mountain Model', model.name);
        System.assertEquals('QUEUED', model.status);
        System.assertEquals(0, model.progress);
        System.assertEquals(0.001, model.learningRate);
        System.assertEquals(3, model.epochs);
        System.assertEquals(1, model.queuePosition);
        System.assertEquals('7JXCXTRXTMNLJCEF2DR5CJ46QU', model.modelId);
        System.assertEquals(null, model.trainParams);
        System.assertEquals(null, model.trainStats);
        System.assertEquals('image', model.modelType);
        System.assertEquals(null, model.failureMsg);
        
        EinsteinVision_Dataset dataset = new EinsteinVision_Dataset();
        dataset.id = 57;
        
        model = service.trainDataset(dataset, 'Beach and Mountain Model', 0, 0, '');
        System.assertEquals('Beach and Mountain Model', model.name);
        
        model = service.trainDataset(dataset, 'Beach and Mountain Model', 6, 0, '');
        System.assertEquals('Beach and Mountain Model', model.name);
        
        
        try {
            model = service.trainDataset(0, 'Beach and Mountain Model', 0, 0, '');
        } catch (Exception e) {
            System.debug('Error is: ' + e.getTypeName());
            System.assert(e.getTypeName().equals('EinsteinVision_NoValuesException'));
        }
        
        try {
            model = service.trainDataset(57, '', 0, 0, '');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }
        
        try {
            String nameTooLong = 'AbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefg';
            model = service.trainDataset(57, nameTooLong, 0, 0, '');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringTooLongException'));
        }
        
        try {
            model = service.trainDataset(57, 'Beach and Mountain Model', 101, 0, '');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NumberTooBigException'));
        }
        
        try {
            model = service.trainDataset(57, 'Beach and Mountain Model', 101, 0, '');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NumberTooBigException'));
        }
        
        try {
            model = service.trainDataset(57, 'Beach and Mountain Model', 0, 0.00001, '');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NumberTooSmallException'));
        }
        
        try {
            model = service.trainDataset(57, 'Beach and Mountain Model', 0, 0.1, '');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NumberTooBigException'));
        }
        
    }
    
    static testMethod void getModel() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_Model model = service.getModel('7JXCXTRXTMNLJCEF2DR5CJ46QU');
        
        // TODO System.assertEquals(DateTime.newInstance(), model.createdAt);
        // TODO System.assertEquals(DateTime.newInstance(), model.updatedAt);
        System.assertEquals(57, model.datasetId);
        System.assertEquals(0, model.datasetVersionId);
        System.assertEquals('Beach and Mountain Model', model.name);
        System.assertEquals('SUCCEEDED', model.status);
        System.assertEquals(1, model.progress);
        System.assertEquals(0.001, model.learningRate);
        System.assertEquals(3, model.epochs);
        System.assertEquals('7JXCXTRXTMNLJCEF2DR5CJ46QU', model.modelId);
        // TODO System.assertEquals('{"trainSplitRatio": 0.7}', model.trainParams);
        System.assertEquals(null, model.trainStats);
        System.assertEquals('image', model.modelType);
        
        EinsteinVision_Dataset dataset = new EinsteinVision_Dataset();
        dataset.id = 57;
        
        model = service.getModel('7JXCXTRXTMNLJCEF2DR5CJ46QU');
        System.assertEquals('Beach and Mountain Model', model.name);
        
    }
    
    static testMethod void getModelLearningCurve() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_ModelLearningCurve[] learningCurves = service.getModelLearningCurve('7JXCXTRXTMNLJCEF2DR5CJ46QU');
        
        System.assertEquals(1, learningCurves.get(0).epoch);
        //System.assertEquals('Mountains', learningCurves.get(0).metricsData.labels.get(0));
        System.assertEquals('521811667.jpg-Mountains', learningCurves.get(0).epochResults.get(3).exampleName);
        System.assertEquals('Mountains', learningCurves.get(0).epochResults.get(3).expectedLabel);
        System.assertEquals('Beaches', learningCurves.get(0).epochResults.get(3).predictedLabel);
        
    }
    
    static testMethod void getModelMetrics() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_ModelMetrics metrics = service.getModelMetrics('7JXCXTRXTMNLJCEF2DR5CJ46QU');
        
        System.assertEquals(0.9286, metrics.testAccuracy);
        System.assertEquals(0.9941, metrics.trainingAccuracy);
        System.assertEquals(0.021, metrics.trainingLoss);
        
        System.assertEquals(0.9090909090909092, metrics.f1.get(0));
        System.assertEquals(8, metrics.confusionMatrix.get(1).get(1));
        
    }
    
    static testMethod void getModels() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        List<EinsteinVision_Model> models = service.getModels(57);
        
        System.assertEquals(2, models.size());
        EinsteinVision_Model model = models.get(0);
        System.assertEquals('To train a dataset and create a model, the dataset must contain at least 100 examples per label for test set', model.failureMsg);
        
        EinsteinVision_Dataset dataset = new EinsteinVision_Dataset();
        dataset.id = 57;
        models = service.getModels(dataset);
        
        System.assertEquals(2, models.size());
        
    }
    
    static testMethod void predictBase64() {
        
        EinsteinVision_PredictionService service = new EinsteinVision_PredictionService('123');
        
        Test.setMock(HttpCalloutMock.class, new Test_EinsteinVision_HttpMockResponses());
        
        EinsteinVision_PredictionResult result = service.predictBase64('YCQ4ZACEPJFGXZNRA6ERF3GL5E', 'aaabbbccc', '');
        
        System.assertEquals(2, result.probabilities.size());
        System.assertEquals('beach', result.probabilities.get(0).label);
        System.assertEquals(0.039788953959941864, result.probabilities.get(1).probability);
        
        EinsteinVision_Model model = new EinsteinVision_Model();
        model.modelId = 'YCQ4ZACEPJFGXZNRA6ERF3GL5E'; 
        
        result = service.predictBase64(model, 'aaabbbccc', '');
        System.assertEquals(2, result.probabilities.size());
        
    }
    
    
    static testMethod void testOtherMethods() {
        
        System.assertEquals('1ff13444ed8140c7a32fc4e6451aa76d', EinsteinVision_HttpBodyPart.getBoundary());
        
        String[] labels = new String[]{'a', 'b'};
            EinsteinVision_HttpBodyPartDataset bodyPartDataset = new EinsteinVision_HttpBodyPartDataset('Test1', labels);
        
        System.assertEquals('Test1', bodyPartDataset.getName());
        
        bodyPartDataset.setName('Test2');
        System.assertEquals('Test2', bodyPartDataset.getName());
        
        System.assertEquals('a,b', bodyPartDataset.getLabels());
        
        try {
            bodyPartDataset.setName('');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }
        
        try {
            String nameTooLong = 'AbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefg';
            bodyPartDataset.setName(nameTooLong);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringTooLongException'));
        }
        
        try {
            bodyPartDataset.setLabels(null);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NullPointerException'));
        }
        
        try {
            String[] labelsEmpty = new String[]{};
                bodyPartDataset.setLabels(labelsEmpty);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NoValuesException'));
        }
        
        try {
            String[] labelsTooBig = new String[]{};
                for (Integer i=0;i<1002;i++) {
                    labelsTooBig.add('Label' + i);
                }
            bodyPartDataset.setLabels(labelsTooBig);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_TooManyValuesException'));
        }
        
        EinsteinVision_HttpBodyPartDatasetUrl bodyPartDatasetUrl = new EinsteinVision_HttpBodyPartDatasetUrl('http://my.test1.com');
        
        bodyPartDatasetUrl.setUrl('http://my.test2.com');
        System.assertEquals('http://my.test2.com', bodyPartDatasetUrl.getUrl());
        
        try {
            bodyPartDatasetUrl.setUrl('');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }
        
        EinsteinVision_HttpBodyPartLabel bodyPartLabel = new EinsteinVision_HttpBodyPartLabel('Test1');
        
        bodyPartLabel.setName('Test2');
        System.assertEquals('Test2', bodyPartLabel.getName());
        
        try {
            bodyPartLabel.setName('');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }
        
        // Test 4: Test EinsteinVision_StringTooLongException Dataset name > 180 characters
        try {
            String nameTooLong = 'AbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefg';
            bodyPartLabel.setName(nameTooLong);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringTooLongException'));
        }
        
        EinsteinVision_HttpBodyPartPrediction bodyPartPrediction = new EinsteinVision_HttpBodyPartPrediction('modelId1', 'testData1', '', EinsteinVision_HttpBodyPartPrediction.TYPES.BASE64);
        
        bodyPartPrediction.setModelId('modelId2');
        System.assertEquals('modelId2', bodyPartPrediction.getModelId());
        
        bodyPartPrediction.setData('data2');
        System.assertEquals('data2', bodyPartPrediction.getData());        
        
        bodyPartPrediction.setSampleId('sampleId2');
        System.assertEquals('sampleId2', bodyPartPrediction.getSampleId());
        
        bodyPartPrediction.setType(EinsteinVision_HttpBodyPartPrediction.Types.URL);
        System.assertEquals(EinsteinVision_HttpBodyPartPrediction.Types.URL, bodyPartPrediction.getType());
        
        EinsteinVision_HttpBodyPartTraining bodyPartTraining = new EinsteinVision_HttpBodyPartTraining(1, 'Test1', 0, 0, '');
        
        bodyPartTraining.setDatasetId(2);
        System.assertEquals(2, bodyPartTraining.getDatasetId());
        
        try {
            bodyPartTraining.setDatasetId(0);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NoValuesException'));
        }  
        
        bodyPartTraining.setName('Test2');
        System.assertEquals('Test2', bodyPartTraining.getName());
        
        try {
            bodyPartTraining.setName('');
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringIsEmptyException'));
        }     
        
        try {
            String nameTooLong = 'AbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefgAbcdefg';
            bodyPartTraining.setName(nameTooLong);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_StringTooLongException'));
        }
        
        bodyPartTraining.setEpochs(5);
        System.assertEquals(5, bodyPartTraining.getEpochs());
        
        try {
            bodyPartTraining.setEpochs(101);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NumberTooBigException'));
        }
        
        bodyPartTraining.setLearningRate(0.001);
        System.assertEquals(0.001, bodyPartTraining.getLearningRate());
        
        try {
            bodyPartTraining.setLearningRate(0.1);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NumberTooBigException'));
        }
        
        try {
            bodyPartTraining.setLearningRate(0.00001);
        } catch (Exception e) {
            System.assert(e.getTypeName().equals('EinsteinVision_NumberTooSmallException'));
        } 
        
    }
    
}