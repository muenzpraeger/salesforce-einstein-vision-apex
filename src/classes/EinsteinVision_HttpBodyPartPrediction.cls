public class EinsteinVision_HttpBodyPartPrediction extends EinsteinVision_HttpBodyPart {
    
    public enum Types {
        BASE64,
        FILEBLOB,
        URL
    }
    
    private String modelId;
    private String data;
    private String sampleId;
    private Types type;
    
    public EinsteinVision_HttpBodyPartPrediction(String modelId, String data, String sampleId, Types type) {
        this.modelId = modelId;
        this.data = data;
        this.sampleId = sampleId;
        this.type = type;
    }
    
    public Blob build() {
        String body = '';
        body += WriteBoundary();
        body += WriteBodyParameter('modelId', modelId);
        if (sampleId!=null && !sampleId.equals('')) {
            body += WriteBoundary();
            body += WriteBodyParameter('sampleId', sampleId);
        }
        body += WriteBoundary();
        if (type==Types.BASE64) {
            body += WriteBodyParameter('sampleBase64Content', data);
        } else if (type==Types.URL) {
            body += WriteBodyParameter('sampleLocation', data);
        }
        body += WriteBoundary(EndingType.CrLf);
        Blob bodyBlob = EncodingUtil.base64Decode(body);
        return bodyBlob;
    }
    
    public String getModelId() {
        return modelId;
    }

    public void setModelId(String modelId) {
        this.modelId = modelId;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getSampleId() {
        return sampleId;
    }

    public void setSampleId(String sampleId) {
        this.sampleId = sampleId;
    }

    public Types getType() {
        return type;
    }

    public void setType(Types type) {
        this.type = type;
    }

}