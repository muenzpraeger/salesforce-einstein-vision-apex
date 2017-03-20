public class EinsteinVision_HttpBodyPartDataset extends EinsteinVision_HttpBodyPart {

    private String name;
    private String labels;
    
    public EinsteinVision_HttpBodyPartDataset(String name, String[] labels)  {
        if (name==null || name.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('name');
        }
        if (name.length()>180) {
            throw new EinsteinVision_StringTooLongException('name', 180, name.length());
        }
        if (labels==null) {
            throw new EinsteinVision_NullPointerException('Labels cannot be null');
        }
        if (labels.size()==0) {
            throw new EinsteinVision_NoValuesException('labels');
        }
        if (labels.size()>1000) {
            throw new EinsteinVision_TooManyValuesException('labels', 1000, labels.size());
        }
        this.name = name;
        this.labels = String.join(labels, ',');
    }
    
    public Blob build() {
        String body = '';
        body += WriteBoundary();
        body += WriteBodyParameter('name', name);
        body += WriteBoundary();
        body += WriteBodyParameter('labels', labels);
        body += WriteBoundary(EndingType.CrLf);
        Blob bodyBlob = EncodingUtil.base64Decode(body);
        return bodyBlob;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name)  {
        if (name==null || name.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('name');
        }
        if (name.length()>180) {
            throw new EinsteinVision_StringTooLongException('name', 180, name.length());
        }
        this.name = name;
    }
    
    public String getLabels() {
        return labels;
    }

    public void setLabels(String[] labels)  {
        if (labels==null) {
            throw new EinsteinVision_NullPointerException('Labels cannot be null');
        }
        if (labels.size()==0) {
            throw new EinsteinVision_NoValuesException('labels');
        }
        if (labels.size()>1000) {
            throw new EinsteinVision_TooManyValuesException('labels', 1000, labels.size());
        }
        this.labels = String.join(labels, ',');
    }
    
}