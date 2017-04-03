public class EinsteinVision_HttpBodyPartExample extends EinsteinVision_HttpBodyPart {

    private long labelId;
    private String data;
    private String name;
    
    public EinsteinVision_HttpBodyPartExample(String name, long labelId, String data) {
        if (name==null || name.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('name');
        }
        if (name.length()>180) {
            throw new EinsteinVision_StringTooLongException('name', 180, name.length());
        }
        if (labelId<1) {  
            throw new EinsteinVision_NullPointerException('Labels cannot be null');
        }
        if (data==null || data.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('data');
        }
        this.name = name;
        this.data = data;
        this.labelId = labelId;
    }
    
    public Blob build() {
        String body = '';
        body += WriteBoundary();
        body += WriteBodyParameter('name', name);
        body += WriteBoundary();
        body += WriteBodyParameter('labelId', String.valueOf(labelId));
        body += WriteBoundary();
        body += WriteBlobBodyParameter('data', data, name);
        body += WriteBoundary(EndingType.CrLf);
        Blob bodyBlob = EncodingUtil.base64Decode(body);
        return bodyBlob;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name==null || name.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('name');
        }
        if (name.length()>180) {
            throw new EinsteinVision_StringTooLongException('name', 180, name.length());
        }
        this.name = name;
    }

    public long getLabelId() {
        return labelId;
    }

    public void setLabelId(long labelId) {
        if (labelId<1) {
            throw new EinsteinVision_NullPointerException('Labels cannot be null');
        }
        this.labelId = labelId;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        if (data==null || data.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('data');
        }
        this.data = data;
    }
    
}