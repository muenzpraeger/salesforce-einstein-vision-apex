public class EinsteinVision_PredictionService {

    // Base URL for the PredictionService
    private static String BASE_URL = 'https://api.metamind.io/v1';

    private String DATASETS = BASE_URL + '/vision/datasets';
    private String LABELS = '/labels';
    private String EXAMPLES = '/examples';
    private String TRAIN = BASE_URL + '/vision/train';
    private String MODELS = '/vision/models';
    private String PREDICT = BASE_URL + '/vision/predict';
    private String API_USAGE = BASE_URL + '/apiusage';

    private boolean isExecuting = false;
    private String bearerToken = '';


    /**
     * <p>Create a new object of type EinsteinVision_PredictionService.</p>
     * 
     * <p>The EinsteinVision_PredictionService is the foundation for communicating with the Salesforce Einstein Prediction Service.
     * 
     * @param bearerToken
     * A valid Bearer token
     */
    public EinsteinVision_PredictionService(String bearerToken) {
        this.bearerToken = bearerToken;
    }

    /**
     * Creates a new EinsteinVision_Dataset. A EinsteinVision_Dataset is basically a group of different object types (named as 'Label').
     * @param name
     * The name of the EinsteinVision_Dataset
     * @param labels
     * An array of labels that will be used in the EinsteinVision_Dataset, i. e. 'Beaches', 'Mountains' etc.
     * @return
     * @
     */
    public EinsteinVision_Dataset createDataset(String name, String[] labels) {
        System.debug('Starting createDataset call with name ' + name);
        EinsteinVision_HttpBodyPartDataset parts = new EinsteinVision_HttpBodyPartDataset(name, labels);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS, parts.build());
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call createDataset has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Dataset dataset = (EinsteinVision_Dataset)client.getParser().readValueAs(EinsteinVision_Dataset.class);
            System.debug('New Dataset with id ' + dataset.id + ' has been created.');
            return dataset;
        }
        return null;
    }
    
    /**
     * Creates a new dataset with images from a remote zip file (async call).
     * @param url
     * The remote URL of the to be trained image.
     * @return
     * @
     */
    public EinsteinVision_Dataset createDatasetFromUrlAsync(String url) {
        System.debug('Starting createDatasetFromUrlAsync call from URL ' + url);
        EinsteinVision_HttpBodyPartDatasetUrl parts = new EinsteinVision_HttpBodyPartDatasetUrl(url);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/upload', parts.build());
        client.isPost(true);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call createDatasetFromUrlAsync has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Dataset dataset = (EinsteinVision_Dataset)client.getParser().readValueAs(EinsteinVision_Dataset.class);
            System.debug('New dataset with id ' + dataset.id + ' has been created.');
            return dataset;
        }
        return null;
    }
    
    /**
     * Creates a new dataset with images from a remote zip file (sync).
     * @param url
     * The remote URL of the to be trained image.
     * @return
     * @
     */
    public EinsteinVision_Dataset createDatasetFromUrlSync(String url) {
        System.debug('Starting createDatasetFromUrlSync call from URL ' + url);
        EinsteinVision_HttpBodyPartDatasetUrl parts = new EinsteinVision_HttpBodyPartDatasetUrl(url);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/upload/sync', parts.build());
        client.isPost(true);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call createDatasetFromUrlSync has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Dataset dataset = (EinsteinVision_Dataset)client.getParser().readValueAs(EinsteinVision_Dataset.class);
            System.debug('New dataset with id ' + dataset.id + ' has been created.');
            return dataset;
        }
        return null;
    }

    /**
     * Gets an existing EinsteinVision_Dataset.
     * @param id
     * The id of the EinsteinVision_Dataset that needs to be fetched.
     * @return
     * @
     */
    public EinsteinVision_Dataset getDataset(Long id) {
        if (id==0) {
            throw new EinsteinVision_NoValuesException('datasetId');
        }
        System.debug('Starting getDataset call with parameter ' + id);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + id);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getDataset has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Dataset dataset = (EinsteinVision_Dataset)client.getParser().readValueAs(EinsteinVision_Dataset.class);
            System.debug('Dataset has been read.');
            return dataset;
        }
        return null;
    }

    /**
     * Gets all EinsteinVision_Datasets of the authenticated user.
     * @return
     * An array of all EinsteinVision_Datasets
     */
    public EinsteinVision_Dataset[] getDatasets() {
        System.debug('Starting getDatasets call');
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getDatasets has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Dataset[] datasets = (EinsteinVision_Dataset[])client.getParser().readValueAs(EinsteinVision_Dataset[].class);
            System.debug('Datasets have been read.');
            return datasets;
        }
        return null;
    }

    /**
     * Deletes an existing dataset.
     * @param dataset
     * The EinsteinVision_Dataset that should be deleted.
     * @return
     * True if the deletion was successful.
     */
    public boolean deleteDataset(EinsteinVision_Dataset dataset) {
        return deleteDataset(dataset.id);
    }

    /**
     * Deletes an existing dataset.
     * @param id
     * The id of the EinsteinVision_Dataset that should be deleted.
     * @return
     * True if the deletion was successful.
     */
    public boolean deleteDataset(Long id) {
        System.debug('Starting deleteDataset call');
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + id);
        client.isDelete(true);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call deleteDataset has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
                System.debug('Dataset ' + id + ' has been deleted.');
                return true;
        }
        return false;
    }

    /**
     * Creates a new EinsteinVision_Label within an existing EinsteinVision_Dataset.
     * @param datasetId
     * The id of the EinsteinVision_Dataset.
     * @param name
     * The new EinsteinVision_Label name.
     * @return
     * @
     */
    public EinsteinVision_Label createLabel(Long datasetId, String name) {
        System.debug('Starting createLabel call with name ' + name);
        EinsteinVision_HttpBodyPartLabel parts = new EinsteinVision_HttpBodyPartLabel(name);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + datasetId + LABELS, parts.build());
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call createLabel has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Label label = (EinsteinVision_Label)client.getParser().readValueAs(EinsteinVision_Label.class); 
            System.debug('Label ' + name + ' has been created.');
            return label;
        }
        return null;
    }

    /**
     * Gets an existing EinsteinVision_Label from a EinsteinVision_Dataset.
     * @param datasetId
     * The id of the associated EinsteinVision_Dataset.
     * @param id
     * The id of the EinsteinVision_Dataset that needs to be fetched.
     * @return
     * @
     */
    public EinsteinVision_Label getLabel(Long datasetId, Integer id) {
        System.debug('Starting getLabel call with id ' + id);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + datasetId + LABELS + '/' + id);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getLabel has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Label label = (EinsteinVision_Label)client.getParser().readValueAs(EinsteinVision_Label.class); 
            System.debug('Label ' + id + ' has been read.');
            return label;
        }
        return null;
    }

     /**
     * Adds new image examples for the predictive vision training.
     * @param datasetId
     * The id of the EinsteinVision_Dataset to which the image should be added.
     * @param name
     * The name of the example.
     * @param fileBlob
     * The blog of the to be trained image.
     * @return
     * @
     */
    public EinsteinVision_Example createExample(Long datasetId, String name, Long labelId, Blob fileBlob) {
        System.debug('Starting createExample call from blob');
        EinsteinVision_HttpBodyPartExample parts = new EinsteinVision_HttpBodyPartExample(name, labelId, EncodingUtil.base64Encode(fileBlob));
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + datasetId + EXAMPLES, parts.build());
        System.debug('Target URL is ' + client.getUrl());
        client.isPost(true);
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call createExample from blob has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Example example = (EinsteinVision_Example)client.getParser().readValueAs(EinsteinVision_Example.class);
            System.debug('New example with id ' + example.id + ' has been created.');
            return example;
        }
        return null;
    }

    /**
     * Adds new image examples for the predictive vision training via a remote zip file.
     * @param datasetId
     * The id of the EinsteinVision_Dataset to which the image should be added.
     * @param url
     * The remote URL of the to be trained image.
     * @return
     * @
     */
    public EinsteinVision_Dataset createExamplesFromUrl(Long datasetId, String url) {
        System.debug('Starting createExamplesFromUrl call from URL ' + url);
        EinsteinVision_HttpBodyPartDatasetUrl parts = new EinsteinVision_HttpBodyPartDatasetUrl(url);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + datasetId + '/upload', parts.build());
        client.isPut(true);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call createExampleFromUrl has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Dataset dataset = (EinsteinVision_Dataset)client.getParser().readValueAs(EinsteinVision_Dataset.class);
            System.debug('New examples for dataset with id ' + dataset.id + ' have been created.');
            return dataset;
        }
        return null;
    }

    /**
     * Gets data about an existing example.
     * @param datasetId
     * The EinsteinVision_Dataset id to which the example beLongs.
     * @param id
     * The id of the EinsteinVision_Example.
     * @return
     * @
     */
    public EinsteinVision_Example getExample(Long datasetId, Long id) {
        System.debug('Starting getExample call with id ' + id);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + datasetId + EXAMPLES + '/' + id);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getExample has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Example example = (EinsteinVision_Example)client.getParser().readValueAs(EinsteinVision_Example.class);
            System.debug('Example ' + id + ' has been read.');
            return example;
        }
        return null;
    }

    /**
     * Gets an array of all EinsteinVision_Examples that are associated with the given Dataset.
     * @param dataset
     * The EinsteinVision_Dataset to which the EinsteinVision_Examples are associated.
     * @return
     * @
     */
    public EinsteinVision_Example[] getExamples(EinsteinVision_Dataset dataset) {
        return getExamples(dataset.id);
    }

    /**
     * Gets an array of all EinsteinVision_Examples that are associated with the given EinsteinVision_Dataset.
     * @param datasetId
     * The id of the EinsteinVision_Dataset to which the EinsteinVision_Examples are associated.
     * @return
     * @
     */
    public EinsteinVision_Example[] getExamples(Long datasetId) {
        System.debug('Starting getExamples call');
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + datasetId + EXAMPLES);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getExamples has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Example[] examples = (EinsteinVision_Example[])client.getParser().readValueAs(EinsteinVision_Example[].class);
            System.debug('Examples have been read.');
            return examples;
        }
        return null;
    }

    /**
     * Deletes the given EinsteinVision_Example.
     * @param example
     * The EinsteinVision_Example that needs to be deleted.
     * @return
     * True if the deletion was successful.
     */
    public boolean deleteExample(EinsteinVision_Example example) {
        return deleteExample(example.label.datasetId, example.id);
    }

    /**
     * Deletes the given EinsteinVision_Example.
     * @param datasetId
     * The Dataset id to which the Example beLongs.
     * @param id
     * The id of the EinsteinVision_Example that needs to be deleted.
     * @return
     * True if the deletion was successful.
     */
    public boolean deleteExample(Long datasetId, Long id) {
        System.debug('Starting deleteExample call');
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + datasetId + EXAMPLES + '/' + id);
        client.isDelete(true);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call deleteExample has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
                System.debug('Example ' + id + ' has been deleted.');
                return true;
        }
        return false;
    }

    /**
     * Starts the training of a EinsteinVision_Dataset.
     * @param dataset
     * The EinsteinVision_Dataset that should be trained.
     * @param name
     * The name of the EinsteinVision_Dataset.
     * @param epochs
     * Optional. The number of training iterations, valid values are between 1-100. Set to 0 if you want to use the default.
     * @param learningRate
     * Optional. The learning rate, valid values are betweed 0.0001 and 0.01. Set to 0 if you want to use the default.
     * @return
     * @
     */
    public EinsteinVision_Model trainDataset(EinsteinVision_Dataset dataset, String name, Integer epochs, Decimal learningRate, String trainParams) {
        return trainDataset(dataset.id, name, epochs, learningRate, trainParams);
    }

    /**
     * Starts the training of a EinsteinVision_Dataset.
     * @param datasetId
     * The EinsteinVision_Dataset id that should be trained.
     * @param name
     * The name of the EinsteinVision_Dataset.
     * @param epochs
     * Optional. The number of training iterations, valid values are between 1-100. Set to 0 if you want to use the default.
     * @param learningRate
     * Optional. The learning rate, valid values are betweed 0.0001 and 0.01. Set to 0 if you want to use the default.
     */
    public EinsteinVision_Model trainDataset(Long datasetId, String name, Integer epochs, Decimal learningRate, String trainParams) {
        EinsteinVision_Dataset dataset = getDataset(datasetId);
        if (dataset != null) {
            if (dataset.totalExamples>0) {
                System.debug('Starting trainDataset call with name ' + name);
                EinsteinVision_HttpBodyPartTraining parts = new EinsteinVision_HttpBodyPartTraining(datasetId, name, epochs, learningRate, trainParams);
                EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, TRAIN, parts.build());
                System.debug('Target URL is ' + client.getUrl());
                client.execute();
                while(isExecuting()) {
                    System.debug('Status is: ' + isExecuting());
                }
                System.debug('Call trainDataset has been executed.');
                if (client.isError()) {
                    handleError(client.getResponseError());
                } else {
                    EinsteinVision_Model model = (EinsteinVision_Model)client.getParser().readValueAs(EinsteinVision_Model.class);
                    System.debug('New Model with id ' + model.modelId + ' has been created.');
                    return model;
                }
            } else {
                System.debug('The dataset with id ' + datasetId + ' has no configured examples.');
            }
        }
        return null;
    }

    /**
     * Fetches the model for the given id.
     * @param modelId
     * The id of the model that needs to be fetched.
     * @return
     * @
     */
    public EinsteinVision_Model getModel(String modelId) {
        System.debug('Starting getModel call with parameter ' + modelId);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, TRAIN + '/' + modelId);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getModel has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Model model = (EinsteinVision_Model)client.getParser().readValueAs(EinsteinVision_Model.class);
            System.debug('Model status has been read.');
            return model;
        }
        return null;
    }

   /**
     * Gets the learning curve of a model.
     * @param modelMetricsId
     * The model id for which the learning curve should be fetched.
     * @return
     * @
     */
    public EinsteinVision_ModelLearningCurve[] getModelLearningCurve(String modelMetricsId) {
        System.debug('Starting getModelLearningCurve call with parameter ' + modelMetricsId);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, BASE_URL + MODELS + '/' + modelMetricsId + '/lc');
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getModelLearningCurve has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_ModelLearningCurve[] modelLearningCurve = (EinsteinVision_ModelLearningCurve[])client.getParser().readValueAs(EinsteinVision_ModelLearningCurve[].class);
            System.debug('ModelLearningCurve has been read.');
            return modelLearningCurve;
        }
        return null;
    }

    /**
     * Gets the metrics of a model.
     * @param modelMetricsId
     * The model id for which the metrics should be fetched.
     * @return
     * @
     */
    public EinsteinVision_ModelMetrics getModelMetrics(String modelMetricsId) {
        System.debug('Starting getModelMetrics call with parameter ' + modelMetricsId);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, BASE_URL + MODELS + '/' + modelMetricsId);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getModelMetrics has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_ModelMetrics modelMetrics = (EinsteinVision_ModelMetrics)client.getParser().readValueAs(EinsteinVision_ModelMetrics.class);
            System.debug('ModelMetrics have been read.');
            return modelMetrics;
        }
        return null;
    }

    /**
     * Gets all trained EinsteinVision_Models that are trained for the given EinsteinVision_Dataset.
     * @param dataset
     * The EinsteinVision_Dataset to which the EinsteinVision_Models are assigned.
     * @return
     * @
     */
    public EinsteinVision_Model[] getModels(EinsteinVision_Dataset dataset) {
        return getModels(dataset.id);
    }

    /**
     * Gets all trained EinsteinVision_Models that are trained for the given EinsteinVision_Dataset.
     * @param datasetId
     * The EinsteinVision_Dataset id to which the EinsteinVision_Models are assigned.
     * @return
     * @
     */
    public EinsteinVision_Model[] getModels(Long datasetId) {
        System.debug('Starting getModels call');
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, DATASETS + '/' + datasetId + '/models');
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getModels has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_Model[] models = (EinsteinVision_Model[])client.getParser().readValueAs(EinsteinVision_Model[].class);
            System.debug('Models have been read.');
            return models;
        }
        return null;
    }

    /**
     * Predicts the association of the given image in Base64 format to a trained model.
     * @param model
     * The EinsteinVision_Model that should be used for the prediction.
     * @param base64
     * The image that should be predicted.

     * @param sampleId
     * Optional. A string that gets returned as an association with the predicted image.
     * @return
     * @
     */
    public EinsteinVision_PredictionResult predictBase64(EinsteinVision_Model model, String base64, String sampleId) {
        return predictBase64(model.modelId, base64, sampleId);
    }

    /**
     * Predicts the association of the given image in Base64 format to a trained model.
     * @param modelId
     * The EinsteinVision_Model id that should be used for the prediction.
     * @param base64
     * The image that should be predicted.
     * @param sampleId
     * Optional. A string that gets returned as an association with the predicted image.
     * @return
     * @
     */
    public EinsteinVision_PredictionResult predictBase64(String modelId, String base64, String sampleId) {
        System.debug('Starting predict call with model ' + modelId + ' for base64');
        EinsteinVision_HttpBodyPartPrediction parts = new EinsteinVision_HttpBodyPartPrediction(modelId, base64, sampleId, EinsteinVision_HttpBodyPartPrediction.Types.BASE64);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, PREDICT, parts.build());
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call predict has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_PredictionResult predictions = (EinsteinVision_PredictionResult)client.getParser().readValueAs(EinsteinVision_PredictionResult.class);
            System.debug('Image has been predicted.');
            return predictions;
        }
        return null;
    }

    /**
     * Predicts the association of the given image in a file blob to a trained model.
     * @param model
     * The EinsteinVision_Model that should be used for the prediction.
     * @param fileBlob
     * The image blob for the prediction.
     * @param sampleId
     * Optional. A string that gets returned as an association with the predicted image.
     * @return
     * @
     */
    public EinsteinVision_PredictionResult predictBlob(EinsteinVision_Model model, Blob fileBlob, String sampleId) {
        return predictBlob(model.modelId, fileBlob, sampleId);
    }

    /**
     * Predicts the association of the given image on the local file system to a trained model.
     * @param modelId
     * The Model id that should be used for the prediction.
     * @param fileBlob
     * The image blob for the prediction.
     * @param sampleId
     * Optional. A string that gets returned as an association with the predicted image.
     * @return
     * @
     */
    public EinsteinVision_PredictionResult predictBlob(String modelId, Blob fileBlob, String sampleId) {
        System.debug('Starting predict call with model ' + modelId + ' for blob');
        EinsteinVision_HttpBodyPartPrediction parts = new EinsteinVision_HttpBodyPartPrediction(modelId, EncodingUtil.base64Encode(fileBlob), sampleId, EinsteinVision_HttpBodyPartPrediction.Types.BASE64);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, PREDICT, parts.build());
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call predict has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_PredictionResult predictions = (EinsteinVision_PredictionResult)client.getParser().readValueAs(EinsteinVision_PredictionResult.class);
            System.debug('Image has been predicted.');
            return predictions;
        }
        return null;
    }

    /**
     * Predicts the association of the given image on a remote url to a trained model.
     * @param model
     * The EinsteinVision_Model that should be used for the prediction.
     * @param url
     * The absolute url of the image.
     * @param sampleId
     * Optional. A string that gets returned as an association with the predicted image.
     * @return
     * @
     */
    public EinsteinVision_PredictionResult predictUrl(EinsteinVision_Model model, String url, String sampleId) {
        return predictUrl(model.modelId, url, sampleId);
    }

    /**
     * Predicts the association of the given image on a remote url to a trained model.
     * @param modelId
     * The Model id that should be used for the prediction.
     * @param url
     * The absolute url of the image.
     * @param sampleId
     * Optional. A string that gets returned as an association with the predicted image.
     * @return
     * @
     */
    public EinsteinVision_PredictionResult predictUrl(String modelId, String url, String sampleId) {
        System.debug('Starting predict call with model ' + modelId + ' for url');
        EinsteinVision_HttpBodyPartPrediction parts = new EinsteinVision_HttpBodyPartPrediction(modelId, url, sampleId, EinsteinVision_HttpBodyPartPrediction.Types.URL);
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, PREDICT, parts.build());
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while(isExecuting()) {
            System.debug('Status is: ' + isExecuting());
        }
        System.debug('Call predict has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_PredictionResult predictions = (EinsteinVision_PredictionResult)client.getParser().readValueAs(EinsteinVision_PredictionResult.class);
            System.debug('Image has been predicted.');
            return predictions;
        }
        return null;
    }
    
   /**
     * Fetches data about the API usage of the authenticated PredictionService.
     * @return
     * An array of all EinsteinVision_ApiUsage elements.
     */
    public EinsteinVision_ApiUsage[] getApiUsage() {
        System.debug('Starting getApiUsage call');
        EinsteinVision_HttpClient client = new EinsteinVision_HttpClient(this, API_USAGE);
        System.debug('Target URL is ' + client.getUrl());
        client.execute();
        while (isExecuting()) {
            System.debug('Status is: ' + isExecuting() );
        }
        System.debug('Call getApiUsage has been executed.');
        if (client.isError()) {
            handleError(client.getResponseError());
        } else {
            EinsteinVision_ApiUsage[] apiUsage = (EinsteinVision_ApiUsage[])client.getParser().readValueAs(EinsteinVision_ApiUsage[].class);
            System.debug('API usage has been fetched.');
            return apiUsage;
        }
        return null;
    }

    /**
     * 
     * @return
     */
    public boolean isExecuting() {
        return isExecuting;
    }

    /**
     * 
     * @param isExecuting
     */
    public void isExecuting(boolean isExecuting) {
        this.isExecuting = isExecuting;
    }

    /**
     * 
     * @param message
     */
    private void handleError(String message) {
        System.debug(LoggingLevel.Error, 'Response finished with Error: ' + message);
    }

    /**
     * 
     * @return
     */
    public String getBearerToken() {
        return bearerToken;
    }

}