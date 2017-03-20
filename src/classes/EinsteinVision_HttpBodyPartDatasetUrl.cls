public with sharing class EinsteinVision_HttpBodyPartDatasetUrl extends EinsteinVision_HttpBodyPart {

    private String url;
    
    public EinsteinVision_HttpBodyPartDatasetUrl(String url)  {
        if (url==null || url.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('url');
        }
        this.url = url;
    }
    
    public Blob build() {
        String body = '';
        body += WriteBoundary();
        body += WriteBodyParameter('path', url);
        body += WriteBoundary(EndingType.CrLf);
        Blob bodyBlob = EncodingUtil.base64Decode(body);
        return bodyBlob;
    }
    
    public String getUrl() {
        return url;
    }

    public void setUrl(String url)  {
        if (url==null || url.equals('')) {
            throw new EinsteinVision_StringIsEmptyException('url');
        }
        this.url = url;
    }
    
}