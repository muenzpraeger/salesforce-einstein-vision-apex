public class EinsteinVision_HttpBodyPartLabel extends EinsteinVision_HttpBodyPart {
    
    private String name;
    
    public EinsteinVision_HttpBodyPartLabel(String name) {
        if (name==null || name.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('name');
        }
        if (name.length()>180) {
            throw new EinsteinVision_StringTooLongException('name', 180, name.length());
        }
        this.name = name;
    }
    
    public Blob build() {
        String body = '';
        body += WriteBoundary();
        body += WriteBodyParameter('name', name);
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
    
}